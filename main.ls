form-host = (opt = {}) ->
  @opt = opt
  @blocks = {}
  @

form-host.prototype = Object.create(Object.prototype) <<< do
  register: (n,o) -> @blocks[n] = o
  prepare: (o) ->
    o.block.map (b,i) ->

form-block = ->
  @

form-block.prototype = Object.create(Object.prototype) <<< {}

form-file = ->
  @
form-file.prototype = Object.create(form-block.prototype) <<< {}

fh = new form-host!
fh.register "form-file", form-file


form-def = {
  block: [
    { name: "form-file" }
  ]
}

fh.prepare form-def
