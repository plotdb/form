ruleset = do
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

module.exports = ruleset
