pkg: do
  name: "short-answer", version: "0.0.1"
  extend: name: "base", version: "0.0.1"
  license: "MIT"
  description: ""
  dependencies: []
  i18n:
    "zh-TW": {
      "input value": "輸入數值 ..."
    }
init: ({root,parent,context,pubsub}) ->
  {ldview} = context
  pubsub.fire \init, {opsets: <[string number]>}
    .then (opt = []) ->
      {widget, node} = opt.0
      #pubsub.on \change, -> view.get(\input-field).value = it
      widget.on \change, ->
        console.log 123, it
        view.get(\input-field).value = it
      view = new ldview do
        root: node.view
        action: input: 'input-field': ({node}) ->
          widget.value node.value, !node.value, true
