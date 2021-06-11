pkg:
  name: "@plotdb/base", version: "0.0.1"
  dependencies: [
    {url: "/assets/lib/bootstrap.native/main/bootstrap-native-v4.min.js"}
    {url: "/assets/lib/@plotdb/suuid/main/suuid.bundle.min.js"}
    {url: "/assets/lib/form/dev/op.js"}
    {url: "/assets/lib/ldview/main/index.min.js"}
  ]
interface: -> @
init: (opt = {}) ->
  {BSN, ldview, suuid,form} = opt.context
  opt.pubsub.on \init, -> console.log \ok
  console.log opt.data
  i18n = opt.data.i18n

  i18n.addResourceBundle \en, \translation, {
    include: "包含"
    exclude: "排除"
    email: "電子郵件"
  }, true, true

  @data = data = {config: {}, key: suuid!}
  @mode = opt.data.mode
  @node = -> opt.root.querySelector('[ld-scope][plug=view]')
  @value = (v, source = false) ->
    if v? =>
      @_value = v
      @verify!
    if !source => opt.pubsub.fire \change, @_value
    return @_value
  @verify = ->
    Promise.all @data.term.map ~> it.verify @_value
      .then -> it.reduce(((a,b) -> a and b),true)
      .then ~>
        @has-error = !it
        view.render!
  @set-mode = ~>
    @mode = it
    @view.render!
  @serialize = ~>
    ret = {} <<< @data{key, title, desc} 
    ret.config = JSON.parse(JSON.stringify(@data.config or {}))
    ret.term = @data.term.map -> it.serialize!
    ret
  opset = new form.opset do
    id: 'string'
    ops:
      include: (v, c) -> ~(v or '').indexOf('test')
      exclude: (v, c) -> !~(v or '').indexOf('test')
      email: (v) -> /^[^@]+@[^@]+$/.exec(v)

  @view = view = new ldview do
    root: opt.root
    action:
      input:
        title: ({node,ctx}) ~> data.title = node.value or ''
        desc: ({node,ctx}) ~> data.desc = node.value or ''
        "custom-shortname": ({node, views}) ->
          data.alias = node.value or ''
          views.0.render!
      click:
        "set-shortname": ({node,views}) ->
          data.alias = node.getAttribute(\data-value) or ''
          views.0.render!
        "custom-shortname": ({evt}) -> evt.stopPropagation!
        "add-term": ({views}) ~>
          data.[]term.push(new form.term {opset: opset})
          @verify!
          views.0.render \term
        switch: ({node}) ~>
          n = node.getAttribute(\data-name)
          if !(n in <[isPublic isRequired showDesc]>) => return
          data.{}config[n] = !data.config[n]
          view.render!
    init: dropdown: ({node}) -> new BSN.Dropdown(node)
    text:
      "shortname": -> data.alias or '設定代稱..'
    handler:
      "error-hint": ({node}) ~> node.classList.toggle \d-none, ((@mode == \edit) or !@has-error)
      "edit-only": ({node}) ~> node.classList.toggle \d-none, @mode != \edit
      "set-shortname": ({node}) ->
        node.classList.toggle \active, (node.getAttribute(\data-value) == data.alias)
      "custom-shortname": ({node}) -> node.value = data.alias or ''

      title: ({node}) ~> node.value = data.title or ''
      desc: ({node}) ~> node.value = data.desc or ''
      switch: ({node}) ~>
        n = node.getAttribute(\data-name)
        if !(n in <[isPublic isRequired showDesc]>) => return
        node.classList.toggle \on, !!data.{}config[n]
      term:
        list: ~> data.[]term
        view: do
          action:
            click:
              enabled: ({ctx, views}) ~>
                ctx.enabled = !ctx.enabled
                views.0.render!
              delete: ({ctx, views}) ~>
                data.term.splice data.term.indexOf(ctx), 1
                views.1.render \term
            change:
              attr: ({node, ctx, views}) ~>
                ctx.opset = data.attr[node.value].opset
                views.0.render!
              op: ({node, views, ctx}) ~>
                ctx.op = form.opset.get(ctx.opset or 'number').get-op(node.value)
                views.0.render!
          init: dropdown: ({node}) ->
            new BSN.Dropdown(node)
          text:
            opset: ({ctx}) -> i18n.t(if !ctx.opset => "" else (ctx.opset.name or ctx.opset.id))
            op: ({ctx}) -> i18n.t(if !ctx.op => "" else (ctx.op.name or ctx.op.id))
          handler:
            enabled: ({node, ctx}) ->
              node.classList.toggle \on, !!ctx.enabled
            "set-op":
              list: ({ctx}) -> ctx.opset.get-ops!
              action: click: ({data, ctx, views}) ->
                ctx.set-op data.id
                views.0.render!
              handler: ({node, data}) ->
                node.textContent = i18n.t(data.name or data.id)
                node.setAttribute \data-id, data.id
            "set-opset":
              list: -> [opset]
              action: click: ({data, ctx, views}) ->
                if ctx.opset.id == data.id => return
                ctx.set-opset data
                views.0.render!
              handler: ({node, data}) ->
                node.textContent = data.name or data.id
                node.setAttribute \data-id, data.id
            /*
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
            */
