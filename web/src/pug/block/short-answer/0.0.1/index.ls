pkg: do
  name: "short-answer", version: "0.0.1"
  extend: name: "base", version: "0.0.1"
  license: "MIT"
  description: ""
  dependencies: [
    "https://cdnjs.cloudflare.com/ajax/libs/marked/1.2.7/marked.min.js"
    "https://cdnjs.cloudflare.com/ajax/libs/dompurify/2.2.6/purify.min.js"
  ]
  i18n:
    "zh-TW": {
      "input value": "輸入數值 ..."
    }
init: ({root,parent,context,pubsub}) ->
  {dompurify,marked,ldview} = context
  pubsub.on \change, -> view.get(\input-field).value = it
  view = new ldview do
    root: parent.node!
    action: input: 'input-field': ({node}) ->
      parent.value node.value, true
