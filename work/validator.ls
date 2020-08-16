/*
[{"op": "gte", "type": "count", "enabled": true}]},
  op
  type
  enabled
validator = {}


{value, empty}
validator.validate = ({value, criteria}) ->
  for i from 0 til criteria.length =>
    c = criteria[i]
    ret = handler[c.type][c.op]({value, c})
    if ret and !ret.result => return ret
    #
    # result: success/failed ( 0,1,2)
    # message: '...'
validator.register = ({type, obj}) ->
  handler[type] = obj



if is-empty! and not-touched! and !forced => 1
else
  ret = validate!
  if ret => return 0
  else return 2

validator = new Validator!
validator.register block-class
block-obj = new block-class!
*/

Validator = ->
  @types = {}
  @

Validator.prototype = Object.create(Object.prototype) <<< do

  get-type: (type) -> @types[type]
  register: (type, obj) -> @types[type] = obj

  # validate / validate-criteria return value: 
  # - result: either 0, 1, or 2 ( success, pending, failed )
  #   message: error message. ( i18n? )

  # validate with a specific criteria
  validate-criteria: ({v, c}) ->
    # type not found
    if !(type = @get-type(c.type)) => return {result: 2, error: 'type not found'}
    # wrong op or undefined convert
    if !(type[c.op] and type.convert) => return {result: 2, error: 'convert or op not found'}
    # if incorrect type of value and options in criteria, return
    if !(type.sanity-check({v, c})) => return {result: 2, error: 'sanity-check failed'}
    # convert value and options in criteria to correct type, then apply op
    if !(ret = type[c.op](type.convert({v, c}))) => return {result: 2, message: c.message}
    return {result: 0}

  # validate with obj
  validate: (obj={}, opt={}) ->
    if obj.is-empty! =>
      if !(obj.is-required!) => return if (obj.dirty!) or opt.forced => {result: 0} else {result: 1}
      return {result: 2, message: 'required'}
    v = obj.get-value!
    criteria = obj.get-criteria!
    for i from 0 til criteria.length =>
      c = criteria[i]
      if !c.enabled => continue
      ret = @validate-criteria({v, c})
      if !ret or !(ret.result?) => return {result: 2, message: 'internal error'}
      if ret.result == 2 => return ret
    return {result: 0}


validator = new Validator!
validator.register \number, do
  sanity-check: ({v,c}) -> !(isNaN(v) or (c.cfg.i? and isNaN(c.cfg.i)) or (c.cfg.j? and isNaN(c.cfg.j)))
  convert: ({v,c}) -> [+v, +(c.cfg.i), +(c.cfg.j)]
  gte: ([v,i]) -> v >= i
  lte: ([v,i]) -> v <= i
  ge: ([v,i]) -> v > i
  le: ([v,i]) -> v < i
  eq: ([v,i]) -> v == i
  ne: ([v,i]) -> v != i
  between: ([v,i,j]) -> v >= i and v <= j

obj = do
  get-value: -> 5
  is-empty: -> false
  is-required: -> true
  get-criteria: -> [{enabled: true, type: \number, op: \between, cfg: {i: 2, j: 6}, message: 'not between'}]

ret = validator.validate obj, {}
console.log ret

module.exports = {Validator}
