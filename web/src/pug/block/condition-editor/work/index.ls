view = new ldview do
  root: document.body
  handler:
    condition:
      list: -> [1,2,3,4].map -> {key: it}
      key: -> it.key
      view: {}

