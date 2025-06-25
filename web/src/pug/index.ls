mgr = new block.manager registry: ({ns, name, version, path, type}) ->
  if type == \block =>
    return if ns == \local => "/block/#name/index.html"
    else "https://cdn.jsdelivr.net/npm/#name@latest/index.html"
  return "/assets/lib/#name/#{version or 'main'}/#{path or \index.min.js}"

formmgr = new form.manager!
fields = _: type: {ns: \local, name: \contact}, meta: {}
sample-value = _: do
  sig: count: 0, ts: Date.now!,token: Math.random!toString(36)
  object:
    name: v: "Form Manager Test"
    title: v: "Some Title"

# if false, use widget formmgr as the root formmgr
if !(custom-formmgr = false) =>
  formmgr = null
  sample-value = sample-value["_"]["object"]
  fields = {}

formctl = new form.controller {
  formmgr: formmgr
  root: ld$.find("[ld=form]", 0)
  widget: if !custom-formmgr => {ns: \local, name: \contact} else null
  meta: {}
}

view = new ldview do
  init-render: false
  root: document.body
  action: click:
    validate: -> formctl.check force: true .now!then -> view.render!
    dump: -> console.log formctl.formmgr!value!
    order: -> console.log formctl.formmgr!order!
  handler:
    "progress-bar": ({node}) ->
      stat = formctl.formmgr!progress!
      node.style.width = "#{(stat.percent * 100).toFixed(2)}%"
    widget:
      list: -> [{k,v} for k,v of fields]
      key: -> it.k
      view: init: "@": ({node, ctx}) ->
        bid = if typeof(ctx.v.type) == \string => {name: ctx.v.type} else ctx.v.type
        mgr.from bid, {root: node, data: {}} .then (ret) ->
          ctx <<< itf: ret.interface, instance: ret.instance
          ctx.itf.deserialize ctx.v.meta, {init: true}
          formmgr.add path: \_, widget: ctx.itf

view.init!
  .then -> formctl.init!
  .then -> formctl.formmgr!value sample-value
  .then -> formctl.check init: true .now!
  .then -> formctl.formmgr!on \change, -> view.render!
  .then -> view.render!
