form.manager = (o = {}) ->
  # widgets
  @_ws =
    w: {} # path to Widget
    p: new WeakMap! # widget to Path
    s: {} # path to status ( as cache )
    l: {} # path to widget change Listener function
  @_evthdr = {}
  @_status = 1
  @_mode = \edit
  @mod = o.mod{after-check} or {}
  @after-check = debounce 330, (...args) ~> @_after-check.apply @, args
  @_check-debounced = debounce 10, (...args) ~> @_check.apply @, args
  @

## widget def
# - path(): get path ( position in json tree, such as: a.b.c )
# - on
#   - change
form.manager.prototype = Object.create(Object.prototype) <<< do
  on: (n, cb) -> @_evthdr.[][n].push cb
  fire: (n, ...v) -> for cb in (@_evthdr[n] or []) => cb.apply @, v
  # add(o): add an widget or a list of widgets. o:
  #  - list
  #  - {widget, path}
  add: (o) ->
    if Array.isArray(o) => return o.map ~> @add it
    [w,p] = [o.widget, o.path]
    if @_ws.p.get w => return
    @_ws.w[p] = w
    @_ws.p.set w, p
    @_ws.l[p] = {}
    w.on \change, (
      @_ws.l[p].c = (v) ~>
        @check {widget: w, path: p}
        @fire \change, {widget: w, path: p, value: v}
    )
    w.on \status, (@_ws.l[p].s = (s) ~> @check {widget: w, path: p})

  # add(o): remove an widget or a list of widgets. o:
  #  - list
  #  - {path}
  remove: (o) ->
    if Array.isArray(o) => return o.map ~> @remove it
    if !(ws = @_ws.w[o.path]) => return
    o.off \change, @_ws.l[o.path].c
    o.off \status, @_ws.l[o.path].s
    @_ws.p.delete ws
    delete @_ws.w[o.path]
    delete @_ws.l[o.path]

  widget: (p) -> @_ws[p]
  status: (v) -> return if !(v?) => @_status else @_status = v
  progress: ->
    ret =
      total: [k for k of @_ws.w].length
      done: [s for k,s of @_ws.s].filter((s) -> s? and s == 0).length
    ret.percent = ret.done / ret.total
    return ret

  _after-check: ->
    os = @_status
    delete @_status
    # user might not customize s.all in after-check.
    # if it's not updated, we then calculate it for them.
    @mod.after-check.apply @
    if !(@_status?) =>
      ret = [@_ws.s[k] for k,v of @_ws.w].filter((s) ~> !(s? and s == 0)).length
      @_status = if ret => 1 else 0
    if os != @_status => @fire \readystatechange, @_status == 0

  # o:
  #  - a list of below
  #  - a single object of { widget, path, now }
  #  - null: check all
  check: (o, now = false) ->
    if !o => return @check [{widget: w, path: p} for p,w of @_ws.w]
    @[]check-list ++= (if Array.isArray(o) => o else [o])
    if now => @_check! else @_check-debounced!

  _check: (o) ->
    if !o =>
      list = (@check-list or [])
      @check-list = []
      return @_check(list)
    if Array.isArray(o) => return Promise.all o.map(~> @_check it)
    return new Promise (res, rej) ~>
      [w, p, now] = [o.widget, o.path, o.now]
      if !(w and p) => return res!
      if !w and !(w = @_ws.w[p]) => return res!
      if !p => p = @_ws.p[w]
      w.validate!
        .then ~>
          os = @_ws.s[p]
          @_ws.s[p] = w.status!
          if os != @_ws.s[p] => @fire \status, {path: p, widget: w, status: @_ws.s[p]}
          if now => @after-check.now! else @after-check!
        .then -> res!


  # return a FormData with all fields flattened by its path as form data field name.
  form-data: ->
    fd = new FormData!
    for p,w of @_ws.w =>
      val = w.value!
      # if we omit the (), else will not be executed when !v.files. so keep it here.
      if Array.isArray(v) => (for i from 0 til v.length => fd.append "#p[]", v[i])
      else fd.append p, val
    return fd

  value: (v) ->
    # TODO decompose p and fill ret with given hierarchy
    if !v =>
      ret = {}
      for p,w of @_ws.w => ret[p] = w.value!
      return ret
    for p,w of @_ws.w => if v[p] => w.value v[p]

  mode: (m) ->
    if !(m?) => return @_mode
    if !(m in <[edit view config]>) => throw (new Error! <<< {name: \lderror, id: 1015})
    if @_mode == m => return
    @_mode = m
    @fire \mode, m
    for p,w of @_ws.w => w.mode m
