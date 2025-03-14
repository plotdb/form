# widget

`widget` ( `form.widget` ) is an interface between form manager and UI.


## Constructor Options

 - `root`: root element of this widget. either an instance of Element, or CSS selector string.
 - `mode`: default `edit`. check the `mode` constructor option in `manager.md` for more information.
 - `opsets`: Array of opsets to use. Each opset can be one of:
   - `form.opset` object
   - opset config object.
   - id of opset.
 - `mod`: modifier that extend `form.widget`. Described below.
 - `meta`: configuration of this widget. Described below.
 - `value`: value of this widget. Described below.
 - `validate(v)`: (TBD) optional. validate the given value manually.


## API

 - `init()`: initialization
 - `root()`: get root element of this widget
 - `fire(name,...args)`: for firing event.
 - `on(name, cb(...args))`: handle event `name` with `cb` callback function, providing `args` arguments.
 - `render()`: shorthand for firing `render` event when something needs to be updated.
 - `status(v)`: get or set current status of this widget. value definition is the same with `ldform`:
   - 0: valid
   - 1: untouched ( not yet edit )
   - 2: invalid
   - 3: editing
   - 4 ~ 9: preserved
   - 10 and above: user defined.
 - `validate(opt)`: force re-validating user input.
   - return Promise, which resolves to list of errors ( if any ), or an object with following fields:
     - `status`: expected status
     - `errors`: list of errors ( if any )
   - options in opt:
     - `init`: true if this validation attempt is triggered by initial input ( e.g., deserialize ).
     - `force`: true if this validation attempt is triggered by intentional user action.
     - `now`, `skipEmpty`: options from `check` if called from `check`.
       - this is provided for customized validators passing
 - `serialize()`: (TBD)consider renaming to `config`, merge with `deserialize()`
 - `deserialize(meta, opt)`: return a Promise which resolves when validation completes.
   - parameters:
     - `meta`: widget meta. See `meta` section for detail definition.
     - `opt`: an object with following fields:
       - `init`: default false. when true, will init value if needed and validate with `init` set to true.
 - `errors()`
 - `opsets()`
 - `data()`
 - `value(v, opt)`: set/get value
   - return value:
     - get: return the value stored in this widget.
     - set: a Promise which resolves when validation completes.
   - options:
     - `v`: value to set. call `value` without parameters to get its value.
     - `opt`: additional options, including:
       - `from-source`: called from source, should fire change event.
       - `init`: this is for initialization. won't trigger status change ( leave it as `1` )
 - `content(v)`: get content from this widget.
   - get content from v if v is provided, otherwise from `value()`
   - concept of `content` is defined by widget, and will be used in validation.
   - for example, string get from input field is content, but widget may wrap this content in an object, which is defined as value here.
   - see also `mod.content` in following section.
 - `isEmpty(v): check for emptiness of a given value
   - get content from v if v is provided, otherwise from `value()`
   - see also `mod.isEmpty` in following section.
 - `isEqual(u,v): check for emptiness of a given value
   - return true if `u` and `v` are equivalent.
   - when `v` is omitted, internal value is used to compare against `u`
   - see also `mod.isEqual` in following section.
 - `adapt()`: apply programmatic options such as uploadr?
 - `mode(v)`:
   - setting mode triggers validation. return a Promise which resolves when validation completes.
   - set widget mode to `v`, return current mode if `v` is omitted.
   - check constructor options for possible values of mode.
 - `manager()`: return form manager(s) used by this widget.
   - return value: a list of form managers (an empty array is returned if no such manager available)

## Events

 - `change`: fired when value is changed.
 - `status`: fired when status is changed, with following argument:
   - `status`: new status
 - `render`: fired when widget is going to re-rendered.
 - `mode`: fired when mode is changed.
 - `meta`: fired when metadata is (potentially) changed.
 - `init`: fired when widget is inited, including deserializing with `init` option set to true.
 - `config`: fired when metadata is changed due to editor configuring. (TBD)
 - `manager.changed`: fired when manager list updated.
   - `mod` developer is responsible for firing this event if mod updates formmgr list.

Since widgets are customizable, so as events. To use customized events, prefix event name with `widget`, such as:

    widget.on("widget.widget-specific-event", function () { ... })


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
 - `desc`: a longer description about purpose of this widget. optional
 - `tag`: an array of strings representing tags about this widget. optional
 - `key`: unique key identifying this widget
 - `alias`: alias of key, for semantic meaning. should also be unique.
   - for example, to locate a widget for phone number, we can search for widgets with `phone` alias.
   - useful when we lost old widget meta but want to associate old values with newly created widget.
 - `isRequired`: true if this widget should not be left empty.
 - `disabled`: if true, manager will ignore this widget.
 - `readonly`: true if user can edit its value
 - `defaultValue`: default value for this widget
 - `term`: Array of `op.term` objects. should be serialized when stored as data.


additional fields ( TBD )

 - `hint`: additional hint supposed to be shown after certain interaction
 - `placeholder`: placeholder value
 - `ext`: widget specific configuration


### value

value ( user input ) can be anything ( string, number or object ) and is defined by implementation of specific widget.


## Mod

mod is a set of functions that can be provided to `widget` for advanced functionality. These functions are called with `widget` as its context so you can access `widget` API directly with `this`.

 - `init()`: initialization
 - `render()`: called after switching mode, setting values or validating, for re-rendering
 - `isEmpty(v)`: provide `isEmpty` check above basic check against undefined or '' values.
   - if omitted, by default a value is empty if a value is undefined or is an empty string ( '' ).
 - `isEqual(u,v)`: compare `u`, `v` and only return true if `u` and `v` are equivalent.
 - `validate(opt)`: optional. content valiadator.
   - see `validate` in API for detail explanation of `opt`.
   - when provided, it should also update status manually with `status()`
   - return value: a list of errors, optionally in Promise, or an object with following fields:
     - `status`: expected status
     - `errors`: list of errors ( if any )
       - see `errors` section below for more information
   - even if provided, `widget` will still validate its emptyness and terms (if any) unless status 3 is returned.
 - `content(v)`: return semantic content instead of structure content.
   - if omitted, return the value from `value()` directly
   - return value may still be a structured data such as array or object, if widget intetionally does this.
     - however all the returned value should be considered as "content".
   - `@plotdb/form` validator use this to get value for validation.
 - `config`: config definition in `@plotdb/konfig` spec. ( TBD )
 - `manager()`: optional. if provided, return form manager(s) used in this widget is any.
   - return a form manager (or a list of that) used by this widget to manage child widgets.
   - note that `widget.manager()` always returns an array (even if empty) to users by converting result from here automatically.
 - `readonly()`: return true if this widget is readonly.
 - `disabled()`: return true if this widget is disabled.
 - `opsets`: optional, a list of dedicated opsets available for this widget.
   - You can specify an opset without `id` or `name` here as a fallback opset,
     used along with terms wit `opset` left empty.


## errors

Errors returned by `validate()` are usually string of messages indicating the reason of failure. However, following strings are reserved for special purpose:

 - `error`: a generic error.
 - `required`: this field is required.
 - `nested`: there are errors from widgets in nested formmgr
   - this error should trigger nested formggr lookup and will itslef be ignored then.


## base widget

TODO
