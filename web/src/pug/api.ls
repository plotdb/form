form.controller = (opt = {}) ->
  @_ =
    list: []
    node: null
    opt: opt
    formmgr: opt.formmgr
    root: opt.root
    widget: bid: opt.widget, meta: opt.meta
    mgr: opt.manager
  @

form.controller.prototype = Object.create(Object.prototype) <<<
  find-scrollable-parent: (n) ->
    while n = n.parentNode =>
      break unless (n instanceof HTMLElement)
      scrollable = (getComputedStyle n).overflowY in <[auto scroll overlay]>
      overflow = n.scrollHeight > n.clientHeight
      if scrollable and overflow => return n
    document.scrollingElement

  init: ->
    if !(bid = @_.widget.bid) => return Promise.resolve!
    bid = if typeof(bid) == \string => {name: bid} else bid
    (ret) <~ mgr.from bid, {root: @_.root, data: {}} .then _
    @_.widget <<< itf: itf = ret.interface, instance: ret.instance
    <~ Promise.resolve(itf.deserialize @_.widget.meta, {init: true}).then _
    if @_.formmgr => @_.formmgr.add path: \_, widget: @_.widget.itf
    else @_.formmgr = (itf.manager! or []).0

  formmgr: -> @_.formmgr

  check: debounce ({init = false, force = false} = {}) ->
    Promise.resolve!
      .then ~>
        if force => @_.formmgr.check null, {now: true, force: true}
        else if init => @_.formmgr.check null, {now: true, skip-empty: true}
      .then (list) ~>
        if Array.isArray(list) => @_.list = list
        list = []
        ps = @_.list.map (o) ->
          mgrs = if o.widget.manager => o.widget.manager! else []
          if !mgrs.length => return Promise.resolve(list.push o)
          else if o.status == 2 =>
            # we have nested mgrs in `o.widget`, but we'll still want to add `o` if o has error too.
            # if not noly `nested` in errors from o.widget, we will add `o` too.
            e = o.widget.errors! or []
            if !(e.length == 1 and e.0 == \nested) => list.push o
          Promise.all(
            # expand items in the nested formmgr but don't add the parent back
            # to prevent infinite expansion
            mgrs.map (mgr) ->
              #if !docheck => return Promise.resolve!
              # parent reports error so we should check child widgets,
              # however we don't want to trigger required errors for empty fields.
              # thus we set `skip-empty` to true.
              (a=[]) <- mgr.check(null, {now: true, force: force, skip-empty: true}).then _
              # TODO does these get expanded later in the map loop?
              for p in a =>
                e = p.widget.errors! or []
                # mgrs contain flatten formmgr from recursive blocks, including nested block
                # which may also return nested error, so we have to skip them too.
                if (e.length == 1 and e.0 == \nested) => continue
                list.push({mgr} <<< p)
          )
        Promise.all(ps).then ~>
          hash = {}
          # we may have duplicated entries from mgr due to multiple expansion
          # so we dedup them here.
          @_.list = list
            .filter (o) ->
              # there may be path with same names from different formmgr.
              # use o.mgr as their source identity (use `undefined` for base formmgr)
              if hash[o.path] and o.mgr in hash[o.path] => return false
              if !hash[o.path] => hash[o.path] = []
              hash[o.path].push o.mgr
              return true
    .then ~>
      if !force => return
      list = @_.list.map -> it.widget.root!
      el = if !@_.node => list.0
      else list[(list.indexOf(@_.node) + 1) % list.length]
      @_.node = el
      if !el => return
      box = el.getBoundingClientRect!
      parent = @find-scrollable-parent el
      # it seems awkard if we don't scroll so for now we always do it, thus this isn't used
      outside-viewport = !(box.top < 0 or box.top + box.height > window.innerHeight)
      top = box.top + parent.scrollTop - 60
      parent.scrollTo {top, behavior: \smooth}
