form.manager = ->
  # widgets
  @_ws =
    w: {} # path to Widget
    p: new WeakMap! # widget to Path
    l: {} # path to widget change Listener function
  @_evthdr = {}
  # @_status = status = {all: 1}
  #<[debounce verify names getFields afterCheck]>.map (n) ~> if opt[n] => @[n] = opt[n]
  @

## widget def
# - path(): get path ( position in json tree, such as: a.b.c )
# - on
#   - change
form.manager.prototype = Object.create(Object.prototype) <<< do
  on: (n, cb) -> @evt-handler.[][n].push cb
  fire: (n, ...v) -> for cb in (@evt-handler[n] or []) => cb.apply @, v
  # add(o): add an widget or a list of widgets. o:
  #  - list
  #  - {widget, path}
  add: (o) ->
    if Array.isArray(o) => return o.map ~> @add it
    {w,p} = o
    @_ws.w[p] = w
    @_ws.p.set w, p
    o.on \change, (@_ws.l[p] = (evt) ~> @check {widget: w, path: p, evt})

  # add(o): remove an widget or a list of widgets. o:
  #  - list
  #  - {path}
  remove: (o) ->
    if Array.isArray(o) => return o.map ~> @remove it
    if !(ws = @_ws.w[o.path]) => return
    o.off \change, @_ws.l[o.path]
    @_ws.p.delete ws
    delete @_ws.w[o.path]
    delete @_ws.l[o.path]

  widget: (p) -> @_ws[p]

  # o:
  #  - a list of below
  #  - a single object of { widget, path, evt, now }
  check: (o = {}) ->
    if Array.isArray(o) => return Promise.all o.map(~> @check it)
    new Promise (res, rej) ~>
      [w, p, now] = [o.widget, o.path o.now]
      if !(w and p) => return
      if !w and !(w = @_ws.w[p]) => return
      w.validate!then -> /* ... TODO */
      /*
      if n and !(n in @names(s)) => return
      if n? and !@fields[n] => return rej new Error("ldform.check: field #n not found.")
      [fs,s] = [@fields, @status]
      if fs[n] =>
        if !Array.isArray(fs[n]) => v = fs[n].value
        else
          v = fs[n].filter(->it.checked).map(->it.value)
          if fs[n].0.getAttribute(\type) == \radio => v = v.0
        s[n] = @verify( n, v, fs[n])
      if @debounce(n, s) and !now => @check-debounced(n,fs,s,res,rej) else @check-debounced(n,fs,s,res,rej).now!
      */

  /*
  field: (n) -> @_fields[n]
  fields: -> @_fields
  serialize: -> @_fields.map -> it.serialize!
  value: (vs) ->
    if !vs => return Object.fromEntries(@_fields.map -> [it.key!, it.value!])
    for k,v of vs =>
      f = @_fields.filter(-> (it.key! == k)).0
      if !f => continue
      f.value v
  */
  #mode: (m) -> @_fields.map -> it.mode m
