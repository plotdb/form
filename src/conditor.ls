# conditor: conditional states of widgets, defined as serializable rules.
# replaces `form.condctrl`. see doc/conditor/index.md.
#
# rule: {id, name, when, precond, effect}
#  - when: expression in a subset of JSONLogic ( https://jsonlogic.com ). `var` outside `some` / `all` / `none`
#    reads widget content by path ( see `manager.resolve` ); inside their predicate, it reads the current item.
#  - precond: id of another rule; this rule is inactive unless that rule is active.
#  - effect: {targets: [path], enabled | disabled, isRequired, readonly}
#    when active, targets get these states; otherwise, the opposite ones.
# effects of rules from all conditors on a widget are merged: a state is on if any rule turns it on.
form.conditor = (opt = {}) ->
  @_ =
    id: "c#{Math.random!toString(36)substring(2)}"
    manager: opt.manager
    rules: []
    hash: {}
    result: {}
    # ids of rules by first path segment they read ( `dep` ) or write ( `tgt` ); `*` for unknown
    dep: {}
    tgt: {}
    touched: new Set!
    pending: null
  @_.manager.on \change, ({path} = {}) ~> @_schedule path
  @

form.conditor.prototype = Object.create(Object.prototype) <<<
  init: (rules = []) ->
    @clear!
    @_.rules = rules.map (r, i) -> {} <<< r <<< id: (r.id or "_r#{i + 1}")
    @_ <<< hash: {}, result: {}, dep: {}, tgt: {}
    for r in @_.rules =>
      @_.hash[r.id] = r
      for k in form.conditor.deps(r) => @_.dep[][k].push r.id
      for p in form.conditor.targets(r) =>
        k = if typeof(p.0) == \string and !form.conditor.is-selector(p.0) => p.0 else \*
        @_.tgt[][k].push r.id
    @run!

  rules: -> @_.rules
  result: (id) -> if arguments.length => @_.result[id] else {} <<< @_.result

  # remove effects of all rules
  clear: ->
    @_.touched.forEach (w) ~>
      if !(w._conditor and w._conditor.fx) => return
      for k of w._conditor.fx => if k.startsWith("#{@_.id}/") => delete w._conditor.fx[k]
      form.conditor.merge w
    @_.touched = new Set!

  # changes are batched and handled in a microtask, running only rules concerned
  _schedule: (key) ->
    @_.pending = (@_.pending or new Set!)
    @_.pending.add(if key? => key else \*)
    if @_.pending.size > 1 => return
    Promise.resolve!then ~>
      keys = Array.from(@_.pending)
      @_.pending = null
      if \* in keys => return @run!
      ids = new Set!
      for k in keys ++ [\*] => for id in (@_.dep[k] or []) ++ (@_.tgt[k] or []) => ids.add id
      @run Array.from(ids)

  # evaluate rules ( all if `ids` omitted ) along with rules depending on them, and apply their effects.
  # returns results of rules evaluated, by id.
  run: (ids) ->
    list = if ids => ids.map(~> @_.hash[it]).filter(->it) else @_.rules.slice!
    if ids =>
      queue = list.slice!
      seen = new Set(list.map -> it.id)
      while queue.length =>
        r = queue.shift!
        for o in @_.rules => if !seen.has(o.id) and (o.precond == r.id or (r.id in form.conditor.refs(o))) =>
          seen.add o.id
          list.push o
          queue.push o
    result = {}
    stack = []
    eval-rule = (r) ~>
      if result[r.id]? => return result[r.id]
      if r.id in stack =>
        console.error "[@plotdb/form] conditor: circular reference in rule `#{r.id}`"
        return false
      stack.push r.id
      ret = if r.precond and @_.hash[r.precond] and !eval-rule(@_.hash[r.precond]) => false
      else
        try form.conditor.truthy @eval(r.when, {rule: eval-rule})
        catch e
          console.error "[@plotdb/form] conditor: rule `#{r.id}` failed:", e
          false
      stack.pop!
      @_.result[r.id] = result[r.id] = ret
    for r in list => @_apply r, eval-rule(r)
    result

  # evaluate an expression. ctx: {data, rule}; `data` is the current item inside `some` / `all` / `none`.
  eval: (x, ctx = {}) ->
    if typeof(x) == \function => return x.call @, ctx
    if Array.isArray(x) => return x.map ~> @eval it, ctx
    if !(x and typeof(x) == \object) => return x
    op = Object.keys(x).0
    a = x[op]
    a = if Array.isArray(a) => a else [a]
    v = (i) ~> @eval a[i], ctx
    switch op
    | 'var' =>
      if ctx.data? => return form.conditor.dig ctx.data, (if a.length == 1 => a.0 else a)
      @value a
    | 'rule' =>
      if !(r = @_.hash[v 0]) => false
      else if ctx.rule => ctx.rule r
      else !!@_.result[r.id]
    | 'and' =>
      for i from 0 til a.length => if !form.conditor.truthy(ret = v i) => return ret
      ret
    | 'or' =>
      for i from 0 til a.length => if form.conditor.truthy(ret = v i) => return ret
      ret
    | '!' => !form.conditor.truthy(v 0)
    | '!!' => form.conditor.truthy(v 0)
    | 'if' =>
      for i from 0 til a.length - 1 by 2 => if form.conditor.truthy(v i) => return v(i + 1)
      if a.length % 2 => v(a.length - 1) else null
    | '==' => v(0) ~= v(1)
    | '!=' => v(0) !~= v(1)
    | '===' => v(0) == v(1)
    | '!==' => v(0) != v(1)
    # `<` and `<=` take an optional third operand, for between
    | '<' => v(0) < v(1) and (a.length < 3 or v(1) < v(2))
    | '<=' => v(0) <= v(1) and (a.length < 3 or v(1) <= v(2))
    | '>' => v(0) > v(1)
    | '>=' => v(0) >= v(1)
    | 'in' =>
      b = v 1
      if Array.isArray(b) or typeof(b) == \string => b.indexOf(v 0) >= 0 else false
    | 'empty' =>
      c = v 0
      !c? or c == '' or (Array.isArray(c) and !c.length)
    | 'some', 'all', 'none' =>
      # `var` here reads all matched widgets as one flattened list, so a single widget with
      # multiple values ( e.g., checkbox ) and multiple widgets ( e.g., in list mode ) work the same.
      list = if a.0 and typeof(a.0) == \object and a.0.var? =>
        if ctx.data? => form.conditor.dig(ctx.data, a.0.var) else @values(a.0.var)
      else v 0
      list = if Array.isArray(list) => list else if list? => [list] else []
      test = (item) ~> form.conditor.truthy @eval(a.1, {} <<< ctx <<< {data: item})
      if op == \some => list.some test
      else if op == \none => !list.some test
      else !!list.length and list.every test
    | _ => throw new Error "unsupported operator `#op`"

  # content of widgets matched by path: a single widget gives its content; a selector gives a flattened list.
  # disabled widgets read as empty.
  value: (path) ->
    path = if Array.isArray(path) => path else [path]
    if form.conditor.fan(path) => return @values path
    ws = @_.manager.resolve(path).filter -> !it.disabled!
    if ws.length == 1 => ws.0.content! else if ws.length => @values path else null
  values: (path) ->
    ret = []
    for w in @_.manager.resolve(if Array.isArray(path) => path else [path]) => if !w.disabled! =>
      c = w.content!
      if Array.isArray(c) => ret ++= c else if c? => ret.push c
    ret

  _apply: (rule, active) ->
    fx = rule.effect or {}
    state = {}
    if fx.enabled? => state.disabled = !!(fx.enabled xor active)
    else if fx.disabled? => state.disabled = !(fx.disabled xor active)
    for k in <[isRequired readonly]> => if fx[k]? => state[k] = !(fx[k] xor active)
    key = "#{@_.id}/#{rule.id}"
    for p in form.conditor.targets(rule) => for w in @_.manager.resolve(p) =>
      w.{}_conditor.{}fx[key] = state
      @_.touched.add w
      form.conditor.merge w

# merge effects on a widget: a state is on if any effect turns it on, and off if all effects concerned turn it off.
# without any effect concerned, it goes back to what it was before.
form.conditor.merge = (w) ->
  lc = w._conditor
  lc.base = lc.base or {}
  cur = w.serialize!
  next = JSON.parse JSON.stringify cur
  for k in <[disabled isRequired readonly]> =>
    vs = [s[k] for id, s of lc.fx when s[k]?]
    if vs.length =>
      if !(k of lc.base) => lc.base[k] = !!cur[k]
      next[k] = vs.some -> it
    else if k of lc.base =>
      next[k] = lc.base[k]
      delete lc.base[k]
  if <[disabled isRequired readonly]>.every((k) -> !!cur[k] == !!next[k]) => return
  w.deserialize next, {init: true}

form.conditor.truthy = (v) -> if Array.isArray(v) => !!v.length else !!v
form.conditor.dig = (o, p) ->
  if p == '' or !p? => return o
  for k in (if Array.isArray(p) => p else "#p".split \.) =>
    if !(o? and typeof(o) == \object) => return null
    o = o[k]
  o
# path segments are keys or selectors. selectors, interpreted by each level ( manager, or widgets with
# their own `resolve` ): `*`, `#<key>`, `[tag~=<tag>]`, `:nth-child(<n>)` or a number ( index from 0 ).
form.conditor.is-selector = (s) -> typeof(s) == \number or (typeof(s) == \string and !!/^(\*$|#|:|\[)/.exec(s))
# whether a path may match multiple widgets by itself ( a key or an index matches one at most )
form.conditor.fan = (p) -> p.some (s) -> form.conditor.is-selector(s) and typeof(s) != \number and !/^#/.exec(s)
form.conditor.targets = (r) ->
  ((r.effect or {}).targets or []).map -> if Array.isArray(it) => it else [it]
# first path segments read by a rule's `when`; `*` if unknown ( a function, or a path starting with a selector )
form.conditor.deps = (r) ->
  ret = new Set!
  walk = (x, inner) ->
    if typeof(x) == \function => return ret.add \*
    if Array.isArray(x) => return x.map -> walk it, inner
    if !(x and typeof(x) == \object) => return
    op = Object.keys(x).0
    a = x[op]
    if op == \var =>
      if inner => return
      p = if Array.isArray(a) => a else [a]
      return ret.add(if typeof(p.0) == \string and !form.conditor.is-selector(p.0) => p.0 else \*)
    a = if Array.isArray(a) => a else [a]
    if op in <[some all none]> => walk a.0, inner; walk a.slice(1), true
    else walk a, inner
  walk r.when, false
  Array.from ret
# ids of rules referenced by `{rule: id}` in a rule's `when`
form.conditor.refs = (r) ->
  ret = []
  walk = (x) ->
    if Array.isArray(x) => return x.map walk
    if !(x and typeof(x) == \object) => return
    for k,v of x => if k == \rule and typeof(v) == \string => ret.push v else walk v
  walk r.when
  ret
