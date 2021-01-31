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
        action: click:
          enabled: ({context}) ~>
            context.enabled = !context.enabled
            @view.render \criteria
          delete: ({context}) ~>
            @criteria.splice @criteria.indexOf(context), 1
            @view.render \criteria
        handler:
          enabled: ({node, context}) ->
            node.classList.toggle \on, !!context.enabled
          attr:
            list: ~> [{k,v} for k,v of @attr] or []
            handler: ({node, data}) ->
              node.setAttribute \value, data.k
              node.innerText = data.v.name
        

@
