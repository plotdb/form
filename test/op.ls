form-def = require "../src/form.def"

op = new form-def.op do
  id: 'some-test'
  config: do
    divisor: type: \number, default: 2
    remainder: type: \number, default: 1
  func: (value, config) -> Promise.resolve((value % config.divisor) == config.remainder)

op.verify 5, {divisor: 3, remainder: 2}
  .then -> console.log '1', (if it => \ok else 'not ok')
op.verify 5
  .then -> console.log '2', (if it => \ok else 'not ok')

ops = [
 * id: \gte, name: '>=', config: {value: type: \number, default: 1}, func: (v,c) -> v >= c.value
 * id: \lte, name: '<=', config: {value: type: \number, default: 1}, func: (v,c) -> v <= c.value
 * id: \eq,  name: '=',  config: {value: type: \number, default: 1}, func: (v,c) -> v == c.value
 * id: \between, name: \between,
   config:
     v1: type: \number, default: 0
     v2: type: \number, default: 2
   func: (v,c) ->
     [i,j] = if c.v1 < c.v2 => [c.v1, c.v2] else [c.v2, c.v1]
     return v >= c.i and v <= c.j
]

opset1 = new form-def.opset do
  id: 'count'
  ops: ops

opset2 = new form-def.opset do
  id: 'count-alt'
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

op = opset2.get-op \gte
op.verify 3, {value: 2} .then -> console.log "is 3 > 2 ? ", it


t = new form-def.term do
  opset: opset2
  op: 'between'
  config: v1: 3, v2: 5

t.verify 4 .then -> console.log "t.verify: ", it
