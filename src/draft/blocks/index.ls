block = (opt) ->
  @ <<< opt
  @

blocks.prototype = Object.create(Object.prototype) <<< do
  set-type: (type) ->
    if typeof type == \object => @type = type
    else @type = types.get type


blocks = ->
  @list = []
  @

blocks.prototype = Object.create(Object.prototype) <<< do
  get-blocks: -> @list.map -> it.name
  add-block: -> if !(it in @list) => @list.push it
  get: (name) -> @list.filter(-> it.name == name).0

module.exports = blocks
