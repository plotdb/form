# @plotdb/form

`@plotdb/form` is a form management package with following feature:

 - form construction with block-based widget
 - serializable form spec and filled data

It includes following modules:

 `form.manager`: a recursive manager of a set of widgets.
 `form.widget`: a form widget as a bridge between user and manager.
 `form.opset` and `form.op`: operation set and individual operations for validating given inputs from users.
 `form.term`: validation rule with configs including used opset/op and corresponding configurations.
 `form.condctrl`: controller for form dynamics based on given conditions.


For more information, check markdown document for corresponding modules under `docs/` folder.


## Simple Usage

    mgr = form.manager!
    # prepare a widget
    widget = new form.widget({root: ...})
    <~ widget.init!then _
    widget.deserialize({isRequired: true}, {init: true})
    mgr.add {widget, path: "name"}
    mgr.on \change, -> console.log mgr.value!
    # use condition control
    mgr.condition!reset conditions: [{src: "name", config: {value: "dummy", path: [...]}}]


## License

MIT
