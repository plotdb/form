rulesets = do
  list: []
  get-rule: (n) -> @list.filter(->it.type == n).0
  add: -> @list.push new ruleset(it)
  verify: (v, criteria) ->
    if !(rule = @get-rule(criteria.type)) => return false
    payload = {v} <<< {c: criteria}
    if rule.sanity-check(payload) =>
      {v,c} = rule.convert(payload)
      op = rule.operations[c.op]
      if typeof(op) == \function => op {v,c} else op.func {v,c}
    else return false

ruleset = (opt) ->
  @ <<< opt
  @
ruleset.prototype = Object.create(Object.prototype) <<< do
  get-rule: -> return @
  verify: rulesets.verify

if module? => module.exports = rulesets
if window? => window.ruleset = ruleset
if window? => window.rulesets = rulesets

