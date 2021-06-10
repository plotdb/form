manager = new block.manager registry: ({name,version}) -> "/block/#name/#version/index.html"
manager.init!
  .then ->
    manager.get {name: "short-answer", version: "0.0.1"}
  .then -> it.create {data: 'hello world'}
  .then ->
    it.attach {root}
    obj = it.interface!

    view = new ldview do
      root: document
      action: click:
        serialize: -> console.log obj.serialize!
        mode: ({node}) -> obj.set-mode node.getAttribute \data-name
        set: ({node}) -> obj.value Math.random!
    obj.set-mode \view
    debounce 1000 .then ->
      obj.set-mode \edit
