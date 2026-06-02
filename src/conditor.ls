form.conditor = (opt = {}) ->
  @_ =
    manager: opt.manager
    conditions: []
    results: {}
    virtual: {}
  @_.manager.on \change, debounce 50, ~> @run!
  @

form.conditor.prototype = Object.create(Object.prototype) <<<
  init: (conditions = []) ->
    @_.conditions = conditions.map (c, i) ~>
      {} <<< c <<< id: (c.id or "_c#{i}")
    @_.results = {}
    @

  # evaluate a cond object -> Promise<boolean>
  eval: (cond) ->
    if !cond? => return Promise.resolve false

    # function shorthand
    if typeof cond == \function
      return Promise.resolve!then ~> !!cond.call @

    # array -> AND of all members
    if Array.isArray cond
      return Promise.all(cond.map ~> @eval it).then -> it.every -> it

    # {logic, cond}: logical combination
    if cond.logic
      sub = if Array.isArray(cond.cond) => cond.cond else [cond.cond]
      return Promise.all(sub.map ~> @eval it).then (rs) ->
        switch cond.logic
        | \and => rs.every -> it
        | \or  => rs.some -> it
        | \xor => rs.filter(->it).length == 1
        | \not => !rs.0
        | _    => false

    # src is a cond id referencing another condition's result
    if cond.src? and typeof cond.src == \string and (cached = @_.results[cond.src])?
      return Promise.resolve cached

    # func-based evaluation
    if cond.func?
      return Promise.resolve!then ~> !!cond.func.call @

    # src-based: resolve widget(s) and evaluate via values / term / empty check
    if cond.src?
      src = if Array.isArray cond.src => cond.src else [cond.src]
      widgets = @_.manager.resolve src
      if !widgets.length => return Promise.resolve false
      # disabled source widget means the condition cannot be active
      if widgets.some((w) -> w.disabled!) => return Promise.resolve false
      # values: check if widget content matches any listed value
      if cond.values?
        vals = if Array.isArray cond.values => cond.values else [cond.values]
        return Promise.resolve widgets.every (w) ->
          content = w.content!
          content = if Array.isArray content => content else [content]
          content.some -> it in vals
      # term: validate against terms (AND logic)
      if cond.term and cond.term.length
        terms = cond.term.map (t) -> if t instanceof form.term => t else new form.term t
        return Promise.all(
          widgets.map (w) ->
            v = w.content!
            Promise.all(terms.map (t) -> t.validate v)
              .then -> it.every -> it != false
        ).then -> it.every -> it
      # fallback: non-empty check
      return Promise.resolve widgets.every (w) -> !w.is-empty!

    Promise.resolve false

  # apply an effect object given whether the condition is active
  apply: (effect, active) ->
    targets = effect.targets or (if effect.target => [effect.target] else [])
    for target in targets =>
      path = if Array.isArray target => target else [target]
      # virtual id: a string starting with $
      if typeof path.0 == \string and path.0.startsWith \$
        @_.virtual[path.0] = active
        continue
      for w in @_.manager.resolve path =>
        cur = w.serialize!
        next = JSON.parse JSON.stringify cur
        # same sign convention as condctrl:
        #   disabled    = enabled    XOR active
        #   is-required = !(is-required XOR active)
        #   readonly    = !(readonly    XOR active)
        if effect.enabled?     => next.disabled    = !!(effect.enabled     xor active)
        if effect.is-required? => next.is-required = !(effect.is-required  xor active)
        if effect.readonly?    => next.readonly     = !(effect.readonly     xor active)
        changed = (
          !!cur.disabled    != !!next.disabled    or
          !!cur.is-required != !!next.is-required or
          !!cur.readonly    != !!next.readonly
        )
        if changed => w.deserialize next, {init: true}
        if effect.value? and active => w.value effect.value

  run: ->
    results = @_.results = {}
    eval-with-deps = (cond) ~>
      if results[cond.id]? => return Promise.resolve results[cond.id]
      pre = Promise.resolve!
      if cond.precond
        parent = @_.conditions.find (.id == cond.precond)
        if parent => pre = eval-with-deps parent
      pre.then ~>
        # precond not met: short-circuit to false
        if cond.precond? and !results[cond.precond] => return results[cond.id] = false
        @eval cond.when .then (active) ~>
          results[cond.id] = active
          if cond.effect => @apply cond.effect, active
          active
    Promise.all @_.conditions.map (c) ~> eval-with-deps c
