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
        if @_ws.w[p]._meta.disabled => return
        @fire \status, {widget: w, path: p, status: s}
        @_restatus-debounced!
    )

  # add(o): remove an widget or a list of widgets. o:
  #  - list
  #  - {path}
  remove: (o) ->
    if Array.isArray(o) => return o.map ~> @remove it
    if !(ws = @_ws.w[o.path]) => return
    ws.off \change, @_ws.l[o.path].c
    ws.off \status, @_ws.l[o.path].s
    @_ws.p.delete ws
    delete @_ws.w[o.path]
    delete @_ws.l[o.path]

  widget: (p) -> @_ws.w[p]

  content: (p) -> if @_ws.w[p] => that.content! else null

  status: -> @_status
  progress: ->
    list = [{k,s} for k,s of @_ws.s].filter ~> !@_ws.w[it.k]._meta.disabled
    ret =
      total: list.length
      done: list.filter((o) -> o.s? and o.s == 0).length
    ret.percent = ret.done / ( ret.total or 1)
    return ret

  _restatus: ->
    os = @_status
    delete @_status
    ret = [{k,v} for k,v of @_ws.w]
      .filter ({k,v}) ~>!v._meta.disabled
      .map ({k,v})~>
        s = @_ws.s[k]
        if !s? => return true
        if s == 0 => return false
        if s == 1 and !v._meta.is-required => return false
        return true
      .filter(->it)
      .length
    @_status = if ret => 1 else 0
    if os != @_status => @fire \readystatechange, @_status == 0

  # o:
  #  - a list of below
  #  - a single object of { widget, path, now(TBD) }
  #  - null: check all
  check: (o, opt) ->
    if typeof(opt) != \object => opt = {now: opt}
    Promise.resolve!
      .then ~>
        if !o =>
          return @check(
            [{widget: w, path: p} for p,w of @_ws.w]
              .filter ({widget}) ->
                if widget._meta.disabled => return false
                # we can tune range of widgets to check even if check all is requested.
                # e.g., set `opt.skipEmpty` to true instruct it to check widgets
                # only if they are not empty or has status 2
                return if !opt.skip-empty => true
                else !widget.is-empty! or widget.status! == 2
            opt
          )
        @[]check-list ++= (if Array.isArray(o) => o else [o])
        return if opt.now => @_check(null, opt) else @_check-debounced(null, opt)
      .then ~> @_restatus!; it

  _check: (o, opt = {}) ->
    if !o =>
      list = (@check-list or [])
      @check-list = []
      return @_check list, opt
    if Array.isArray(o) =>
      return Promise
        .all(o.map ~> @_check it, opt)
        .then -> it.filter(->it)
    return new Promise (res, rej) ~>
      # TBD _now = o.now is defined in spec yet we seem never use it.
      [w, p, _now] = [o.widget, o.path, o.now]
      if !(w and p) => return res!
      if !w and !(w = @_ws.w[p]) => return res!
      if !p => p = @_ws.p[w]
      w.validate opt{force, init, skip-empty}
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
      if w._meta.disabled => continue
      val = w.value!
      # if we omit the (), else will not be executed when !v.files. so keep it here.
      if Array.isArray(v) => (for i from 0 til v.length => fd.append "#p[]", v[i])
      else fd.append p, val
    return fd

  value: (v, opt = {}) ->
    # TODO decompose p and fill ret with given hierarchy
    if !v =>
      ret = {}
      for p,w of @_ws.w => if !w._meta.disabled => ret[p] = w.value!
      return ret
    # dup v to prevent internal change pollutes host object.
    v = JSON.parse(JSON.stringify(v))
    # even if v[p] is "", 0 or event undefined, we should still update them
    # since user may explicitly enter this value in order to overwrite previous value.
    # we by default iterate through all widgets for values even if it's undefined
    # since we don't know if some value are skipped intentionally or accenditally
    # however, user can enforce a partial update by setting opt.partial to true.
    Promise.resolve!then ~>
      ps = for p, w of @_ws.w
        # even if w is disabled, we should still set its value
        # since it may just be disabled temporarily.
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
    Promise.all [w for p, w of @_ws.w].filter((w)->!w._meta.disabled).map((w)->w.mode m)
