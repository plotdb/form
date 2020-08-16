module = -> @init.apply @, arguments; @

module.prototype = Object.create(Object.prototype) <<< do
  init: ->
    @ <<< criteria: [], cfg: {}, value: null
    @
  set-value: -> @value = it
  get-value: -> @value
  is-empty: ->
  is-required: -> @cfg.required
  get-criteria: -> @criteria or []
  serialize: -> @{criteria, cfg, value}
  deserialize: ->


input = -> @module.prototype.apply @, arguments; @
input.prototype = Object.create(Object.prototype) <<< module.prototype <<< do
  init: -> @value = {text: ''}
  set-value: -> @value = it
  get-value: -> @value
  is-empty: -> !!(@get-value!)

module.exports = {input, module}
