_ = ->
  @data = {} 

  @fh = fh = new form-host root: ld$.find('#root',0), dom-mode: 2
  
  # 要怎麼指定可能會用到的 block 類型?
  fh.register "form-file", form-file

  #fh.new-block {name: 'form-file', id: criteria: }
  #name, key
  #criteria

  form-def = {
    block: [
      {
        name: "form-file", id: 'file'
        criteria: [{type: \number, rule: \gte, cfg: {a: 1}}]
      }
    ]
  }

  fh.prepare form-def
  console.log \done.
  view = {}

  view.criteria = do
    action:
      click:
        delete: ({node, context}) ->
          idx = context.context.data.criteria.indexOf(context.data)
          if ~idx => context.context.data.criteria.splice idx, 1
          context.context.local.view.render!

      input:
        input: ({node, context}) ->
          n = node.getAttribute(\name)
          context.data[n] = node.value


  view.block = do
    action:
      click: 
        "add-criteria": ({context}) ->
          context.data.criteria.push {}
          context.local.view.render!
      change:
        check: ({node, context}) ->
          n = node.getAttribute(\name)
          context.data.{}config[n] = node.checked
      input: 
        input: ({node, context}) ->
          n = node.getAttribute(\name)
          context.data[n] = node.value
    init:
      check: ({node}) ->
        node.setAttribute \id, id = Math.random!toString(36)substring(2)
        node.nextSibling.setAttribute \for, id
    handler:
      criteria:
        list: ({context}) -> context.data.criteria
        init: (opt) ->
          {context, node, data, local} = opt
          local.context = opt
          local.view = new ldView view.criteria <<< {root: node, context: opt}
        handler: ({context, node, data, local}) ->
          local.view.setContext {} <<< local.context <<< {context, data}
          local.view.render!


  view.root = new ldView do
    root: '[ld-scope=ui]'
    action:
      click:
        "new-block": ->
          form-def.block.push {name: "form-file", key: Math.random!toString(36)substring(2), criteria: []}
          view.root.render!
        "render": ->
          output.innerText = JSON.stringify(form-def)

    handler: do
      bok: do
        key: -> it.key
        list: -> form-def.block
        init: (opt) ->
          {node, local} = opt
          local.context = opt
          local.view = new ldView view.block <<< { root: node, context: opt }
        handler: ({node, local, data}) ->
          local.view.setContext {} <<< local.context <<< {data}
          local.view.render!


  
  @

new _!
