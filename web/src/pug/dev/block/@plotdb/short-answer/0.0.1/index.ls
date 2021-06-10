pkg: do
  author: "zbryikt"
  name: "@plotdb/short-answer"
  version: "0.0.1"
  extend: "@plotdb/formbase@0.0.1"
  license: "MIT"
  description: ""
  dependencies: [
    "https://cdnjs.cloudflare.com/ajax/libs/marked/1.2.7/marked.min.js"
    "https://cdnjs.cloudflare.com/ajax/libs/dompurify/2.2.6/purify.min.js"
  ]
update: ->
render: -> @view.render!
init: ({root,mode,context}) ->
  mode = \edit
  @block = {}
  dompurify = context.DOMPurify
  marked = context.marked
  @view = view = new ldView do
    root: root.querySelector('[plug=view]')
    action:
      input: do
        "input-field": ({node}) ~>
          @block.{}value.content = node.value
          @update!
    handler: do
      "edit-only": ({node}) -> node.classList.toggle \d-none, mode != \edit
      "input-field": ({node}) ~> node.value = @block.{}value.content or ''
