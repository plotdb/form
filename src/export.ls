form.value =
  toString: (v) ->
    list2str = (list) ->
      if list.0 and list.0.key? and list.0.value? =>
        list.map(-> form.value.toString it.value).join ' / '
      else list.map(-> form.value.toString it).join ' / '
    if typeof v == \string => v
    else if !v? => ''
    else if Array.isArray(v) => list2str v
    else if v.filename => v.filename
    else if v.key? and v.value? => form.value.toString v.value
    else if v.list and v.other =>
      parts = (v.list or []).map -> form.value.toString it
      if v.other.enabled and v.other.text => parts ++= [v.other.text]
      parts.join ' / '
    else if v.list and Array.isArray v.list => list2str v.list
    else if v.v? => form.value.toString v.v
    else JSON.stringify v

form.utils =
  lex-compare: (a, b) ->
    for i from 0 til Math.max a.length, b.length
      if !a[i]? and b[i]? => return -1
      if a[i]? and !b[i]? => return 1
      if !a[i]? and !b[i]? => return 0
      if a[i] != b[i] => return a[i] - b[i]
    0

  merge-exports: (records) ->
    uid-map = {}
    records.map (cols) ->
      cols.map (col) ->
        if !uid-map[col.uid] => uid-map[col.uid] = col{uid, header, sort-key}
    headers = [{k, v} for k, v of uid-map]
      .sort (a, b) -> form.utils.lex-compare a.v.sort-key, b.v.sort-key
    rows = records.map (cols) ->
      val-map = {}
      cols.map -> val-map[it.uid] = it.value
      headers.map -> val-map[it.k] or ''
    {headers: headers.map(-> it.v.header), rows}
