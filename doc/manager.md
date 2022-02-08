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
   - It's a debounced function. Call it immediately by `afterCheck.now()`.
 - `check(o, now)`: validate widgets that match given `o`
   - `now`: default `false`. `check` debounces without now, set now to true to enforce check immediately.
     - this may also flush checks debounced earlier.
   - o may be:
     - a list of below object
     - an object with following fields:
       - `path`: path to the given widget
       - `widget`: widget to check.
       - `now`: default `false`. when `true`, force a post-check immediately.
 - `status()`: return current status of all widgets. status definition is the same with `ldform`:
   - 0: valid
   - 1: untouched ( not yet edit )
   - 2: invalid
   - 3: editing
   - 4 ~ 9: preserved
   - 10 and above: user defined.
 - `progress()`: return current progress of this form. Returned value is an object with following fields:
   - `total`: total number of widgets
   - `done`: how many widgets has to be filled
   - `percent`: `done/total`. 1 when this form completes.
 - `mode(v)`:
   - set widget mode to `v`, return current mode if `v` is omitted.
   - check constructor options for possible values of mode.


## Events

 - `readystatechange`: fired when ready state change. callback function receives following parameter:
   - readystate: `true` if ready, otherwise not ready.
 - `status`: fired when there are status changes of any widget. callback functino receives following parameter:
   - object with {path, widget, status} fields:
     - `path`: path of the widget which has its status changed.
     - `widget`: widget which has its status changed.
     - `status`: the status after changed.
 - `mode`: fired when mode is changed.
