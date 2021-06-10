/*
{
  title:
  desc: 
  criteria: [ ... ]
  config: {}
}
*/

pkg:
  name: "@plotdb/base", version: "0.0.1"
  dependencies: [
    {url: "/assets/lib/bootstrap.native/main/bootstrap-native-v4.min.js"}
    {url: "/assets/lib/ldview/main/index.min.js"}
  ]
init: ({root, context}) ->
  {BSN,ldview} = context
  console.log BSN
  <-(->it.apply({})) _
  @data = data = {config: {}}
  @view = view = new ldview do
    root: root
    action:
      input:
        title: ({node,ctx}) ~> data.title = node.value or ''
        desc: ({node,ctx}) ~> data.desc = node.value or ''
      click:
        "add-criteria": ({views}) ~>
          data.[]criteria.push {}
          views.0.render \criteria
        switch: ({node}) ~>
          n = node.getAttribute(\data-name)
          if !(n in <[isPublic isRequired showDesc]>) => return
          data.{}config[n] = !data.config[n]
          view.render!
    init: dropdown: ({node}) -> new BSN.Dropdown(node)
    handler:
      title: ({node}) ~> node.value = data.title or ''
      desc: ({node}) ~> node.value = data.desc or ''
      switch: ({node}) ~>
        n = node.getAttribute(\data-name)
        if !(n in <[isPublic isRequired showDesc]>) => return
        node.classList.toggle \on, !!data.{}config[n]
      criteria:
        list: ~> data.[]criteria
        view: do
          action:
            click:
              enabled: ({ctx, views}) ~>
                ctx.enabled = !ctx.enabled
                views.0.render!
              delete: ({ctx, views}) ~>
                data.criteria.splice data.criteria.indexOf(ctx), 1
                views.0.render!
            change:
              attr: ({node, ctx, views}) ~>
                ctx.opset = data.attr[node.value].opset
                views.0.render!
              op: ({node, views, ctx}) ~>
                ctx.op = form.opset.get(ctx.opset or 'number').get-op(node.value)
                views.0.render!
          init: dropdown: ({node}) ->
            new BSN.Dropdown(node)
          handler:
            enabled: ({node, ctx}) ->
              node.classList.toggle \on, !!ctx.enabled
            "op-option":
              list: ({ctx}) ~>
                opset = form.opset.get(ctx.opset or 'number')
                [v for k,v of opset.ops]
              handler: ({node, data}) ->
                node.setAttribute \value, data.id
                node.innerText = data.name
            "op-config":
              list: ({ctx}) -> [{k,v} for k,v of ctx.{}op.config or {}]
              key: -> it.k
              view:
                text:
                  name: ({node, ctx}) -> return ctx.k

