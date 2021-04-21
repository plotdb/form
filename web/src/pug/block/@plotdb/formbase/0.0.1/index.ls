pkg:
  name: "@plotdb/base", version: "0.0.1"
  dependencies: [
    {url: "/assets/lib/bootstrap.native/main/bootstrap-native.min.js"}
  ]
init: ({root, context}) ->
  {BSN} = context
  <-(->new it!) _
  @root = root
  _ = @data = {}
  @view = view = new ldView do
    root: @root
    action:
      input:
        title: ({node}) ~> _.title = node.value or ''
        desc: ({node}) ~> _.desc = node.value or ''
        value: ({node}) ->
          _.value = node.value
          _.criteria.map -> form.term
      click:
        "add-criteria": ~>
          _.criteria.push {}
          @view.render \criteria
        switch: ({node}) ~>
          n = node.getAttribute(\data-name)
          if !(n in <[isPublic isRequired showDesc]>) => return
          _[n] = !_[n]
          view.render!
    init: dropdown: ({node}) -> 
      new BSN.Dropdown(node)
    handler:
      title: ({node}) ~> node.value = _.title or ''
      desc: ({node}) ~> node.value = _.desc or ''
      switch: ({node}) ~>
        n = node.getAttribute(\data-name)
        if !(n in <[isPublic isRequired showDesc]>) => return
        node.classList.toggle \on, !!_.[n]
      attr:
        list: ~> [{k,v} for k,v of _.attr] or []
        handler: ({node, data}) ->
          node.setAttribute \value, data.k
          node.innerText = data.v.name
      criteria:
        list: ~> _.criteria or []
        view: do
          action:
            click:
              enabled: ({context}) ~>
                context.enabled = !context.enabled
                @view.render \criteria
              delete: ({context}) ~>
                _.criteria.splice _.criteria.indexOf(context), 1
                @view.render \criteria
            change:
              attr: ({node, context}) ~>
                context.opset = _.attr[node.value].opset
                view.render \criteria
              op: ({node, context}) ~>
                context.op = form.opset.get(context.opset or 'number').get-op(node.value)
                view.render \criteria
          handler:
            enabled: ({node, context}) ->
              node.classList.toggle \on, !!context.enabled
            "attr-option":
              list: ~> [{k,v} for k,v of _.attr] or []
              key: -> it.k
              handler: ({node, data}) ->
                node.setAttribute \value, data.k
                node.innerText = data.v.name
            "op-option":
              list: ({context}) ~>
                opset = form.opset.get(context.opset or 'number')
                [v for k,v of opset.ops]
              handler: ({node, data}) ->
                node.setAttribute \value, data.id
                node.innerText = data.name
            "op-config":
              list: ({context}) -> [{k,v} for k,v of context.{}op.config or {}]
              key: -> it.k
              view:
                text:
                  name: ({node, context}) -> return context.k

