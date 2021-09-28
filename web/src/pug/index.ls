<-(->it.apply {}) _

manager = new block.manager registry: ({name,version,path,type}) ->
  if type == \block => return "/block/#name/#version/#{path or \index.html}"
  return "/assets/lib/#name/#version/#{path or \index.js}"

@fields = []

fmgr = new form.manager!

i18next
  .init { fallbackLng: \zh-TW, defaultLng: \zh-TW }
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
        value: ({node}) ~> console.log fmgr.value!
        set: ({node}) ~>
          obj = fmgr.value!
          for k,v of obj =>
            console.log k, v
            if k == \choice => obj[k] = 'option 1'
            else obj[k] = Math.random!
          fmgr.value obj

    #Promise.all <[sheet short-answer long-answer]>.map (name) ->
    Promise.all <[short-answer single-choice multi-choice]>.map (name) ->
      manager.get {name: name, version: \0.0.1}
        .then -> it.create {data: {data: 'hello world'}}
        .then ->
          it.attach {root}
          it.interface!
        .then -> it
  .then ~>
    console.log it
    fmgr.add it
