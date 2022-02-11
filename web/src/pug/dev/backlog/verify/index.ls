op1 = new form.op do
  id: 'email', config: {}, func: (v, c) -> v.length < c.len 
op2 = new form.op do
  id: 'between', config: {}, func: (v, c) -> v > c.range.0 and v < c.range.1

opset = new form.opset do
  id: 'random-set'
  ops: [op1, op2]
  defaultOp: 'email'

form.opset.register opset

opset = form.opset.get \random-set
console.log opset.get-op \email
console.log opset.ops
opset.get-op \email .verify 'dummy@dummy.dummy', len: 50
  .then ->
    console.log it
    opset.get-op \between .verify 50, range: [20,60]
  .then ->
    console.log it


