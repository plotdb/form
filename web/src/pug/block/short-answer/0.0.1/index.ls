pkg: do
  name: "@plotdb/short-answer", version: "0.0.1"
  extend: name: "base", version: "0.0.1"
  license: "MIT"
  description: ""
  dependencies: [
    "https://cdnjs.cloudflare.com/ajax/libs/marked/1.2.7/marked.min.js"
    "https://cdnjs.cloudflare.com/ajax/libs/dompurify/2.2.6/purify.min.js"
  ]
init: ({root,context}) ->
  {dompurify,marked,ldview} = context
  @block = {}
  @view = view = new ldview do
    root: root.querySelector('[plug=view]')
    action:
      input: do
        "input-field": ({node,views}) ~>
          @block.{}value.content = node.value
          views.0.render!
    handler: do
      "edit-only": ({node}) -> node.classList.toggle \d-none, mode != \edit
      "input-field": ({node}) ~> node.value = @block.{}value.content or ''
