require! <[./block ./validator]>
console.log block
b = new block.input!
v = new validator.Validator!

obj = do
  get-value: -> 5
  is-empty: -> false
  is-required: -> true
  get-criteria: -> [{enabled: true, type: \number, op: \between, cfg: {i: 2, j: 6}, message: 'not between'}]


b.set-value 2
b.touch!
b.add-criteria {enabled: true, type: \number, op: \between, cfg: {i: 5, j: 10}}

ret = v.validate b, {}
console.log ret
