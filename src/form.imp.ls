long-answer = -> @
long-answer.prototype = Object.create(Object.prototype) <<< form.block.prototype <<< do
  attributes: ->
  serialize: ->
  deserialize: ->
  toString: ->
  parse: ->


form.type.register do
  name: \string
  id: \string
  opset: \string
  cast: (v) -> if v? => "#v" else ""

form.opset.register do
  name: \string
  id: \string
  default-op: \include
  ops:
    include:
      config: {i: 'some text'}
      func: ({v,c}) -> !!~v.indexOf(c.config.i)
    exclude:
      config: {i: 'some text'}
      func: ({v,c}) -> !~v.indexOf(c.config.i)
    email: ({v,c}) -> curegex.get(\email).exec(v)
    url: ({v,c}) -> curegex.get(\url).exec(v)
