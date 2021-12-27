module.exports =
  pkg:
    name: "multi-choice", version: "0.0.1"
    extend: name: "base", version: "0.0.1"
    license: "MIT"
    description: ""
    dependencies: []
    i18n: {}
  init: ({root,parent,context,pubsub}) ->
    {ldview} = context
    pubsub.fire \init, {opsets: <[]>, mod: is-empty: -> !((it or []).length)}
      .then (opt = []) ->
        {widget, node} = opt.0
        items = [
          * name: 'option 1'
          * name: 'option 2'
          * name: 'option 3'
          * name: 'option 4'
        ]
        view = new ldview do
          root: node.view
          handler:
            item:
              list: -> items
              view:
                action: input: input: ({node}) ->
                  v = widget.value! or []
                  if (node.value in v) => return
                  v.push node.value
                  widget.value v, true
                text: name: ({ctx}) -> ctx.name
                handler:
                  input: ({node, ctx}) ->
                    node.setAttribute \name, widget.key!
                    node.setAttribute \value, ctx.name
                    node.checked = ctx.name in (widget.value! or [])
        widget.on \change, -> view.render!
        widget.on \render, -> view.render!
