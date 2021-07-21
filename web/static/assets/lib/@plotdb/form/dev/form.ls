form = {}
form.manager = ->
  @_fields = []
  @

form.manager.prototype = Object.create(Object.prototype) <<< do
  add: -> @_fields ++= if Array.isArray(it) => it else [it]
  fields: -> @_fields
  serialize: -> @_fields.map -> it.serialize!
  value: (vs) ->
    if !vs => return Object.fromEntries(@_fields.map -> [it.key!, it.value!])
    for k,v of vs =>
      f = @_fields.filter(-> (it.key! == k)).0
      if !f => continue
      f.value v
  mode: (m) -> @_fields.map -> it.mode m

# 規則運算子
form.op = (opt = {}) ->
  @ <<< opt{id, name, config, func}
  @ <<< opt{i18n} # TODO
  @

form.op.prototype = Object.create(Object.prototype) <<< do
  validate: (val, cfg = {}) ->
    if (ret = @func val, cfg) instanceof Promise => ret else Promise.resolve(!!ret)

  config-default: ->
    cfg = {}
    for k,v of @config => cfg[k] = v.default
    return cfg


# 資料驗證的規則集
form.opset = (opt={}) ->
  @ <<< opt{name, id, i18n}
  @ <<< {ops: {}}
  ops = if Array.isArray(opt.ops) => opt.ops.map -> {v: it, k: it.id}
  else [{k,v} for k,v of opt.ops]
  ops.map ({k,v}) ~>
    @ops[k] = if v instanceof form.op => v
    else if k => new form.op((if typeof(v) == \function => {func: v} else v) <<< {id: k})
    else throw new Error('[@plotdb/form/opset] invalid op when initializing opset.')
    for k,v of opt.ops => @ops[k] = new form.op((if typeof(v) == \function => {func: v} else v) <<< {name: k, id: k})
  @default-op = if @ops[opt.default-op] => opt.default-op else [k for k,v of @ops].0
  @

form.opset.prototype = Object.create(Object.prototype) <<< do
  get-op: (id) -> @ops[id or @default-op]
  get-ops: -> [v for k,v of @ops]

form.opset.register = -> @[]list.push if it instanceof form.opset => it else new form.opset(it)
form.opset.get = (id) -> @[]list.filter(->(it.id or it.name) == id).0

form.opset.default = [
  {
    id: 'string'
    i18n:
      "zh-TW":
        string: "文字"
        include: "包含"
        exclude: "排除"
        email: "電子郵件"
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
  }, {
    id: 'number'
    i18n:
      "zh-TW":
        number: "數字"
        lte: "≦ 小於或等於"
        gte: "≧ 大於或等於"
        ne: "≠ 不等於"
        eq: "= 等於"
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
  }
]

form.opset.default.map -> form.opset.register it

/**
 * term, for verification of values based on assigned op and config.
 * @constructor
 * @param {boolean} enabled - determine if this term is enabled or not
 * @param {string} opset - id of opset used by this term.
 * @param {string} op - id of op used by this term
 * @param {object} config - additional config for chosen op.
 */
form.term = (opt={}) ->
  @ <<< {enabled: true, opset: null, op: null, config: {}} <<< opt
  @set-opset opt.opset, opt.op, opt.config
  @

form.term.prototype = Object.create(Object.prototype) <<< do
  toggle: -> @enabled = if it? => it else !@enabled
  set-opset: (opset, op, cfg) ->
    if typeof(opset) == \string =>
      if !(@opset = form.opset.get opset) => throw new Error("no such opset '#opset'")
    else if (opset instanceof form.opset) =>
      @opset = opset
    else throw new Error("invalid opset")
    @set-op op, cfg

  set-op: (id, cfg) ->
    if !@opset => throw new Error("opset not set")
    if !(@op = @opset.get-op(id)) => throw new Error("no such op '#id'")
    @set-config cfg

  set-config: (cfg) ->
    if !@op => throw new Error("op not set")
    @config = if !cfg => @op.config-default! else cfg

  validate: (v) ->
    if !@op => Promis.reject(new Error("op not set"))
    @op.validate(v, @config)

  serialize: ->
    return {enabled: @enabled, opset: @opset.id, op: @op.id, config: @config}

  # TBD - do we need this? ( we already can deserialize directly from new form.term(serializedObject) )
  deserialize: (v) ->
    @toggle v.enabled
    @set-opset v.opset, v.op, v.config
form.widget = (opt = {}) ->
  @root = if typeof(opt.root) == \string => document.querySelector(opt.root) else opt.root
  @evt-handler = {}
  @mod = opt.mod or null
  @i18n = {}
  @_custom = {}
  @_meta = {config: {}, key: Math.random!toString(36)substring(2)}
  @ <<< _value: null, _empty: true
  @_mode = opt.mode or \view
  @_opsets = (opt.opsets or []).map (opset) ->
    if typeof(opset) == \string => form.opset.get opset
    else if typeof(opset) == form.opset => opset
    else new form.opset(opset)
  @_opsets
    .filter -> it.i18n
    .map ~> for k,v of it.i18n => @i18n{}[k] <<< v
  @_errors = []
  @init!
  @

form.widget.prototype = Object.create(Object.prototype) <<< do
  on: (n, cb) -> (if Array.isArray(n) => n else [n]).map (n) ~> @evt-handler.[][n].push cb
  fire: (n, ...v) -> for cb in (@evt-handler[n] or []) => cb.apply @, v
  init: -> if @mod => @mod.init.apply @
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
    @_meta.term = v.term.map -> new form.term it
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
    @ <<< _value: v, _empty: (if @mod and @mod.is-empty => @mod.is-empty(v) else !!v)
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

if (module?) => module.exports = form
else if window? => window.form = form
