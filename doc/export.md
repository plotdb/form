# Export

`@plotdb/form` provides export functionality to convert form data into structured formats suitable for spreadsheets and other tabular outputs.


## Concepts

### Flat Column Format

The canonical intermediate export format. Each record (e.g. a submitted form) is represented as an array of column objects:

```
[
  { uid, header, sort-key, value }
  ...
]
```

Fields:
- `uid` - stable string identifier for this column, constructed from widget paths and entry indices. e.g. `"member|1|name"`. Used as the merge key across records.
- `header` - human-readable column title. e.g. `"成員(1) / 姓名"`
- `sort-key` - array of numbers for stable lexicographic ordering across nested levels. e.g. `[2, 0, 0]`
- `value` - cell content as string, converted from GWV via `form.value.toString`


### Sort Key

Sort keys are hierarchical arrays built by prepending each level's DOM index:

```
root manager widget (dom-idx=2)         → [2]
  nest widget, entry 0
    sub-widget (dom-idx=0)              → [2, 0, 0]
    sub-widget (dom-idx=1)              → [2, 0, 1]
  nest widget, entry 1
    sub-widget (dom-idx=0)              → [2, 1, 0]
root manager widget (dom-idx=3)         → [3]
```

Lexicographic comparison guarantees that fields after a nest always sort after all entries of that nest, regardless of how many entries exist.


### Export Flow

```
manager.export()                 → flat column array (one record)
form.utils.merge-exports([...])  → { headers, rows } (spreadsheet-ready)
```


## API

### `form.value.toString(v)`

Converts a Generic Widget Value (GWV, see `value.md`) to a plain string for use as a spreadsheet cell value.

Handles all standard GWV shapes:
- string → itself
- null / undefined → `''`
- `{ filename }` → `filename`
- `{ key, value }` → recurse on `value`
- `{ list, other }` → join list items and `other.text` if enabled
- `{ list }` → join list items recursively
- `{ v }` → recurse on `v`
- anything else → `JSON.stringify`

The `form.value` namespace is the intended scope for GWV-related utilities, providing a natural extension point for future operations (e.g. `form.value.toHTML`, `form.value.compare`).


### `manager.export()`

Returns a flat column array representing the current state of all widgets owned by this manager.

Behaviour:
- Iterates widgets in DOM order (using the same traversal as `order()`)
- For each widget, calls `widget.export()` and prepends the widget's DOM index to `sort-key`, and its path key to `uid`
- Does **not** directly recurse into child managers; that is delegated to `widget.export()`
- Returns columns sorted by `sort-key`


### `widget.export()`

Returns a flat column array for this widget's contribution to the export.

Default implementation (fallback for widgets that do not define `mod.export`):
- Returns a single column using `form.value.toString(widget.value())` as the cell value
- `uid` is `""` (the manager prepends the widget's own path)
- `sort-key` is `[]` (the manager prepends the DOM index)
- `header` is `widget._meta.title`

Widgets with child managers (e.g. `@makeform/nest`) **must** implement `mod.export` to expand their sub-fields. Without it, the entire nested GWV is collapsed into a single cell and sub-field ordering is lost.

Custom `mod.export` is responsible for:
- Calling child managers' `export()` for each entry
- Prepending entry index to `sort-key` (list mode)
- Constructing `uid` and `header` for each sub-column


### `form.utils.merge-exports(records)`

Merges an array of flat column arrays (one per record) into a spreadsheet-ready structure.

```
form.utils.merge-exports(records)
→ { headers: [string], rows: [[string]] }
```

- `headers` - ordered list of column header strings (union of all records' columns, sorted by sort-key)
- `rows` - one array per record; values aligned to `headers`; missing columns filled with `''`

Steps:
1. Collect all unique `uid`s across all records
2. Sort by the first-seen `sort-key` for each `uid`
3. For each record, map values by `uid`; fill `''` for absent columns


## Extension

To support export in a custom widget, implement `mod.export`:

```livescript
mod.export = ->
  # return flat column array
  # sort-key and uid here are relative (internal only)
  # the parent manager will prepend its own dom-idx and path key
  [{
    uid: "my-sub-field"
    header: "My Sub Field"
    sort-key: [0]
    value: form.value.toString @value!
  }]
```

For widgets with child managers (like nest), iterate each manager and prepend entry context:

```livescript
mod.export = ->
  cols = []
  child-managers.map (mgr, i) ->
    mgr.export!.map (col) ->
      col.sort-key = [i] ++ col.sort-key
      col.uid      = "#{i + 1}|#{col.uid}"
      col.header   = "(#{i + 1}) / #{col.header}"
    cols ++= that
  cols
```
