pkg:
  name: "base", version: "0.0.1"
  dependencies: [
    {url: "/assets/lib/bootstrap.native/main/bootstrap-native-v4.min.js"}
    {url: "/assets/lib/@plotdb/suuid/main/suuid.bundle.min.js"}
    {url: "/assets/lib/@plotdb/config/main/config.min.js"}
    {url: "/assets/lib/form/dev/op.js"}
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

interface: -> @
init: (opt = {}) ->
  {BSN, ldview, suuid, form, config} = opt.context
  t = opt.t
  opt.pubsub.on \init, ->
  @data = data = {config: {}, key: suuid!}
  @mode = opt.data.mode
  @node = -> opt.root.querySelector('[ld-scope][plug=view]')
  @errors = []
  @ <<< _value: null, _empty: true
  @value = (v, is-empty = false, source = false) ->
    if v? =>
      @ <<< _value: v, _empty: is-empty
      @verify!
    if !source => opt.pubsub.fire \change, @_value
    return @_value
  @verify = ->
    if @_empty and data.config.is-required =>
      @errors = ["required"]
      return view.render!
    Promise.all(
      @data.term
        .filter (t) -> t.enabled
        .map (t) ~> t.verify(@_value).then (v) ~> [t,v]
    )
      .then ~>
        @errors = it.filter(-> !it.1).map -> it.0.msg
        view.render!
  @set-mode = ~>
    @mode = it
    @verify!
    @view.render!
  @serialize = ~>
    ret = {} <<< @data{key, title, desc} 
    ret.config = JSON.parse(JSON.stringify(@data.config or {}))
    ret.term = @data.term.map -> it.serialize!
    ret

  opsets = []
  opsets.push new form.opset do
    id: 'string'
    ops:
      include:
        func: (v, c = {}) -> ~("" + (v or '')).indexOf(c.str or '')
        config: {str: {type: \text}}
      exclude:
        func: (v, c = {}) -> !~("" + (v or '')).indexOf(c.str or '')
        config: {str: {type: \text}}
      email:
        func: (v) -> /^[^@]+@[^@]+$/.exec(v)
        config: {}
  opsets.push new form.opset do
    id: 'number'
    ops:
      lte:
        func: (v, c = {}) -> if isNaN(v) or isNaN(c.val) => false else +v <= +c.val 
        config: {val: {type: \text, hint: "number for comparison"}}
      gte:
        func: (v, c = {}) -> if isNaN(v) or isNaN(c.val) => false else +v >= +c.val 
        config: {val: {type: \text, hint: "number for comparison"}}
      ne:
        func: (v, c = {}) -> if isNaN(v) or isNaN(c.val) => false else +v != +c.val 
        config: {val: {type: \text, hint: "number for comparison"}}
      eq:
        func: (v, c = {}) -> if isNaN(v) or isNaN(c.val) => false else +v == +c.val 
        config: {val: {type: \text, hint: "number for comparison"}}

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
          data.[]term.push(new form.term {opset: opsets.0})
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
      "ok-hint": ({node}) ~>
        node.classList.toggle \d-none, ((@mode == \edit) or @errors.length)
      "error-hint": ({node}) ~>
        node.classList.toggle \d-none, ((@mode == \edit) or !@errors.length)
        node.textContent = if @errors.length => t(@errors.0 or "invalid input") else ''
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
            input:
              "errmsg": ({node, ctx}) -> ctx.msg = node.value or ''
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
              list: -> opsets
              key: -> it.id
              action: click: ({data, ctx, views}) ->
                if ctx.opset.id == data.id => return
                ctx.set-opset data
                views.0.render!
              handler: ({node, data}) ->
                node.textContent = t(data.name or data.id)
                node.setAttribute \data-id, data.id

