form = {}

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
    if typeof(opset) == \string => if !(@opset = form.opset.get opset) => throw new Error("no such opset '#opset'")
    else if opset instanceof form.opset => @opset = opset
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
