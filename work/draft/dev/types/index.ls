type = (opt) ->
  @ <<< opt
  @

type.prototype = Object.create(Object.prototype) <<< do
  get-attrs: -> [k for k of @attrs]

types = do
  list: []
  get-type: (n) -> @list.filter(->it.type == n).0
  add: -> @list.push new type(it)

module.exports = types

