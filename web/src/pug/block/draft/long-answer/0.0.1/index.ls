module.exports =
  pkg:
    name: "long-answer", version: "0.0.1"
    extend: name: "base", version: "0.0.1"
    license: "MIT"
    description: ""
    dependencies: [
      "https://cdnjs.cloudflare.com/ajax/libs/marked/1.2.7/marked.min.js"
      "https://cdnjs.cloudflare.com/ajax/libs/dompurify/2.2.6/purify.min.js"
    ]
    i18n:
      "zh-TW": {
        "input text": "輸入文字 ..."
        "provide markdown option": "提供 Markdown 選項"
        "preview": "預覽"
        "enable markdown": "啟用 Markdown 語法"
        "syntax": "語法說明"
      }
  init: ({root,parent,context,pubsub,data}) ->
    {DOMPurify,marked,ldview} = context
    data = data or {}
    pubsub.fire \init, {opsets: <[string number]>, mod: is-empty: -> !("#{it}".trim!length)}
      .then (opt = []) ->
        {widget, node} = opt.0
        data.{}config
        value = {value: '', use-markdown: false}
        local = {}
        pubsub.on \change, ->
          value <<< (it or {})
          view.get(\input-field).value = value.value or ''
        pubsub.on \update, ->
          if !data.config.markdown-enabled => value.use-markdown = false
          view.render!
        view = new ldview do
          root: node.view #parent.node!
          action:
            input: 'input-field': ({node}) ->
              widget.value node.value, !node.value, true
              value.value = node.value
            click:
              "use-markdown": ({node}) ~>
                value.use-markdown = data.config.markdown-enabled and node.checked
                view.render!
              "markdown-enabled": ({node, evt}) ~>
                data.config.markdown-enabled = !data.config.markdown-enabled
              "toggle-preview": ({node}) ->
                local.preview = node.checked
                view.render!
          handler:
            "if-markdown": ({node}) -> node.classList.toggle \d-none, !value.use-markdown
            "if-markdown-enabled": ({node}) -> node.classList.toggle \d-none, !data.config.markdown-enabled
            "use-markdown": ({node}) -> node.checked = value.use-markdown
            "preview-panel": ({node}) ->
              node.classList.toggle \d-none, !local.preview
              if local.preview =>
                node.innerHTML = DOMPurify.sanitize(marked(value.value or ''))
            "edit-panel": ({node}) -> node.classList.toggle \d-none, !!local.preview
