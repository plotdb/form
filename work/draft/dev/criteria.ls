criteria = (opt={}) ->
  @ <<< {type: null, op: null, config: {}}
  if opt.config => @config = opt.config
  if opt.type => @set-type opt.type
  @set-op opt.op
  @

criteria.prototype = Object.create(Object.prototype) <<< do
  set-type: ->
    if !(@rule = rulesets.get-rule(it)) => throw new Error("no such type")
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

if module? => module.exports = criteria
if window? => window.criteria = criteria
