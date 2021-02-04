/*
do
  pkg:
    name: "@plotdb/long-answer"
    version: "0.0.1"
    extend: "@plotdb/formbase@0.0.1"
  init: ({pubsub, parent}) ->
    console.log "long-answer"
    console.log parent, pubsub
*/
do
  pkg: do
    author: "zbryikt"
    name: "@plotdb/long-answer"
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
    console.log "> long-answer", root
    mode = \edit
    @block = {}
    dompurify = context.DOMPurify
    marked = context.marked
    @view = view = new ldView do
      root: root.querySelector('[plug=view]')
      action:
        input: do
          "use-markdown": ({node}) ~>
            @block.{}value.use-markdown = node.checked
            @update!
            view.render!
          "input-field": ({node}) ~>
            @block.{}value.content = node.value
            @update!
          "toggle-preview": ({node}) ~>
            @preview = !!node.checked
            view.render!
        click: do
          "markdown-enabled": ({node, evt}) ~>
            @block.{}config.markdown-enabled = !@block.{}config.markdown-enabled
            @update!
            @render!

      handler: do
        "edit-only": ({node}) -> node.classList.toggle \d-none, mode != \edit
        "input-field": ({node}) ~> node.value = @block.{}value.content or ''
        "markdown-enabled": ({node}) ~> node.classList.toggle \on, !!@block.{}config.markdown-enabled
        "preview-panel": ({node}) ~>
          node.classList.toggle \d-none, !@preview
          if @preview => node.innerHTML = dompurify.sanitize(marked(@block.{}value.content or ''))
        "edit-panel": ({node}) ~> node.classList.toggle \d-none, !!@preview
        "if-markdown": ({node}) ~> node.classList.toggle \d-none, !@block.{}value.use-markdown
        "if-markdown-enabled": ({node}) ~> node.classList.toggle \d-none, !@block.{}config.markdown-enabled

