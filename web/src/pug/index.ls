<-(->it.apply {}) _

manager = new block.manager registry: ({name,version}) -> "/block/#name/#version/index.html"
@fields = []

i18next
  .init do
    fallbackLng: \zh-TW
    defaultLng: \zh-TW
  .then ~>
    i18next.changeLanguage \zh-TW
  .then ~>
    block.i18n.use i18next
    manager.init!
  .then ~>

    @view = new ldview do
      root: document
      action: click:
        serialize: ~> console.log @fields.map -> it.serialize!
        mode: ({node}) ~> @fields.map -> it.set-mode node.getAttribute \data-name
        set: ({node}) ~> @fields.map -> it.value Math.random!

    Promise.all <[short-answer long-answer]>.map ->
      manager.get {name: it, version: \0.0.1}
        .then -> it.create {data: {data: 'hello world'}}
        .then ->
          it.attach {root}
          it.interface!
        .then -> it
  .then ~> @fields = it
