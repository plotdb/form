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
    if !(type = @get-type(c.type)) => return
    # wrong op or undefined convert
    if !(type[c.op] and type.convert) => return
    # if incorrect type of value and options in criteria, return
    if !(type.sanity-check({v, c}) => return
    # convert value and options in criteria to correct type, then apply op
    return type[op](type.convert({v, c}))

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
      if !ret or !(res.result?) => return {result: 2, message: 'internal error'}
      if ret.result == 2 => return ret
    return {result: 0}
