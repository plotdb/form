# 整個表單的定義
form = (opt={}) -> @
form.prototype = Object.create(Object.prototype) <<< {}

# 表單各資源的管理
form.manager = ->
form.manager.prototype = Object.create(Object.prototype) <<< {}

mgr = new form.manager!

# 表單單元的定義
form.block = (opt={}) -> @
form.block.prototype = Object.create(Object.prototype) <<< {}

# 單元資料型態的定義
form.type = (opt={}) -> @
form.type.prototype = Object.create(Object.prototype) <<< {}
form.type.register = -> @[]list.push new form.type(it)

# 資料驗證的規則集
form.opset = (opt={}) ->
  @ <<< opt{name, id}
  @ <<< {ops: {}}
  for k,v of opt.ops => @ops[k] = new form.op((if typeof(v) == \function => {func: v} else v) <<< {name: k, id: k})
  @default-op = opt.default-op or [k for k,v of @ops].0
  @

form.opset.prototype = Object.create(Object.prototype) <<< do
  get-op: (id) -> @ops[id or @default-op]
form.opset.register = -> @[]list.push new form.opset(it)

# 規則運算子
form.op = (opt = {}) ->
  @ <<< opt{id, name, config, args, func}
  @

form.op.prototype = Object.create(Object.prototype) <<< do
  get-config: -> @config or {}
  verify: (params) -> !!@func params


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
  if opt.opset => @set-opset that
  if opt.op => @set-op that
  if opt.config => @set-config that
  @

form.term.prototype = Object.create(Object.prototype) <<< do
  toggle: -> @enabled = if it? => it else !@enabled
  set-opset: (id) ->
    if !(@opset = (form.opset.list.filter -> it.id == id).0) => throw new Error("no such opset '#id'")
    @set-op!

  # called with no arg to reset to default
  set-op: (id) ->
    if !@opset => throw new Error("opset not set")
    if !(@op = @opset.get-op(id)) => throw new Error("no such op '#id'")
    @set-config!

  set-config: (cfg) ->
    if !@op => throw new Error("op not set")
    @config = if !cfg => @op.get-config! else cfg

  verify: (v) ->
    if !@op => throw new Error("op not set")
    @op.verify({v, c: @config})

window.form = form
