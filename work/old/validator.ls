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

  get-type: (type) ->
    console.log type, @types[type]
    @types[type]
  register: (type, obj) ->
    console.log type, obj
    @types[type] = obj

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
    console.log 1
    if obj.is-empty! =>
      if !(obj.is-required!) => return if (obj.is-touched!) or opt.forced => {result: 0} else {result: 1}
      return {result: 2, message: 'required'}
    console.log 2
    v = obj.get-value!
    console.log v
    criteria = obj.get-criteria!
    console.log 3
    for i from 0 til criteria.length =>
      console.log 4
      c = criteria[i]
      if !c.enabled => continue
      ret = @validate-criteria({v, c})
      if !ret or !(ret.result?) => return {result: 2, message: 'internal error'}
      if ret.result == 2 => return ret
    console.log 5
    return {result: 0}


validator = new Validator!
validator.register \number, {
  sanity-check: ({v,c}) -> !(isNaN(v) or (c.cfg.i? and isNaN(c.cfg.i)) or (c.cfg.j? and isNaN(c.cfg.j)))
  convert: ({v,c}) -> [+v, +(c.cfg.i), +(c.cfg.j)]
  gte: ([v,i]) -> v >= i
  lte: ([v,i]) -> v <= i
  ge: ([v,i]) -> v > i
  le: ([v,i]) -> v < i
  eq: ([v,i]) -> v == i
  ne: ([v,i]) -> v != i
  between: ([v,i,j]) ->
    console.log v,i,j
    v >= i and v <= j
}

module.exports = {Validator}
