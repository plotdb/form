form.widget = (opt = {}) ->
  @root = if typeof(opt.root) == \string => document.querySelector(opt.root) else opt.root
  @evt-handler = {}
  @mod = opt.mod or null
  @i18n = {}
  @_custom = {}
  @_meta = {config: {}, key: Math.random!toString(36)substring(2)}
  @ <<< _value: null, _empty: true
  @_mode = opt.mode or \view
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
  fire: (n, ...v) -> for cb in (@evt-handler[n] or []) => cb.apply @, v
  _init: -> Promise.resolve(if @mod and @mod.init => @mod.init.apply @ else '')
  key: (keyonly = false) ->
    return if keyonly => @_meta.key
    else @_meta.alias or @_meta.key

  serialize: ->
    ret = {} <<< @_meta{key, title, desc}
    ret.config = JSON.parse(JSON.stringify(@_meta.config or {}))
    ret.term = @_meta.term.map -> it.serialize!
    ret
  deserialize: (v) ->
    @_meta <<< v{key, title, desc}
    @_meta.config = JSON.parse(JSON.stringify(v.config or {}))
    @_meta.term = (v.term or []).map -> new form.term it
    @validate!
    @render!

  mode: ->
    if !(it?) => return @_mode
    @_mode = it
    @validate!
    @render!

  errors: -> @_errors

  value: (v, from-source = false) ->
    if !(v?) => return @_value
    @ <<< _value: v, _empty: (if @mod and @mod.is-empty => @mod.is-empty.apply(@,v) else !v)
    @validate!
    if !from-source => @fire \change, @_value

  validate: ->
    if @mod and @mod.validate => return @mod.validate.apply @, @_value
    if @_validate => return Promise.resolve(@_validate @_value)
    if @_empty and @_meta.config.is-required =>
      @_errors = ["required"]
      return @render!
    Promise.all(
      @_meta.term
        .filter (t) -> t.enabled
        .map (t) ~> t.validate(@_value).then (v) ~> [t,v]
    )
      .then ~>
        @_errors = it.filter(-> !it.1).map -> it.0.msg or 'error'
        @render!
      .then ~> @_errors

  render: ->
    @fire \render
    if @mod and @mod.render => @mod.render.apply @

  adapt: (...args) ->
    if @mod and @mod.adapt => @mod.adapt.apply @, args
