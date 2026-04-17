# WIP Notice: this is the implementation ported from @makeform/nest.
# it's a workable preview, however we may want to refactor this in the near future.
# don't use this unless for experimental purpose.

form.condctrl = (opt = {}) ->
  @{}_ <<<
    hash: {}, enabled: {}, manager: opt.manager
    list: opt.conditions or []
    apply-base-rule: opt.base-rule or (->)
  @

form.condctrl.prototype = Object.create(Object.prototype) <<<
  is-enabled: -> @_.enabled[it]
  get: -> @_.hash[it]

  reset: (opt = {}) ->
    @_.list = opt.conditions or @_.list or []
    fields = @_.manager.widgets!
    @{}_ <<< hash: {}, enabled: {}
    for i from 0 til @_.list.length =>
      cond = @_.list[i]
      cond.id = cond.id or "_#{i + 1}"
      @_.hash[cond.id] = cond
      if !Array.isArray(cond.config) => cond.config = [cond.config]
      cond.config.for-each (cfg) ~>
        # COMPATIBILITY NOTE
        #  rename: source > src, targets > path, tags > tag, values: value
        #  removed: disabled
        cfg = {} <<< cfg <<< cond{src, func}
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

  subcond: ({path, active, config}) ->
    if !((itf = @_.manager.widget path) and !itf.disabled! and (ms = itf.manager {depth: 1} or []).length) => return
    (m) <- ms.for-each _
    cond = m.condition!
    cond.apply({active} <<< config)
    cond.run!

  apply: (opt = {}) ->
    {path, active, enabled, is-required, readonly} = opt
    if Array.isArray path =>
      if path.1 => return @subcond do
        path: path.0, active: active
        config: {path: path.slice(1), enabled, is-required, readonly}
      path = path.0
    if enabled? => @_.enabled[path] = !(enabled xor active)
    if widget = @_.manager.widget(path) =>
      cur-meta = widget.serialize!
      new-meta = JSON.parse JSON.stringify cur-meta
      if enabled? => new-meta.disabled = !!(enabled xor active)
      if readonly? => new-meta.readonly = !(readonly xor active)
      if is-required? => new-meta.is-required = !(is-required xor active)
      @_.apply-base-rule {path, widget, meta: new-meta, opt}
      if !!cur-meta.disabled == !!new-meta.disabled and
         !!cur-meta.is-required == !!new-meta.is-required and
         !!cur-meta.readonly == !!new-meta.readonly => return
      widget.deserialize new-meta, {init: true}

  _run: (cfg = {}, precond) ->
    # we use `path` as simplified interface name, yet it actually contains a list of path
    # and we need to iterate it, so we use `path: paths` here
    # so does value: values
    {src, value: values, path: paths, is-required, enabled, readonly, func} = cfg
    if func =>
      result = true
      for path in paths =>
        active = !!(func.apply @, [{} <<< cfg <<< {path}]) and !(precond? and !precond)
        result = result and active
        if Array.isArray(path) and path.1 =>
          @subcond {path: path.0, config: {} <<< cfg <<< {path: path.slice 1}, active}
          continue
        @apply {path, enabled, active, is-required, readonly}
    else
      values = if Array.isArray(values) => values else [values]
      if !(itf = @_.manager.widget src) => return console.error "[@plotdb/form] condctrl: field '#src' not found"
      content = itf.content!
      content = if Array.isArray(content) => content else [content]
      active = !!content.filter(->it in values).length
      if precond? and !precond => active = false
      for path in paths =>
        if Array.isArray(path) and path.1 =>
          @subcond {path: path.0, config: {} <<< cfg <<< {path: path.slice 1}, active}
          continue
        @apply {path, enabled, active, is-required, readonly}
      result = active
    return result

  run: ->
    result = {}
    _ = (list, ref = []) ~>
      for i from 0 til list.length =>
        cond = list[i]
        if result[cond.id]? => continue
        if cond.precond and @_.hash[cond.precond] =>
          if cond.id in ref => console.error "[@plotdb/form] condctrl: circular ref id #{cond.id}"
          else _ [@_.hash[cond.precond]], ref ++ [cond.id]
        for cfg in cond.config =>
          # by default AND op for grouped cfg in one cond.
          r = @_run cfg, result[cond.precond]
          result[cond.id] = if result[cond.id]? => result[cond.id] and r else r
    _ (@_.list or [])

