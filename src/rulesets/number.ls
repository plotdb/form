ruleset = do
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

module.exports = ruleset
