criteria = require './index'

c = new criteria {type: \number, op: \between, config: {i: 5, j: 20}}
console.log(c.verify 30)
c.set-type \string
c.set-op \include
c.set-config {i: 'hello'}
console.log c.verify \hello

