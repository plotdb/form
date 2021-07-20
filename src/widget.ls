form.widget = (opt = {}) ->
  @root = if typeof(opt.root) == \string => document.querySelector(opt.root) else opt.root
  @evt-handler = {}
  @mod = opt.mod or null
  @_custom = {}
  @_meta = {config: {}, key: Math.random!toString(36)substring(2)}
  @ <<< _value: null, _empty: true
  @_mode = opt.mode or \view
  @_opsets = (opt.opsets or []).map (opset) ->
    if typeof(opset) == \string => form.opset.get opset
    else if typeof(opset) == form.opset => opset
    else new form.opset(opset)
  @_errors = []
  @init!
  @

form.widget.prototype = Object.create(Object.prototype) <<< do
  on: (n, cb) -> (if Array.isArray(n) => n else [n]).map (n) ~> @evt-handler.[][n].push cb
  fire: (n, ...v) -> for cb in (@evt-handler[n] or []) => cb.apply @, v
  init: -> if @mod => @mod.init.apply @
  key: -> return @_meta.alias or @_meta.key
  serialize: ->
    ret = {} <<< @_meta{key, title, desc}
    ret.config = JSON.parse(JSON.stringify(@_meta.config or {}))
    ret.term = @_meta.term.map -> it.serialize!
    ret
  deserialize: (v) ->
    @_meta <<< v{key, title, desc}
    @_meta.config = JSON.parse(JSON.stringify(v.config or {}))
    @_meta.term = v.term.map -> new form.term it
    @validate!
    @render!

  mode: ->
    if !(it?) => return @_mode
    @_mode = it
    @validate!
    @render!

  errors: -> @_errors
  opsets: -> @_opsets
  meta: (meta) -> if !(meta?) => return @_meta else @deserialize meta

  value: (v, is-empty = false, from-source = false) ->
    if !(v?) => return @_value
    @ <<< _value: v, _empty: is-empty
    @validate!
    if !from-source => @fire \change, @_value

  validate: ->
    if @_empty and @_meta.config.is-required =>
      @_errors = ["required"]
      return @render!
    Promise.all(
      @_meta.term
        .filter (t) -> t.enabled
        .map (t) ~> t.validate(@_value).then (v) ~> [t,v]
    )
      .then ~>
        @_errors = it.filter(-> !it.1).map -> it.0.msg
        @render!
      .then ~> @_errors

  render: ->
    @fire \render
    if @mod => @mod.render.apply @

