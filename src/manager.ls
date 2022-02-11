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
  @_mod = {}
  @_check-debounced = debounce 10, (...args) ~> @_check.apply @, args
  @_restatus-debounced = debounce 10, (...args) ~> @_restatus.apply @, args
  @

## widget def
# - path(): get path ( position in json tree, such as: a.b.c )
# - on
#   - change
form.manager.prototype = Object.create(Object.prototype) <<< do
  on: (n, cb) -> (if Array.isArray(n) => n else [n]).map (n) ~> @_evthdr.[][n].push cb
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
    @_ws.s[p] = w.status!
    w.on \change, (
      @_ws.l[p].c = (v) ~>
        @fire \change, {widget: w, path: p, value: v}
    )
    w.on \status, (
      @_ws.l[p].s = (s) ~>
        @_ws.s[p] = s
        @fire \status, {widget: w, path: p, status: s}
        @_restatus-debounced!
    )

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

  widget: (p) -> @_ws.w[p]
  status: -> @_status
  progress: ->
    ret =
      total: [k for k of @_ws.w].length
      done: [s for k,s of @_ws.s].filter((s) -> s? and s == 0).length
    ret.percent = ret.done / ( ret.total or 1)
    return ret

  _restatus: ->
    os = @_status
    delete @_status
    ret = [@_ws.s[k] for k,v of @_ws.w].filter((s) ~> !(s? and s == 0)).length
    @_status = if ret => 1 else 0
    if os != @_status => @fire \readystatechange, @_status == 0

  # o:
  #  - a list of below
  #  - a single object of { widget, path, now }
  #  - null: check all
  check: (o, now = false) ->
    Promise.resolve!
      .then ~>
        if !o => return @check [{widget: w, path: p} for p,w of @_ws.w], now
        @[]check-list ++= (if Array.isArray(o) => o else [o])
        return if now => @_check(null, true) else @_check-debounced!
      .then ~> @_restatus!

  _check: (o, now) ->
    if !o =>
      list = (@check-list or [])
      @check-list = []
      return @_check(list, now)
    if Array.isArray(o) =>
      return Promise
        .all(o.map ~> @_check it, now)
        .then -> it.filter(->it)
    return new Promise (res, rej) ~>
      [w, p, _now] = [o.widget, o.path, o.now]
      if !(w and p) => return res!
      if !w and !(w = @_ws.w[p]) => return res!
      if !p => p = @_ws.p[w]
      w.validate!
        .then ~>
          os = @_ws.s[p]
          @_ws.s[p] = w.status!
          if os != @_ws.s[p] => @fire \status, {path: p, widget: w, status: @_ws.s[p]}
          @_ws.s[p]
        .then ~> if @_ws.s[p] == 2 => res {widget: w, path: p, status: @_ws.s[p]} else res!

  # return a FormData with all fields flattened by its path as form data field name.
  form-data: ->
    fd = new FormData!
    for p,w of @_ws.w =>
      val = w.value!
      # if we omit the (), else will not be executed when !v.files. so keep it here.
      if Array.isArray(v) => (for i from 0 til v.length => fd.append "#p[]", v[i])
      else fd.append p, val
    return fd

  value: (v, opt = {}) ->
    # TODO decompose p and fill ret with given hierarchy
    if !v =>
      ret = {}
      for p,w of @_ws.w => ret[p] = w.value!
      return ret
    # even if v[p] is "", 0 or event undefined, we should still update them
    # since user may explicitly enter this value in order to overwrite previous value.
    # we by default iterate through all widgets for values even if it's undefined
    # since we don't know if some value are skipped intentionally or accenditally
    # however, user can enforce a partial update by setting opt.partial to true.
    Promise.resolve!then ->
      ps = for p, w of @_ws.w
        if !v.hasOwnProperty(p) and opt.partial => continue
        w.value v[p], opt
      Promise.all ps

  mode: (m) ->
    if !(m?) => return @_mode
    <~ Promise.resolve!then _
    if !(m in <[edit view config]>) => return Promise.reject(new Error! <<< {name: \lderror, id: 1015})
    if @_mode == m => return
    @_mode = m
    @fire \mode, m
    Promise.all [w.mode m for p, w of @_ws.w]
