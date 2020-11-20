rules = do
  list: []
  get-rule: (n) -> @list.filter(->it.type == n).0
  add: -> @list.push new rule(it)
  verify: (v, criteria) ->
    if !(rule = @get-rule(criteria.type)) => return false
    payload = {v} <<< {c: criteria}
    if rule.sanity-check(payload) =>
      {v,c} = rule.convert(payload)
      op = rule.operations[c.op]
      if typeof(op) == \function => op {v,c} else op.func {v,c}
    else return false

rule = (opt) ->
  @ <<< opt
  @

rule.prototype = Object.create(Object.prototype) <<< do
  get-rule: -> return @
  verify: rules.verify

rules.add do
  i18n:
    number: zh-tw: \文字, zh: 'String'
  type: \string
  sanity-check: ({v,c}) -> v? and c.config.i?
  convert: ({v,c}) ->
    v = "#{v}"
    c.config.i = "#{c.config.i}"
    return {v,c}
  default-operation: \include
  operations:
    include:
      args: <[i]>
      func: ({v,c}) -> !!~v.indexOf(c.config.i)
    exclude:
      args: <[i]>
      func: ({v,c}) -> !~v.indexOf(c.config.i)
    email: ({v,c}) -> /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.[a-z]{2,}|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i.exec(v)
    url: ({v,c}) -> /^\s*http(s):\/\/[a-zA-Z0-9-]+/.exec(v)



rules.add do
  i18n:
    number: zh-tw: \數字, zh: 'Number'
    ge: zh-tw: \大於, en: 'Greater Than'
  type: \number
  sanity-check: ({v,c}) ->
    if isNaN(v) => return false
    if !(c.config.i?) or isNaN(c.config.i) => return false
    if !(c.config.j?) or isNaN(c.config.j) => return false
    return true
  convert: ({v,c}) ->
    v = +v
    c.config.i = +c.config.i
    c.config.j = +c.config.j
    return {v,c}
  operations:
    gte: ({v,c}) -> v >= c.config.i
    lte: ({v,c}) -> v <= c.config.i
    ge: ({v,c}) -> v > c.config.i
    le: ({v,c}) -> v < c.config.i
    eq: ({v,c}) -> v == c.config.i
    ne: ({v,c}) -> v != c.config.i
    between:
      args: <[i j]>
      func: ({v,c}) -> v >= c.config.i and v <= c.config.j

criteria = (opt={}) ->
  @ <<< {type: null, op: null} <<< opt{config}
  if opt.type => @set-type opt.type
  if opt.op => @set-op opt.op
  @

criteria.prototype = Object.create(Object.prototype) <<< do
  set-type: ->
    if !(@rule = rules.get-rule(it)) => throw new Error("no such type")
    @type = it
    @set-op!
  # called with no arg to reset to default
  set-op: ->
    if !@rule => throw new Error("type not set")
    if !it => @op = @rule.default-operation or [k for k of @rule.operations].0
    else if !@rule.operations[@op = it] => throw new Error("no such op")
  set-config: -> @config = it
  verify: (v) ->
    if !@rule => throw new Error("type not set")
    @rule.verify(v,@)

module.exports = criteria
