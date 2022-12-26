<-(->it.apply {}) _

@mgr = new block.manager registry: ({ns, url, name, version, path, type}) ->
  if url => return url
  if type == \block => return "/dev/block/#name.html"
  return "/assets/lib/#name/#version/#{path or \index.min.js}"

view = new ldview root: document.body

@nodes = {}

meta = 
  sheet: title: \budget
  bmi: title: \bmi, config: readonly: true
  height: title: \height, term: [{opset: \number, enabled: true, op: \gte, config: val: 1}]
  weight: title: \weight, term: [{opset: \number, enabled: true, op: \gte, config: val: 1}]
  name: title: \name, config: {is-required: true}
  choice:
    title: \choice
    values: [1,2,3,4,5]

  gender:
    title: \gender
    values: <[male female]>
    i18n:
      "zh-TW":
        "male": "男"
        "female": "女"

prepare = ({name, node, data}) ~>
  _data = data or {}
  @mgr.get {name}
    .then (bc) -> bc.create!
    .then (bi) ~>
      n = node.getAttribute \data-name
      data = _data <<< meta[n]
      bi.attach {root: node, data: data}
        .then ~>
          itf = bi.interface!
          @nodes[n] = itf
          if n == \bmi => return
          itf.on \change, ~>
            val = (+@nodes["weight"].value! or 0) / (((+@nodes["height"].value! or 100) / 100) ** 2)
            @nodes["bmi"].value (val).toFixed(2)

@mgr.init!
  .then -> i18next.init supportedLng: <[en zh-TW]>, fallbackLng: \zh-TW
  .then ~> block.i18n.use i18next
  .then -> i18next.changeLanguage navigator.language or navigator.userLanguage
  .then -> Promise.all(view.getAll \form-comp .map -> prepare node: it, name: it.getAttribute(\data-type))
  .then ~> @mgr.get name: \sheet
  .then (bc) -> bc.create!
  .then (bi) -> prepare node: view.get('sheet'), name: \sheet
