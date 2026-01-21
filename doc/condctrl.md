# form.condctrl

Condition controller.

given a condition list, an array of objects with following fields:

 - `src`: path of the widget to test value. omitted if `func` is provided.
 - `values`: condition will be active if `values` match value of widget in path 
 - `func(cfg)`: condition will be active if this custom function return true, otherwise inactive
 - `config`
   - `path`: list of paths of the widget to be affected
     - path can either a string or an array of string for recursively into sub formmgr.
   - `prefix`: all widgets with path begins with this prefix will be affected.
   - `tag`: all widgets with tag in this this will be affected.
   - `enabled`: enable(true) or disable(false) when active; otherwise reversed
   - `required`: required(true) or optional(false) when active; otherwise reversed.
   - `readonly`: readonly(true) or editable(false) when active; otherwise reversed.

