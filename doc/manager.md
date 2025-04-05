# form.manager

A manager for oversee widget status.


## Usage

    fm = new form.manager(opt)

Constructor options:

 - `mode`: default `edit`. Meaning of mode:
   - `edit`: user can input values
   - `view`: read-only mode for printing or browsing
   - `config`: tweak,widget. for form design purpose. ( TBD )
 - `mod`: extension object with following fields:
   - `afterCheck()`: called by `afterCheck`. can use to overwrite overall status.


Instance API:

 - `on(n, cb)`: watch event `n` and handle with callback `cb`
 - `fire(n, ...args)`: fire event `n` with args passing to `cb` in the above watcher
 - `add(o)`: add an widget. option `o` is an object with following fields:
   - `widget`: an `form.widget` instance
   - `path`: path to add. dot separated string for constructing a JSON object.
     - TBD we may also use ot path.
 - `remove(o)`: remove an widget from a specific path. option `o` is an object with following fields:
   - `path`: path to remove.
 - `widget(p)`: get `form.widget` from given path `p`. return null if nothing is found.
 - `afterCheck()`: check overall status after each `check` call.
   - It's a debounced function. Call it immediately by `afterCheck().now()`.
     - check `@loadingio/debounce.js` for more information.
 - `check(o, opt)`: validate widgets that match given `o`
   - return a Promise that resolves to following value:
     - `null` if check passed. otherwise:
     - return a list of below object, if this check is against multiple widgets.
     - return object `{widget, path, status}` if only one object is checked.
   - `opt`: either a boolean or an object value. default `false`.
     - boolean: `check` debounces if it's false, set `opt` to true to enforce check immediately.
       - this may also flush checks debounced earlier.
     - object: an object with following fields:
       - `now`: treat as the boolean value for controlling debouncing describe above.
       - `skipEmpty`: default false. when true and `o` is null, empty widgets will be skipped.
       - `force`: if true, enforce checking all widgets if necessary. passed to `validate` too.
       - `init`: check from initialization calls, may skip some warning e.g., for untouched fields.
                 passed to `validate` too.
   - o may be:
     - null;  `check` will list all widgets for checking (and skip empty widgets based on `opt` config)
     - a list of below object
     - an object with following fields:
       - `path`: path to the given widget
       - `widget`: widget to check.
       - (TBD) `now`: default `false`. when `true`, force a post-check immediately.
 - `status()`: return current status of manager ( all widgets combiined )
   - this doesn't trigger validation so status may be outdated.
   - status definition is the same with `ldform`:
     - 0: valid
     - 1: untouched ( not yet edit )
     - 2: invalid
     - 3: editing - validation of this widget isn't finished yet.
       - e.g., multi-fields composite widget with some fields untouched yet.
         ( using status 1 cause this widget to be considered valid if its `is-required` is not true,
         since we treat `untouched` as empty in `restatus` api. )
     - 4 ~ 9: preserved
     - 10 and above: user defined.
 - `progress()`: return current progress of this form. Returned value is an object with following fields:
   - `total`: total number of widgets
   - `done`: how many widgets has to be filled
   - `percent`: `done/total`. 1 when this form completes.
 - `mode(v)`: set current mode.
   - setting mode triggers validation. return Promise, resolved when validation completes.
   - set widget mode to `v`, return current mode if `v` is omitted.
   - check constructor options for possible values of mode.
 - `value(v, opt)`: set value ( recursively into each widget, based on `v` )
   - return a Promise which resolves when validation completes.
   - options:
   - `v`: an object storing values for each widget managed by this manager.
     - object always duplicated to prevent pollution due to share object.
     - (TODO) currently we don't correctly support a arbitrary JSON object, but only a single level object.
   - `opt`: additional options, including:
     - `fromSource`: DONT USE THIS. see `fromSource` in `widget.md`.
     - `init`: this is for initialization. won't trigger status change ( leave it as `1` )
     - `partial`: default false. if true, update path that only defined in `v`.
       - Please note that, without `partial = true`, value({}) means setting values of all widgets to `undefined`.
 - `content(p)`: get content from widget with path `p`.
   - for more about `content`, see cotnent in `widget` document.

## Events

 - `readystatechange`: fired when ready state change. callback function receives following parameter:
   - readystate: `true` if ready, otherwise not ready.
 - `change`: fired when there are value changes of any widgets. callback function receives following parameters:
   - object with {path, widget, value} fields:
     - `path`: path of the widget which has its value changed.
     - `widget`: widget which has its value changed.
     - `value`: the value after changed.
 - `status`: fired when there are status changes of any widget. callback function receives following parameters:
   - object with {path, widget, status} fields:
     - `path`: path of the widget which has its status changed.
     - `widget`: widget which has its status changed.
     - `status`: the status after changed.
 - `mode`: fired when mode is changed.
