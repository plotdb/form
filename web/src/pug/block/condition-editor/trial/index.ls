module.exports =
  pkg:
    dependencies: [
      {name: \ldview}
      {name: \ldcover}
      {name: \ldcover, type: \css, global: true}
      {name: \@plotdb/form}
      {name: \@plotdb/konfig}
      {name: \@plotdb/konfig, path: "konfig.widget.bootstrap.min.js"}
    ]
  interface: -> @mod.ldcv
  init: ({root, ctx, manager}) ->
    {ldcover, form, konfig} = ctx
    mod = @{}mod
    mod.manager = null   # form.manager passed in via ldcv.get()
    mod.conditions = []  # working copy

    # ── helpers ────────────────────────────────────────────────────────────────

    # Return [{id,name}] options for path prefix (using form.manager.paths)
    get-options = (path = []) ->
      if !mod.manager => return []
      mod.manager.paths path

    # Resolve display label for a path array
    path-label = (path) ->
      if !path or !path.length => return "(未選擇)"
      opts = get-options path.slice 0, -1
      seg = opts.find (.id == path[path.length - 1])
      if path.length == 1 => return seg?.name or path.0
      parent = path-label path.slice 0, -1
      "#{parent} / #{seg?.name or path[path.length - 1]}"

    # Deep-clone a cond tree node
    clone = (o) -> JSON.parse JSON.stringify o

    # Create a blank leaf cond
    blank-leaf = -> {src: [], term: []}

    # Create a blank group cond
    blank-group = -> {logic: \and, cond: [blank-leaf!]}

    # Create a blank condition entry
    blank-condition = ->
      id: ""
      when: blank-leaf!
      effect: {targets: [], enabled: null, is-required: null, readonly: null, value: ""}

    # ── src / target breadcrumb picker ─────────────────────────────────────────
    # path: string[] (mutable ref inside ctx)
    # on-change: called after each segment selection
    make-breadcrumb = (container, path, on-change) ->
      render = ->
        container.innerHTML = ""
        segs = path.length + 1   # always show one more empty seg unless already a leaf
        for i from 0 to path.length =>
          opts = get-options path.slice 0, i
          if !opts.length => break
          sel = document.createElement \select
          sel.className = "form-control form-control-sm ce-seg-select"
          opt0 = document.createElement \option
          opt0.value = ""
          opt0.textContent = "(選擇...)"
          sel.appendChild opt0
          for o in opts =>
            el = document.createElement \option
            el.value = o.id
            el.textContent = o.name or o.id
            sel.appendChild el
          sel.value = path[i] or ""
          do (idx = i) ->
            sel.addEventListener \change, ->
              path.splice idx   # truncate from here
              if @value => path.push @value
              on-change!
              render!
          container.appendChild sel
          if !path[i] => break   # stop if this seg is not yet selected
      render!

    # ── konfig-based config editor ─────────────────────────────────────────────
    # build/rebuild a konfig instance inside cfg-root for the given term
    setup-cfg-root = (cfg-root, term, saved-config) ->
      cfg-root.innerHTML = ""
      cfg-root._kfg = null
      # konfig simple view 需要 ld-each="ctrl" + ld-scope 的子元素作為 widget 掛載點
      ctrl-el = document.createElement \div
      ctrl-el.setAttribute \ld-each, \ctrl
      ctrl-el.setAttribute \ld-scope, ''
      ctrl-el.classList.add \flex-grow-1
      cfg-root.appendChild ctrl-el
      opset = form.opset.get term.opset
      op = if opset => opset.get-op term.op else null
      cfg-schema = if op => op.get-config(null) else {}
      meta = {}
      for k, v of cfg-schema => meta[k] = {} <<< v <<< {name: v.name or k}
      typemap = (name) ->
        name: \@makeform/common, version: \main, path: "term/konfig/#name/index.html"
      kfg = new konfig {root: cfg-root, view: \simple, manager, typemap}
      cfg-root._kfg = kfg
      cfg-root._term = term
      kfg.on \change, (v) -> cfg-root._term.config = v
      kfg.init!.then -> kfg.meta {meta, config: (saved-config or {})}

    # ── term row builder ───────────────────────────────────────────────────────
    make-term-row = (term, on-delete) ->
      row = document.createElement \div
      row.className = "d-flex flex-wrap align-items-start g-2 mb-1"

      # opset select
      opset-sel = document.createElement \select
      opset-sel.className = "form-control form-control-sm"
      for o in form.opset.list! =>
        el = document.createElement \option
        el.value = o.id or o.name
        el.textContent = o.id or o.name
        opset-sel.appendChild el
      opset-sel.value = term.opset or ""

      # op select
      op-sel = document.createElement \select
      op-sel.className = "form-control form-control-sm"
      fill-ops = (opset-id) ->
        op-sel.innerHTML = ""
        opset = form.opset.get opset-id
        if !opset => return
        for k, v of (opset.ops or {}) =>
          el = document.createElement \option
          el.value = v.id or k
          el.textContent = v.name or v.id or k
          op-sel.appendChild el
        op-sel.value = term.op or ""
      fill-ops term.opset

      # konfig config editor
      cfg-root = document.createElement \div
      cfg-root.className = "flex-grow-1"
      setup-cfg-root cfg-root, term, (term.config or {})

      # delete btn
      del-btn = document.createElement \button
      del-btn.type = \button
      del-btn.className = "btn btn-sm btn-light text-danger"
      del-btn.innerHTML = "×"
      del-btn.addEventListener \click, on-delete

      opset-sel.addEventListener \change, ->
        term.opset = @value
        fill-ops @value
        term.op = op-sel.value
        term.config = {}
        setup-cfg-root cfg-root, term, {}
      op-sel.addEventListener \change, ->
        term.op = @value
        term.config = {}
        setup-cfg-root cfg-root, term, {}

      row.append opset-sel, op-sel, cfg-root, del-btn
      row

    # ── recursive cond node renderer ──────────────────────────────────────────
    # renders into `container` for a given cond object (leaf or group)
    # parent-list / idx allow deletion from parent
    render-cond-node = (container, cond, {on-change, on-delete} = {}) ->
      container.innerHTML = ""
      is-group = !!cond.logic

      # type toggle row
      type-row = document.createElement \div
      type-row.className = "d-flex align-items-center g-2 mb-2"

      type-sel = document.createElement \select
      type-sel.className = "form-control form-control-sm ce-type-sel"
      for [val, label] in [[\leaf, "單一條件"], [\group, "邏輯組合"]] =>
        el = document.createElement \option
        el.value = val
        el.textContent = label
        type-sel.appendChild el
      type-sel.value = if is-group => \group else \leaf

      type-row.appendChild type-sel
      if on-delete
        del-btn = document.createElement \button
        del-btn.type = \button
        del-btn.className = "btn btn-sm btn-light text-danger ms-auto"
        del-btn.textContent = "刪除"
        del-btn.addEventListener \click, on-delete
        type-row.appendChild del-btn
      container.appendChild type-row

      # body area
      body = document.createElement \div
      body.className = "ce-cond-body ps-2"
      container.appendChild body

      if is-group
        render-group body, cond, on-change
      else
        render-leaf body, cond, on-change

      type-sel.addEventListener \change, ->
        if @value == \group
          # convert leaf → group
          delete cond.src; delete cond.term; delete cond.values
          cond <<< {logic: \and, cond: [blank-leaf!]}
        else
          # convert group → leaf
          delete cond.logic; delete cond.cond
          cond <<< blank-leaf!
        on-change?!
        render-cond-node container, cond, {on-change, on-delete}

    render-leaf = (container, cond, on-change) ->
      # src breadcrumb
      src-label = document.createElement \div
      src-label.className = "text-sm text-muted mb-1"
      src-label.textContent = "觸發來源 (src)"
      container.appendChild src-label

      src-wrap = document.createElement \div
      src-wrap.className = "d-flex flex-wrap g-1 mb-2"
      container.appendChild src-wrap

      path = if Array.isArray cond.src => cond.src else (if cond.src => [cond.src] else [])
      cond.src = path
      make-breadcrumb src-wrap, path, ->
        cond.src = path.slice!
        on-change?!

      # term list
      term-label = document.createElement \div
      term-label.className = "text-sm text-muted mb-1 mt-2"
      term-label.textContent = "條件 (term)"
      container.appendChild term-label

      term-wrap = document.createElement \div
      container.appendChild term-wrap

      cond.term = cond.term or []
      render-terms term-wrap, cond, on-change

      add-term-btn = document.createElement \button
      add-term-btn.type = \button
      add-term-btn.className = "btn btn-sm btn-outline-secondary mt-1"
      add-term-btn.textContent = "+ 新增條件"
      add-term-btn.addEventListener \click, ->
        opset = form.opset.list!0 or {}
        op = opset.get-ops?!0 or {}
        cond.term.push {opset: (opset.id or opset.name), op: (op.id or ""), config: {}}
        render-terms term-wrap, cond, on-change
      container.appendChild add-term-btn

    render-terms = (container, cond, on-change) ->
      container.innerHTML = ""
      for t, i in (cond.term or []) => do (term = t, idx = i) ->
        row = make-term-row term, ->
          cond.term.splice idx, 1
          render-terms container, cond, on-change
        container.appendChild row

    render-group = (container, cond, on-change) ->
      # logic select
      logic-row = document.createElement \div
      logic-row.className = "d-flex align-items-center g-2 mb-2"
      logic-lbl = document.createElement \span
      logic-lbl.className = "text-sm text-muted"
      logic-lbl.textContent = "邏輯："
      logic-sel = document.createElement \select
      logic-sel.className = "form-control form-control-sm"
      for [val, label] in [[\and,"AND（全符合）"],[\or,"OR（任一符合）"],[\not,"NOT（不符合）"],[\xor,"XOR（恰一符合）"]] =>
        el = document.createElement \option
        el.value = val; el.textContent = label
        logic-sel.appendChild el
      logic-sel.value = cond.logic or \and
      logic-sel.addEventListener \change, -> cond.logic = @value; on-change?!
      logic-row.append logic-lbl, logic-sel
      container.appendChild logic-row

      # sub-conds
      sub-wrap = document.createElement \div
      sub-wrap.className = "d-flex flex-column g-2"
      container.appendChild sub-wrap

      cond.cond = cond.cond or []
      render-sub-conds sub-wrap, cond, on-change

      add-sub-btn = document.createElement \button
      add-sub-btn.type = \button
      add-sub-btn.className = "btn btn-sm btn-outline-secondary mt-1"
      add-sub-btn.textContent = "+ 新增子條件"
      add-sub-btn.addEventListener \click, ->
        cond.cond.push blank-leaf!
        render-sub-conds sub-wrap, cond, on-change
      container.appendChild add-sub-btn

    render-sub-conds = (container, cond, on-change) ->
      container.innerHTML = ""
      for c, i in (cond.cond or []) => do (child = c, idx = i) ->
        wrap = document.createElement \div
        wrap.className = "border rounded p-2 ce-sub-cond"
        render-cond-node wrap, child,
          on-change: on-change
          on-delete: ->
            cond.cond.splice idx, 1
            render-sub-conds container, cond, on-change
        container.appendChild wrap

    # ── effect editor ──────────────────────────────────────────────────────────
    render-effect = (container, effect, on-change) ->
      container.innerHTML = ""

      # targets multi-select
      t-lbl = document.createElement \div
      t-lbl.className = "text-sm text-muted mb-1"
      t-lbl.textContent = "套用對象 (targets)"
      container.appendChild t-lbl

      t-badges = document.createElement \div
      t-badges.className = "d-flex flex-wrap g-1 mb-2"
      container.appendChild t-badges

      # badges area — re-rendered when targets change
      render-badges = ->
        t-badges.innerHTML = ""
        for p, i in (effect.targets or []) => do (path = p, idx = i) ->
          badge = document.createElement \span
          badge.className = "badge bg-secondary d-flex align-items-center g-1"
          badge.textContent = path-label (if Array.isArray path => path else [path])
          del = document.createElement \button
          del.type = \button
          del.className = "btn-close btn-close-white ms-1"
          del.style.cssText = "font-size:.6em"
          del.addEventListener \click, ->
            effect.targets.splice idx, 1
            render-badges!
          badge.appendChild del
          t-badges.appendChild badge

      render-badges!

      # add-wrap — persistent breadcrumb + confirm; never re-created
      add-wrap = document.createElement \div
      add-wrap.className = "d-flex flex-wrap g-1 align-items-center mt-1"
      t-badges.parentNode.insertBefore add-wrap, t-badges.nextSibling

      new-path = []
      bc-wrap = document.createElement \div
      bc-wrap.className = "d-flex flex-wrap g-1"
      confirm-btn = document.createElement \button
      confirm-btn.type = \button
      confirm-btn.className = "btn btn-sm btn-outline-primary"
      confirm-btn.textContent = "+"
      confirm-btn.style.display = \none

      reset-breadcrumb = ->
        new-path.splice 0
        make-breadcrumb bc-wrap, new-path, ->
          confirm-btn.style.display = if new-path.length => '' else \none
        confirm-btn.style.display = \none

      confirm-btn.addEventListener \click, ->
        if !new-path.length => return
        effect[]targets.push new-path.slice!
        render-badges!
        reset-breadcrumb!

      add-wrap.append bc-wrap, confirm-btn
      reset-breadcrumb!

      # toggle row: enabled / is-required / readonly
      tog-row = document.createElement \div
      tog-row.className = "d-flex flex-wrap g-3 mb-2"
      container.appendChild tog-row

      for [key, label] in [[\enabled,"啟用"],["is-required","必填"],[\readonly,"唯讀"]] => do (k = key, l = label) ->
        wrap = document.createElement \label
        wrap.className = "d-flex align-items-center g-1 text-sm"
        cb = document.createElement \input
        cb.type = \checkbox
        cb.indeterminate = !(k of effect) or effect[k] == null
        cb.checked = !!effect[k]
        cb.addEventListener \change, ->
          effect[k] = @checked
          on-change?!
        wrap.append cb, document.createTextNode(l)
        tog-row.appendChild wrap

      # value input
      val-lbl = document.createElement \div
      val-lbl.className = "text-sm text-muted mb-1"
      val-lbl.textContent = "強制值 (value，選填)"
      container.appendChild val-lbl
      val-input = document.createElement \input
      val-input.type = \text
      val-input.className = "form-control form-control-sm"
      val-input.placeholder = "條件成立時強制設定的值"
      val-input.value = effect.value or ""
      val-input.addEventListener \input, ->
        effect.value = @value or undefined
        on-change?!
      container.appendChild val-input

    # ── main condition list view ───────────────────────────────────────────────
    render-all = ->
      list-el = root.querySelector \.ce-condition-list
      if !list-el => return
      list-el.innerHTML = ""
      for c, i in mod.conditions => do (cond = c, idx = i) ->
        card = document.createElement \div
        card.className = "border rounded p-3 mb-3 ce-condition-card"

        # header: id + delete
        hdr = document.createElement \div
        hdr.className = "d-flex align-items-center g-2 mb-2 border-bottom pb-2"
        id-input = document.createElement \input
        id-input.type = \text
        id-input.className = "form-control form-control-sm"
        id-input.placeholder = "條件 ID（選填，供其他條件參照）"
        id-input.value = cond.id or ""
        id-input.addEventListener \input, -> cond.id = @value
        del-btn = document.createElement \button
        del-btn.type = \button
        del-btn.className = "btn btn-sm btn-light text-danger ms-auto"
        del-btn.textContent = "刪除"
        del-btn.addEventListener \click, ->
          mod.conditions.splice idx, 1
          render-all!
        hdr.append id-input, del-btn
        card.appendChild hdr

        # when section
        when-lbl = document.createElement \div
        when-lbl.className = "text-sm fw-bold mb-1"
        when-lbl.textContent = "當 (when)"
        card.appendChild when-lbl
        when-wrap = document.createElement \div
        when-wrap.className = "border rounded p-2 mb-3 ce-when-wrap"
        cond.when = cond.when or blank-leaf!
        render-cond-node when-wrap, cond.when, {on-change: render-all}
        card.appendChild when-wrap

        # effect section
        eff-lbl = document.createElement \div
        eff-lbl.className = "text-sm fw-bold mb-1"
        eff-lbl.textContent = "則 (effect)"
        card.appendChild eff-lbl
        eff-wrap = document.createElement \div
        eff-wrap.className = "border rounded p-2 ce-effect-wrap"
        cond.effect = cond.effect or {targets: []}
        render-effect eff-wrap, cond.effect, render-all
        card.appendChild eff-wrap

        list-el.appendChild card

    # ── ldcover wiring ─────────────────────────────────────────────────────────
    mod.ldcv = new ldcover root: root
    mod.ldcv.on \data, ({manager, conditions} = {}) ->
      mod.manager = manager or null
      mod.conditions = JSON.parse JSON.stringify (conditions or [])
      render-all!

    root.querySelector("[ld=add-condition]")?.addEventListener \click, ->
      mod.conditions.push blank-condition!
      render-all!

    root.querySelector("[ld=ok]")?.addEventListener \click, ->
      mod.ldcv.set mod.conditions

    root.querySelector("[ld=cancel]")?.addEventListener \click, ->
      mod.ldcv.set null
