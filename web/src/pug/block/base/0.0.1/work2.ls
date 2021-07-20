block-factory =

  pkg:
    name: "base", version: "0.0.1"
    dependencies: [
      {url: "/assets/lib/bootstrap.native/main/bootstrap-native-v4.min.js"}
      {url: "/assets/lib/@plotdb/suuid/main/suuid.bundle.min.js"}
      {url: "/assets/lib/@plotdb/config/main/config.min.js"}
      {url: "/assets/lib/@Plotdb/form/dev/form.js"}
      {url: "/assets/lib/ldview/main/index.min.js"}
    ]
    i18n:
      "zh-TW": {
        string: "文字"
        number: "數字"
        include: "包含"
        exclude: "排除"
        email: "電子郵件"
        required: "必填"
        copy: "複製"
        delete: "刪除"
        "show description": "顯示描述"
        "number for comparison": "比較用的數字"
        public: "公開"
        "add criteria": "增加條件"
        "error message": "錯誤訊息"
        "invalid input": "輸入不符合要求"
        lte: "≦ 小於或等於"
        gte: "≧ 大於或等於"
        ne: "≠ 不等於"
        eq: "= 等於"
      }
  interface: -> @widget
  init: (opt = {}) ->
    {form} = opt
    pubsub.on \init, (opt = {}) ->
      @widget = widget = new form.widget {root} <<< mod
      node = view: root.querySelector('[ld-scope][plug=view]')



init: (opt = {}) ->
  {BSN, ldview, suuid, form, config} = opt.context
  {pubsub, t, root} = opt
  (opt = {}) <~ pubsub.on \init, _
  @widget = widget = new form.widget {root} <<< opt
  node = view: root.querySelector('[ld-scope][plug=view]')
  #widget.on \update, -> pubsub.fire \update
  #widget.on \render, ~> @view.render!

  mod = do
    render: -> @_custom.view.render!
    init: ->
      meta = @._meta

      @_custom.view = view = new ldview do
        root: root
        action:
          input:
            title: ({node,ctx}) ~> meta.title = node.value or ''
            desc: ({node,ctx}) ~> meta.desc = node.value or ''
            "custom-shortname": ({node, views}) ->
              meta.alias = node.value or ''
              views.0.render!
          click:
            "set-shortname": ({node,views}) ->
              meta.alias = node.getAttribute(\data-value) or ''
              views.0.render!
            "custom-shortname": ({evt}) -> evt.stopPropagation!
            "add-term": ({views}) ~>
              meta.[]term.push(new form.term {opset: @widget.opsets!0})
              @widget.validate!
              views.0.render \term
            switch: ({node}) ~>
              n = node.getAttribute(\data-name)
              meta.{}config[n] = !meta.config[n]
              pubsub.fire \update
              view.render!
        init: dropdown: ({node}) -> new BSN.Dropdown(node)
        text:
          "shortname": -> meta.alias or '設定代稱..'
        handler:
          required: ({node}) -> node.classList.toggle \d-none, !meta.config.is-required
          "add-term": ({node}) ~> node.classList.toggle \d-none, !(@widget.opsets!length)
          "ok-hint": ({node}) ~>
            node.classList.toggle \d-none, ((@widget.mode! == \edit) or @widget.errors!length)
          "error-hint": ({node}) ~>
            node.classList.toggle \d-none, ((@widget.mode! == \edit) or !@widget.errors!length)
            node.textContent = if @widget.errors!length => t(@widget.errors!0 or "invalid input") else ''
          "edit-only": ({node}) ~> node.classList.toggle \d-none, @widget.mode! != \edit
          "set-shortname": ({node}) ->
            node.classList.toggle \active, (node.getAttribute(\data-value) == meta.alias)
          "custom-shortname": ({node}) -> node.value = meta.alias or ''

          title: ({node}) ~> node.value = meta.title or ''
          desc: ({node}) ~> node.value = meta.desc or ''
          switch: ({node}) ~>
            n = node.getAttribute(\data-name)
            node.classList.toggle \on, !!meta.{}config[n]
          term:
            list: ~> meta.[]term
            view: do
              action:
                input:
                  "errmsg": ({node, ctx}) -> ctx.msg = node.value or ''
                click:
                  enabled: ({ctx, views}) ~>
                    ctx.enabled = !ctx.enabled
                    views.0.render!
                  delete: ({ctx, views}) ~>
                    meta.term.splice meta.term.indexOf(ctx), 1
                    views.1.render \term
                change:
                  attr: ({node, ctx, views}) ~>
                    ctx.opset = meta.attr[node.value].opset
                    views.0.render!
                  op: ({node, views, ctx}) ~>
                    ctx.op = form.opset.get(ctx.opset or 'number').get-op(node.value)
                    views.0.render!
              init:
                dropdown: ({node}) -> new BSN.Dropdown(node)
                "config-root": ({node, ctx, local}) ->
                  local.cfg = cfg = new config root: node, config: ctx.op.config, name: -> "config/#it"
                  cfg.init!
                  cfg.on \change, -> ctx.config = it

              text:
                opset: ({ctx}) -> t(if !ctx.opset => "" else (ctx.opset.name or ctx.opset.id))
                op: ({ctx}) -> t(if !ctx.op => "" else (ctx.op.name or ctx.op.id))
              handler:
                "config-root": ({node, ctx, local}) ->
                  cfg = ctx.op.config or {}
                  for k,v of cfg => if v.hint => v.hint = t(v.hint)
                  local.cfg.config cfg
                  if local.cfg.view => local.cfg.view.render!
                  show = !!([k for k of cfg].length)
                  node.classList.toggle \d-none, !show
                  node.classList.toggle \d-flex, show
                enabled: ({node, ctx}) ->
                  node.classList.toggle \on, !!ctx.enabled
                "set-op":
                  list: ({ctx}) -> ctx.opset.get-ops!
                  action: click: ({data, ctx, views}) ->
                    ctx.set-op data.id
                    views.0.render!
                  handler: ({node, data}) ->
                    node.textContent = t(data.name or data.id)
                    node.setAttribute \data-id, data.id
                "set-opset":
                  list: ~> @widget.opsets!
                  key: -> it.id
                  action: click: ({data, ctx, views}) ->
                    if ctx.opset.id == data.id => return
                    ctx.set-opset data
                    views.0.render!
                  handler: ({node, data}) ->
                    node.textContent = t(data.name or data.id)
                    node.setAttribute \data-id, data.id

  return {widget: @widget, node: node}
