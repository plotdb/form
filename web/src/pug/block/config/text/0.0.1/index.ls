<-(->it!) _

block-factory =
  pkg:
    name: 'config/text', version: '0.0.1'
    extend: name: 'config/base', version: '0.0.1'
    dependencies: []
    i18n:
      "zh-TW":
        "text for comparison": "比較用的文字"
  init: ({root, context, data, pubsub, t}) ->
    {ldview} = context
    pubsub.fire \init, do
      get: -> view.get('input').value or ''
      set: -> view.get('input').value = it or ''
    view = new ldview do
      root: root
      init: input: ({node}) ->
        node.value = data.default or ''
        node.setAttribute \placeholder, t(data.hint or 'text for comparison')
      action:
        input: input: ({node}) -> pubsub.fire \event, \change, node.value
        change: input: ({node}) -> pubsub.fire \event, \change, node.value

return block-factory
