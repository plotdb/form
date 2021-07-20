# 整個表單的定義
form = (opt={}) -> @
form.prototype = Object.create(Object.prototype) <<< {}

# 表單各資源的管理
form.manager = -> @
form.manager.prototype = Object.create(Object.prototype) <<< {}

mgr = new form.manager!

# 表單單元的定義
form.block = (opt={}) ->
  @

form.block.prototype = Object.create(Object.prototype) <<< {}
form.block.register = (n,c) -> @[]list.push((new form.block(c)) <<< {name: n})
form.block.get = (id) -> @[]list.filter(->(it.id or it.name) == id).0

#blockbase = do
#  init: ({data}) ->
#    @data = data{id,alias,title,desc,is-public,is-required,show-desc,config,resouces}

/*
# 單元資料型態的定義 ( 併入 opset? )
form.type = (opt={}) ->
  @ <<< opt{name, id}
  @cast = if opt.cast instanceof Function => opt.cast else (->it)
  @is-empty = if opt.is-empty instanceof Function => opt.is-empty else (->it)
  @opset = if opt.opset instanceof form.opset => opt.opset
  else if typeof(opt.opset) == \object => new form.opset(opt.opset)
  else form.opset.get(opt.opset)
  @

form.type.prototype = Object.create(Object.prototype) <<< {}
form.type.register = -> @[]list.push new form.type(it)
form.type.get = (id) -> @[]list.filter(->(it.id or it.name) == id).0
*/



if module? => module.exports = form
else if window? => window.form = form


form.opset.register do
  id: \count
  default-op: \gte
  ops:
    gte: name: '>=', config: {value: type: \number, default: 1}, func: (v,c) -> v >= c.value
    lte: name: '<=', config: {value: type: \number, default: 1}, func: (v,c) -> v <= c.value
    eq:  name: '=',  config: {value: type: \number, default: 1}, func: (v,c) -> v == c.value
    between:
      name: \between
      config:
        v1: type: \number, default: 0
        v2: type: \number, default: 2
      func: (v,c) ->
        [i,j] = if c.v1 < c.v2 => [c.v1, c.v2] else [c.v2, c.v1]
        return v >= i and v <= j

form.opset.register do
  id: \number
  default-op: \gte
  ops:
    gt: name: '>', config: {value: type: \number, default: 1}, func: (v,c) -> v > c.value
    lt: name: '<', config: {value: type: \number, default: 1}, func: (v,c) -> v < c.value
    gte: name: '>=', config: {value: type: \number, default: 1}, func: (v,c) -> v >= c.value
    lte: name: '<=', config: {value: type: \number, default: 1}, func: (v,c) -> v <= c.value
    eq:  name: '=',  config: {value: type: \number, default: 1}, func: (v,c) -> v == c.value
    between:
      name: \between
      config:
        v1: type: \number, default: 0
        v2: type: \number, default: 2
      func: (v,c) ->
        [i,j] = if c.v1 < c.v2 => [c.v1, c.v2] else [c.v2, c.v1]
        return v >= i and v <= j



form.opset.register do
  id: \string
  default-op: \include
  ops:
    include:
      config: {i: type: \string, default: 'some text'}
      func: (v,c) -> ~v.indexOf(c.i)
    exclude:
      config: {i: type: \string, default: 'some text'}
      func: (v,c) -> !~v.indexOf(c.i)
    email: (v) -> curegex.get(\email).exec(v)
    url: (v) -> curegex.get(\url).exec(v)
