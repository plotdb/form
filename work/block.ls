base = -> @init.apply @, arguments; @

base.prototype = Object.create(Object.prototype) <<< do
  init: ->
    @ <<< criteria: [], cfg: {}, value: null
    @
  set-value: -> @value = it
  get-value: -> @value
  is-touched: -> @touched
  touch: -> @touched = true
  is-empty: ->
  is-required: -> @cfg.required
  get-criteria: -> @criteria or []
  add-criteria: -> @criteria.push it
  serialize: -> @{criteria, cfg, value}
  deserialize: ->


input = -> base.prototype.init.apply @, arguments; @
input.prototype = Object.create(Object.prototype) <<< base.prototype <<< do
  init: -> @value = null
  set-value: -> @value = it
  get-value: -> @value
  is-empty: -> !((@get-value!)?)

module.exports = {input, base}
