form.widget = (opt = {}) ->
  @_root = if typeof(opt.root) == \string => document.querySelector(opt.root) else opt.root
  @evt-handler = {}
  @mod = opt.mod or null
  @i18n = {}
  @_custom = {}
  @_status = 1
  @_meta = {config: {}, key: Math.random!toString(36)substring(2)}
  @_meta_dig = "" # for tracking meta change.
  @ <<< _value: undefined, _empty: true
  @_mode = opt.mode or \edit
  @_validate = opt.validate or null
  @_opsets = ((opt.opsets or []) ++ ((opt.mod or {}).opsets or [])).map (opset) ->
    if typeof(opset) == \string => form.opset.get opset
    else if opset instanceof form.opset => opset
    else new form.opset opset
  @_opsets
    .filter -> it.i18n
    .map ~> for k,v of it.i18n => @i18n{}[k] <<< v
  @_opsets = Object.fromEntries [[(o.id or o.name or ''), o] for o in @_opsets]
  @_errors = []
  @init = proxise.once ~> @_init!
  @

form.widget.prototype = Object.create(Object.prototype) <<< do
  on: (n, cb) -> (if Array.isArray(n) => n else [n]).map (n) ~> @evt-handler.[][n].push cb
  off: (n, cb) -> (if Array.isArray(n) => n else [n]).map (n) ~>
    l = @evt-handler.[][n]
    if l.indexOf(cb) >= 0 => l.splice l.indexOf(cb), 1
  fire: (n, ...v) -> for cb in (@evt-handler[n] or []) => cb.apply @, v
  root: -> @_root
  _init: ->
    <~ Promise.resolve(if @mod and @mod.init => @mod.init.apply @ else '').then _
    @fire \init
  key: (keyonly = false) ->
    return if keyonly => @_meta.key
    else @_meta.alias or @_meta.key
  status: (v) ->
    if !(v?) => return @_status
    ov = @_status
    @_status = v
    if ov != v => @fire \status, v
  serialize: ->
    ret = {} <<< @_meta{key, title, desc, is-required, disabled, readonly, default-value}
    ret.config = JSON.parse(JSON.stringify(@_meta.config or {}))
    ret.term = (@_meta.term or []).map -> it.serialize!
    ret
  deserialize: (v, o = {}) ->
    @_meta <<< v{key, title, desc, is-required, disabled, readonly, default-value}
    @_meta.config = JSON.parse(JSON.stringify(v.config or {}))
    @_meta.term = (v.term or []).map (t) ~>
      new form.term({} <<< t <<< (if @_opsets[t.opset or ''] => {opset: that} else {}))
    dig = JSON.stringify(v)
    # we won't want to fire meta event if no change. also, we should provide init flag
    if @_meta_dig != dig =>
      # we should pass opt (especially the init flag),
      # so widget such as nest can pass it along to subsequential deserialize determine if they should
      @fire \meta, @serialize!, o{init}
    @_meta_dig = dig
    Promise.resolve!
      .then ~>
        if !o.init => return
        if !(@_meta.default-value? and @is-empty!) => return
        # NOTE: definition of from-source is contradicted in doc and here.
        # before we clarify its purpose, don't use it. also, check doc for more information.
        @value @_meta.default-value, {init: true, from-source: true}
      .then ~> @validate {init: o.init}
      .then ~> @render!

  mode: (m) ->
    if !(m?) => return @_mode
    <~ Promise.resolve!then _
    if !(m in <[edit view config]>) => return Promise.reject(new Error! <<< {name: \lderror, id: 1015})
    if @_mode == m => return
    @_mode = m
    @fire \mode, m
    @validate {init: true} .then ~> @render!

  errors: -> @_errors

  value: (v, opt = {}) ->
    if arguments.length == 0 =>
      # internal value should be kept as a new, standalone object
      # otherwise user can modify this value from outside, causing bizarre behavior
      return if @_value? => JSON.parse(JSON.stringify @_value) else @_value
    # dont update value if these values are exactly the same
    if @is-equal(v, @_value) => return Promise.resolve!
    _v = if v? => JSON.parse(JSON.stringify(v)) else v
    @ <<< _value: _v, _empty: @is-empty(_v)
    @validate opt{init} .then ~>
      # NOTE: definition of from-source is contradicted in doc and here.
      # before we clarify its purpose, don't use it. also, check doc for more information.
      if opt.from-source => return
      @fire \change, (if @_value? => JSON.parse(JSON.stringify @_value) else undefined)

  disabled: -> @_meta.disabled
  readonly: -> @_meta.readonly
  is-required: -> @_meta.is-required

  is-empty: (v) ->
    if !arguments.length => v = @_value
    if @mod and @mod.is-empty => @mod.is-empty.call @, v
    else (v == null or typeof(v) == \undefined or (v == ''))

  is-equal: (u, v) ->
    if arguments.length == 1 => v = @_value
    if @mod and @mod.is-equal => return @mod.is-equal.call @, u, v
    eu = @is-empty u
    ev = @is-empty v
    if eu xor ev => return false
    if eu and ev => return true
    return JSON.stringify(u) == JSON.stringify(v)

  # while we can check if v.v is defined ( or, hasOwnProperty ),
  # we have no idea if it's just not provided yet or if it's a custom format.
  # Thus mod has always to provide a content method even if they use `v.v` to store value
  content: (v) ->
    if !arguments.length => v = @_value
    if @mod and @mod.content => @mod.content.call @, v
    else if typeof(v) == \object and v and v.hasOwnProperty(v) => v.v
    else v

  validate: (opt = {}) ->
    v = @content!
    Promise.resolve!
      .then ~>
        if @mod and @mod.validate => return @mod.validate.call @, opt
        if @_validate => return @_validate v
      .then (ret = []) ~>
        # status 3 (editing) means validation isn't done yet,
        # perhaps due to untouched internal fields, thus we shouldn't skip further checks for now.
        # unlike status 1 which is considered empty in restatus,
        # status 3 won't signal `valid` in restatus if field is empty.
        if ret.status == 3 =>
          @_errors = ret.errors or []
          @status 3
          @render!
          return @_errors
        if ret and ret.length =>
          @_errors = ret
          @status if opt.init => 1 else 2
          @render!
          return @_errors

        if @_empty =>
          if @_meta.is-required =>
            @_errors = ["required"]
            @status (if opt.init => 1 else 2)
            @render!
            return @_errors
          else
            # don't validate empty field.
            @status 0
            @render!
            return @_errors = []
        Promise.all(
          @_meta.term
            .filter (t) -> t.enabled
            .map (t) ~> t.validate(v).then (v) ~> [t,v]
        )
          .then ~>
            # since term is Promise-based,
            # validation result may expire if between this a new value has been set.
            # TODO we may need a better way to check this. before that we simply check if value is different.
            nv = @content!
            if !@is-equal nv, v => return
            @_errors = it.filter(->!it.1).map -> it.0.msg or 'error'
            @status if @_errors.length => 2 else 0
            @render!
          .then ~> @_errors

  render: ->
    @fire \render
    if @mod and @mod.render => @mod.render.apply @

  adapt: (...args) ->
    if @mod and @mod.adapt => @mod.adapt.apply @, args

  manager: ({depth = 0} = {}) ->
    ret = if @mod and @mod.manager => @mod.manager.apply(@, [{depth}]) else []
    return (if Array.isArray(ret) => ret else [ret]).filter(->it)

  ctrl: (...args) ->
    if @mod and @mod.ctrl => return @mod.ctrl.apply @, args
