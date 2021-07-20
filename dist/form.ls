form = {}
form.manager = ->
  @_fields = []
  @

form.manager.prototype = Object.create(Object.prototype) <<< do
  add: -> @_fields ++= if Array.isArray(it) => it else [it]
  fields: -> @_fields
  serialize: -> @_fields.map -> it.serialize!
  value: (vs) ->
    if !vs => return Object.fromEntries(@_fields.map -> [it.data.alias or it.data.key, it.value!])
    for k,v of vs =>
      f = @_fields.filter(-> (it.data.alias == k or it.data.key == k)).0
      if !f => continue
      f.value v
  mode: (m) -> @_fields.map -> it.set-mode m

# 規則運算子
form.op = (opt = {}) ->
  @ <<< opt{id, name, config, func}
  @

form.op.prototype = Object.create(Object.prototype) <<< do
  verify: (val, cfg = {}) ->
    if (ret = @func val, cfg) instanceof Promise => ret else Promise.resolve(!!ret)
  get-config-default: ->
    cfg = {}
    for k,v of @config => cfg[k] = v.default
    return cfg


# 資料驗證的規則集
form.opset = (opt={}) ->
  @ <<< opt{name, id}
  @ <<< {ops: {}}
  ops = if Array.isArray(opt.ops) => opt.ops.map -> {v: it, k: it.id}
  else [{k,v} for k,v of opt.ops]
  ops.map ({k,v}) ~>
    @ops[k] = if v instanceof form.op => v
    else if k => new form.op((if typeof(v) == \function => {func: v} else v) <<< {id: k})
    else throw new Error('invalid op when initializing opset.')
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
    @config = if !cfg => @op.get-config-default! else cfg

  verify: (v) ->
    if !@op => Promis.reject(new Error("op not set"))
    @op.verify(v, @config)

  serialize: ->
    return {enabled: @enabled, opset: @opset.id, op: @op.id, config: @config}

  deserialize: (v) ->
    @toggle v.enabled
    @set-opset v.opset, v.op, v.config
form.widget = (opt = {}) ->
  @root = if typeof(opt.root) == \string => document.querySelector(opt.root) else opt.root
  @evt-handler = {}
  @data = {config: {}, key: suuid!}
  @ <<< _value: null, _empty: true
  @_mode = opt.mode or \view
  @opsets = opt.opsets or []
  @errors = []
  @

form.widget.prototype = Object.create(Object.prototype) <<< do
  on: (n, cb) -> (if Array.isArray(n) => n else [n]).map (n) ~> @evt-handler.[][n].push cb
  fire: (n, ...v) -> for cb in (@evt-handler[n] or []) => cb.apply @, v
  serialize: ->
    ret = {} <<< @data{key, title, desc}
    ret.config = JSON.parse(JSON.stringify(@data.config or {}))
    ret.term = @data.term.map -> it.serialize!
    ret
  deserialize: (v) ->
    @data <<< v{key, title, desc}
    @data.config = JSON.parse(JSON.stringify(v.config or {}))
    # TODO
    @data.term = v.term.map -> new form.term!deserialize it

  mode: ->
    if !(it?) => return @_mode
    @mode = it
    @verify!
    @render!
  value: (v, is-empty = false, from-source = false) ->
    if v? =>
      @ <<< _value: v, _empty: is-empty
      @verify!
    if !source => @fire \change, @_value
    return @_value

  verify: ->
    if @_empty and @data.config.is-required =>
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

  render: ->

if (module?) => module.exports = form
else if window? => window.form = form
