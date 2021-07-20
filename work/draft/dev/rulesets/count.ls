ruleset = do
  i18n: count: zh-tw: \數量, en: \count
  type: \count
  sanity-check: ({v,c}) -> v? and c.config.i? and c.config.j?
  convert: ({v,c}) ->
    len = if Array.isArray(v) => v.length else if v? => (v.length or "#{v}".length) else 0
    return [len, +(c.config.i or 0), +(c.config.j or 0)]
  default-operation: \gte
  operations:
    gte:
      args: <[i]>
      func: ({v,c}) -> v >= c.config.i
    lte:
      args: <[i]>
      func: ({v,c}) -> v <= c.config.i
    eq:
      args: <[i]>
      func: ({v,c}) -> v == c.config.i
    between:
      args: <[i j]>
      func: ({v,c}) -> v >= c.config.i and v <= c.config.j

module.exports = ruleset
