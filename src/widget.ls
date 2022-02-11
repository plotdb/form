form.widget = (opt = {}) ->
  @_root = if typeof(opt.root) == \string => document.querySelector(opt.root) else opt.root
  @evt-handler = {}
  @mod = opt.mod or null
  @i18n = {}
  @_custom = {}
  @_status = 1
  @_meta = {config: {}, key: Math.random!toString(36)substring(2)}
  @ <<< _value: null, _empty: true
  @_mode = opt.mode or \edit
  @_validate = opt.validate or null
  @_opsets = (opt.opsets or []).map (opset) ->
    if typeof(opset) == \string => form.opset.get opset
    else if typeof(opset) == form.opset => opset
    else new form.opset(opset)
  @_opsets
    .filter -> it.i18n
    .map ~> for k,v of it.i18n => @i18n{}[k] <<< v
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
  _init: -> Promise.resolve(if @mod and @mod.init => @mod.init.apply @ else '')
  key: (keyonly = false) ->
    return if keyonly => @_meta.key
    else @_meta.alias or @_meta.key
  status: (v) ->
    if !(v?) => return @_status
    ov = @_status
    @_status = v
    if ov != v => @fire \status, v
  serialize: ->
    ret = {} <<< @_meta{key, title, desc, is-required, readonly}
    ret.config = JSON.parse(JSON.stringify(@_meta.config or {}))
    ret.term = @_meta.term.map -> it.serialize!
    ret
  deserialize: (v) ->
    @_meta <<< v{key, title, desc, is-required, readonly}
    @_meta.config = JSON.parse(JSON.stringify(v.config or {}))
    @_meta.term = (v.term or []).map -> new form.term it
    @validate {init: true} .then ~> @render!

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
    if arguments.length == 0 => return @_value
    @ <<< _value: v, _empty: (if @mod and @mod.is-empty => @mod.is-empty.call(@,v) else !v)
    @validate opt{init} .then ~> if !opt.from-source => @fire \change, @_value

  validate: (opt = {}) ->
    v = @_value
    Promise.resolve!
      .then ~>
        if @mod and @mod.validate => return @mod.validate.apply @, @_value
        if @_validate => return @_validate @_value
        if @_empty and @_meta.is-required =>
          @_errors = ["required"]
          @status (if opt.init => 1 else 2)
          @render!
          return @_errors
        Promise.all(
          @_meta.term
            .filter (t) -> t.enabled
            .map (t) ~> t.validate(@_value).then (v) ~> [t,v]
        )
          .then ~>
            # since term is Promise-based,
            # validation result may expire if between this a new value has been set.
            # we may need a better way to check this. before that we simply check if value is different.
            if v != @_value => return
            @_errors = it.filter(->!it.1).map -> it.0.msg or 'error'
            @status if @_errors.length => 2 else 0
            @render!
          .then ~> @_errors

  render: ->
    @fire \render
    if @mod and @mod.render => @mod.render.apply @

  adapt: (...args) ->
    if @mod and @mod.adapt => @mod.adapt.apply @, args
