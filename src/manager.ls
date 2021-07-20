form.manager = ->
  @_fields = []
  @

form.manager.prototype = Object.create(Object.prototype) <<< do
  add: -> @_fields ++= if Array.isArray(it) => it else [it]
  fields: -> @_fields
  serialize: -> @_fields.map -> it.serialize!
  value: (vs) ->
    if !vs => return Object.fromEntries(@_fields.map -> [it._meta.alias or it._meta.key, it.value!])
    for k,v of vs =>
      f = @_fields.filter(-> (it._meta.alias == k or it._meta.key == k)).0
      if !f => continue
      f.value v
  mode: (m) -> @_fields.map -> it.mode m

