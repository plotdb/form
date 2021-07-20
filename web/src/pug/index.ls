<-(->it.apply {}) _

manager = new block.manager registry: ({name,version}) -> "/block/#name/#version/index.html"
@fields = []

fmgr = new form.manager!

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
        serialize: ~> console.log fmgr.serialize!
        mode: ({node}) ~> fmgr.mode node.getAttribute \data-name
        set: ({node}) ~>
          console.log 123
          obj = fmgr.value!
          for k,v of obj => obj[k] = Math.random!
          fmgr.value obj

    Promise.all <[sheet short-answer long-answer]>.map (name) ->
      manager.get {name: name, version: \0.0.1}
        .then -> it.create {data: {data: 'hello world'}}
        .then ->
          it.attach {root}
          it.interface!
        .then -> it
  .then ~> fmgr.add it
