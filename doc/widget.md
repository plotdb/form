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

 - `init()`: initialization
 - `fire(name,...args)`: for firing event.
 - `on(name, cb(...args))`: handle event `name` with `cb` callback function, providing `args` arguments.
 - `render()`: shorthand for firing `render` event when something needs to be updated.
 - `validate()`: force re-validating user input. return Promise, which resolves to list of errors ( if any )
 - `mode(v)`: set widget mode, to `v`, which is either `edit` or `view`. return current mode if `v` is omitted.
 - `serialize()`: consider renaming to `config`, merge with `deserialize()`
 - `deserialize()`
 - `errors()`
 - `opsets()`
 - `data()`
 - `value()`
 - `adapt()`: apply programmatic options such as uploadr?


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

 - `title`: a short description about purpose of this widget
 - `desc`: a longer description about purpose of this widget
 - `key`: unique key identifying this widegt
 - `alias`: alias of key, for semantic meaning. should also be unique.
   - for example, to locate a widget for phone number, we can search for widgets with `phone` alias.
   - useful when we lost old widget meta but want to associate old values with newly created widget.
 - `config`: basic config including
   - `isRequired`
   - `isPublic`
 - `term`: Array of `op.term` objects. should be serialized when stored as data.

additional fields ( TBD )

 - `hint`: additional hint supposed to be shown after certain interaction
 - `default`: default value
 - `placeholder`: placeholder value
 - `ext`: widget specific configuration


### value

value ( user input ) can be anything ( string, number or object ) and is defined by implementation of specific widget. 


## Mod

 - init
 - render
 - is-empty
 - validate
## base widget

TODO
