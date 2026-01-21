custom-formmgr = true

mgr = new block.manager registry: ({ns, name, version, path, type}) ->
  if type == \block =>
    return if ns == \local => "/block/#name/index.html"
    else if name == \@makeform/nest => "/assets/lib/@makeform/nest/main/index.html"
    else "https://cdn.jsdelivr.net/npm/#name@latest/index.html"
  return "/assets/lib/#name/#{version or 'main'}/#{path or \index.min.js}"

formmgr = new form.manager!
formmgr.condition!reset conditions: [
* src: \title, config: [
  * values: <[test]>, path: <[description]>, enabled: false
  ]
* src: <[title]>, config: [
  * values: <[test2]>, path: [<[_ gender]>], enabled: false
  ]
]
fields =
  _: type: {ns: \local, name: \contact}, meta: {}, order: 3
  title:
    type: \@makeform/input, order: 1
    meta: title: "Title", is-required: true
  description:
    type: \@makeform/textarea, order: 2
    meta: title: "Description", is-required: true


sample-value = _: do
  sig: count: 0, ts: Date.now!,token: Math.random!toString(36)
  object:
    name: v: "Form Manager Test"
    title: v: "Some Title"

formctl = new form.controller {
  formmgr: formmgr
  root: ld$.find("[ld=form]", 0)
  widget: if !custom-formmgr => {ns: \local, name: \contact} else null
  meta: {}
}

# if false, use widget formmgr as the root formmgr
if !custom-formmgr =>
  formmgr = formctl.formmgr!
  sample-value = sample-value["_"]["object"]
  fields = {}

view = new ldview do
  init-render: false
  root: document.body
  action: click:
    validate: -> formctl.check force: true .now!then -> view.render!
    dump: -> console.log formctl.formmgr!value!
    order: -> console.log formctl.formmgr!order!
  handler:
    "progress-bar": ({node}) ->
      stat = formmgr.progress!
      node.style.width = "#{(stat.percent * 100).toFixed(2)}%"
    widget:
      list: ->
        ret = [{k,v} for k,v of fields]
        ret.sort (a,b) -> a.v.order - b.v.order 
        ret
      key: -> it.k
      view: init: "@": ({node, ctx}) ->
        bid = if typeof(ctx.v.type) == \string => {name: ctx.v.type} else ctx.v.type
        mgr.from bid, {root: node, data: {}} .then (ret) ->
          ctx <<< itf: ret.interface, instance: ret.instance
          ctx.itf.deserialize ctx.v.meta, {init: true}
          formmgr.add path: ctx.k, widget: ctx.itf

view.init!
  .then -> formctl.init!
  .then -> formmgr.value sample-value
  .then -> formctl.check init: true .now!
  .then ->
    formmgr.on \change, -> formmgr.condition!run!; view.render!
    formmgr.on \meta, ->
      console.log \ok
      view.render!
  .then -> view.render!
