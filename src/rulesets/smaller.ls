ruleset =do
  i18n: count: zh-tw: "小於", en: "smaller"
  type: \smaller
  sanity-check: ({v,c}) -> !(isNaN(v) or (c.config.i? and isNaN(c.config.i)) or (c.config.j? and isNaN(c.config.j)))
  convert: ({v,c}) ->
    c = {config: {i: +(c.config.i or 0), j: +(c.config.j or 0)}}
    {v: +v, c}
  default-operation: \le
  operations:
    le:
      args: <[i]>
      func: ({v,c}) -> v < c.config.i

module.exports = ruleset
