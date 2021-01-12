ruleset = do
  i18n:
    number: zh-tw: \文字, zh: 'String'
  type: \string
  sanity-check: ({v,c}) -> v?
  convert: ({v,c}) ->
    v = "#{v}"
    if c.{}config.i? => c.config.i = "#{c.config.i}"
    return {v,c}
  default-operation: \include
  operations:
    include:
      args: <[i]>
      func: ({v,c}) -> !!~v.indexOf(c.config.i)
    exclude:
      args: <[i]>
      func: ({v,c}) -> !~v.indexOf(c.config.i)
    email: ({v,c}) -> curegex.get(\email).exec(v)
    url: ({v,c}) -> curegex.get(\url).exec(v)

if rulesets? => rulesets.add ruleset
if module? => module.exports = ruleset
