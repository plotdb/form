form.type.register do
  name: \string
  id: \string
  sanity-check: ({v,c}) -> v?
  convert: ({v,c}) ->
    v = "#{v}"
    if c.{}config.i? => c.config.i = "#{c.config.i}"
    return {v,c}
  opset: \string

form.opset.register do
  name: \string
  id: \string
  default-op: \include
  ops:
    include:
      args: <[i]>
      func: ({v,c}) -> !!~v.indexOf(c.config.i)
    exclude:
      args: <[i]>
      func: ({v,c}) -> !~v.indexOf(c.config.i)
    email: ({v,c}) -> curegex.get(\email).exec(v)
    url: ({v,c}) -> curegex.get(\url).exec(v)
