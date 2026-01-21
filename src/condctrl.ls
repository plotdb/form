form.condctrl = (opt = {}) ->
  @{}_ <<<
    hash: {}, enabled: {}, manager: opt.manager
    list: opt.conditions or []
    apply-base-rule: opt.base-rule or (->)
  @

form.condctrl.prototype = Object.create(Object.prototype) <<<
  is-enabled: -> @_.enabled[it]
  get: -> @_.hash[it]
  # TODO we should abstract this to prevent internal fiedls access across submodule
  fields: -> @_.manager._ws.w
  subcond: ({path, active, config}) ->
    if !((itf = @_.manager.widget path) and !itf.disabled! and (ms = itf.manager {depth: 1} or []).length) => return
    (m) <- ms.map _
    cond = m.condition!
    cond.apply({active} <<< config)
    cond.run!
  #list: -> if arguments.length => @_.list = it else @_.list
  reset: (opt = {}) ->
    # TODO NOTE we may need a reinit if field may change
    @_.list = opt.conditions or @_.list or []
    fields = @fields!
    for i from 0 til @_.list.length =>
      cond = @_.list[i]
      cond.id = cond.id or "#{i + 1}"
      @_.hash[cond.id] = cond
      if !Array.isArray(cond.config) => cond.config = [cond.config]
      cond.config.map (cfg) ~>
        # NOTE source rename to src, disabled removed
        # NOTE targets renamt to path, tags renamed to tag
        cfg <<< cond{src, func}
        cfg.path = Array.from(new Set(
          (if cfg.prefix => cfg.prefix else []) ++
          (cfg.path or []) ++
          [{k,v} for k,v of fields].filter(({k,v}) ->
            return (
              (if !cfg.prefix => 0 else (cfg.prefix.filter((p) -> k.startsWith p).length)) +
              (v?meta?tag or []).filter((t) -> t in (cfg.tag or [])).length
            ) > 0
          ).map(->it.k)
        ))

  apply: (opt = {}) ->
    {path, active, enabled, is-required, readonly} = opt
    if Array.isArray(path) and path.1 =>
      return @subcond do
        path: path.0, active: active
        config: {path: path.slice(1), enabled, is-required, readonly}
    if enabled? => @_.enabled[path] = !(enabled xor active)
    if widget = @_.manager.widget(path) =>
      cur-meta = widget.serialize!
      new-meta = JSON.parse(JSON.stringify(cur-meta))
      if enabled? => new-meta.disabled = !!(enabled xor active)
      if readonly? => new-meta.readonly = !(readonly xor active)
      if is-required? => new-meta.is-required = !(is-required xor active)
      @_.apply-base-rule {path, widget, meta: new-meta, opt}
      if !!cur-meta.disabled == !!new-meta.disabled and
         !!cur-meta.is-required == !!new-meta.is-required and
         !!cur-meta.readonly == !!new-meta.readonly => return
      widget.deserialize new-meta, {init: true}

  _run: (cfg = {}, precond) ->
    {src, values, path, is-required, enabled, readonly, func} = cfg
    if func =>
      result = true
      for p in path =>
        active = !!(func.apply @, [{} <<< cfg <<< {path: p}]) and !(precond? and !precond)
        result = result and active
        if Array.isArray(p) and p.1 =>
          @subcond {path: p.0, config: {} <<< cfg <<< {path: p.slice 1}, active}
          continue
        @apply {path: p.0, enabled, active, is-required, readonly}
    else
      if !(itf = @_.manager.widget src) =>
        console.error "[@plotdb/form] condctrl: run with nonexisted fields '#src'"
        return
      content = itf.content!
      content = if Array.isArray(content) => content else [content]
      active = !!content.filter((c) -> if Array.isArray(values) => (c in values) else (c == values)).length
      if precond? and !precond => active = false
      for p in path =>
        if Array.isArray(p) and p.1 =>
          @subcond {path: p.0, config: {} <<< cfg <<< {path: p.slice(1)}, active}
          continue
        @apply {path: p, enabled, active, is-required, readonly}
      result = active
    return result

  run: ->
    result = {}
    _ = (list) ~>
      for i from 0 til list.length =>
        cond = list[i]
        if result[cond.id]? => continue
        if cond.precond and @_.hash[cond.precond] => _ [@_.hash[cond.precond]]
        for cfg in cond.config => result[cond.id] = @_run cfg, result[cond.precond]
    _ (@_.list or [])


