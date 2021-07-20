# widget

`widget` ( `form.widget` ) is an interface between form manager and UI.


## Constructor Options

 - `root`: root element of this widget. either an instance of Element, or CSS selector string.
 - `mode`: mode, either `edit` or `view`. default `view`.
 - `opsets`: Array of opsets to use. Each opset can be one of:
   - `form.opset` object
   - opset config object.
   - id of opset.
 - `mod`: modifier that extend `form.widget`. Described below.
 - `meta`: configuration of this widget. Described below.
 - `value`: value of this widget. Described below.


## API

 - `fire(name,...args)`: for firing event.
 - `on(name, cb(...args))`: handle event `name` with `cb` callback function, providing `args` arguments.
 - `render()`: shorthand for firing `render` event when something needs to be updated.
 - `validate()`: force re-validating user input. return Promise, which resolves to list of errors ( if any )
 - `mode(v)`: set widget mode, to `v`, which is either `edit` or `view`. return current mode if `v` is omitted.
 - `serialize()`
 - `deserialize()`
 - `errors()`
 - `opsets()`
 - `data()`
 - `value()`


## Events

 - `change`
 - `render`


## Internal members

 - `_data`
 - `_errors`
 - `_opsets`
 - `_value`
 - `_mode`


## Extension

 - `mod`
 - `_custom`


## meta and value

There are 2 types of widget data:

 - `meta`: widget metadata, define how this widget works, like `key`, `term`, `title`, `isPublic`, etc.
 - `value`: user input.

meta should be only editable by administrator. value is inputed by expected end users who are provided with this form.

### meta

 - `title`, `desc`: as their name
 - `key`: unique key identifying this widegt
 - `alias`: alias of key, for semantic meaning. should also be unique.
   - for example, to locate a widget for phone number, we can search for widgets with `phone` alias.
   - useful when we lost old widget meta but want to associate old values with newly created widget.
 - `config`: basic config including
   - `isRequired`
   - `isPublic`
 - `term`: Array of `op.term` objects. should be serialized when stored as data.

