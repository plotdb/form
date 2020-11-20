xvalid = do
  number: do
    type: (v,i,j) -> !(isNaN(v) or (i? and isNaN(i)) or (j? and isNaN(j)))
    convert: (v,i,j) -> [+v,+(i or 0),+(j or 0)]
    gte: (v,i) -> v >= i
    lte: (v,i) -> v <= i
    ge: (v,i) -> v > i
    le: (v,i) -> v < i
    eq: (v,i) -> v == i
    ne: (v,i) -> v != i
    between: (v,i,j) -> v >= i and v <= j

valid = do
  number: gte: (v, opt = {}) -> v >= opt.a


criteria = do
  type: do
    number: do
      gte: (v, o) -> v >= o.a
  register: (name, obj) -> criteria.type[name] = obj


criteria.register \string, {contains: (v,o) -> v.indexOf(o.a)}


