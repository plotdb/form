pkg: do
  name: "single-choice", version: "0.0.1"
  extend: name: "base", version: "0.0.1"
  license: "MIT"
  description: ""
  dependencies: []
  i18n: {}
init: ({root,parent,context,pubsub}) ->
  {ldview} = context
  pubsub.fire \init, {opsets: <[string number]>, mod: is-empty: -> !("#{it}".trim!length)}
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
              action: input: input: ({node}) -> widget.value node.value, true
              text: name: ({ctx}) -> ctx.name
              handler:
                input: ({node, ctx}) ->
                  node.setAttribute \name, widget.key!
                  node.setAttribute \value, ctx.name
                  node.checked = (ctx.name == widget.value!)
      widget.on \change, -> view.render!
      widget.on \render, -> view.render!
