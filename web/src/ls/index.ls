/*
blockbase object
 - `title`
 - `desc`
 - `isPublic`
 - `isRequired`
 - `showDesc`
blockbase.prototype
 - serialize
 - deserialize
*/

<- (-> new it!) _
@ <<< {title: 'untitled', desc: 'no description...', is-public: true, is-required: true, show-desc: true}
@ <<< {criteria: [{}]}
@ <<< attr:
  length: {name: "length", opset: \count}
  string: {name: "string", opset: \string}
  number: {name: "number", opset: \number}
@show = -> console.log @
@view = view = new ldView do
  root: document.body
  action:
    input:
      title: ({node}) ~> @title = node.value or ''; @show!
      desc: ({node}) ~> @desc = node.value or ''; @show!
      value: ({node}) ->
        @value = node.value
        @criteria.map -> form.term
    click:
      "add-criteria": ~>
        @criteria.push {}
        @view.render \criteria
      switch: ({node}) ~>
        n = node.getAttribute(\data-name)
        if !(n in <[isPublic isRequired showDesc]>) => return
        @[n] = !@[n]
        view.render!
  handler:
    title: ({node}) ~> node.value = @title
    desc: ({node}) ~> node.value = @desc
    switch: ({node}) ~>
      n = node.getAttribute(\data-name)
      if !(n in <[isPublic isRequired showDesc]>) => return
      node.classList.toggle \on, !!@[n]
    attr:
      list: ~> [{k,v} for k,v of @attr] or []
      handler: ({node, data}) ->
        node.setAttribute \value, data.k
        node.innerText = data.v.name
    criteria:
      list: ~> @criteria or []
      view: do
        action:
          click:
            enabled: ({context}) ~>
              context.enabled = !context.enabled
              @view.render \criteria
            delete: ({context}) ~>
              @criteria.splice @criteria.indexOf(context), 1
              @view.render \criteria
          change:
            attr: ({node, context}) ~>
              context.opset = @attr[node.value].opset
              view.render \criteria
            op: ({node, context}) ~>
              context.op = form.opset.get(context.opset or 'number').get-op(node.value)
              view.render \criteria

        handler:
          enabled: ({node, context}) ->
            node.classList.toggle \on, !!context.enabled
          "attr-option":
            list: ~> [{k,v} for k,v of @attr] or []
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


@
