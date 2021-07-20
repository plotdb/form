form.manager = ->
  @_fields = []
  @

form.manager.prototype = Object.create(Object.prototype) <<< do
  add: -> @_fields ++= if Array.isArray(it) => it else [it]
  fields: -> @_fields
  serialize: -> @_fields.map -> it.serialize!
  value: (vs) ->
    if !vs => return Object.fromEntries(@_fields.map -> [it.data.alias or it.data.key, it.value!])
    for k,v of vs =>
      f = @_fields.filter(-> (it.data.alias == k or it.data.key == k)).0
      if !f => continue
      f.value v
  mode: (m) -> @_fields.map -> it.set-mode m

