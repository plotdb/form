
form.manager = bm = new block.manager!
cr = new block.class do
  name: "form-block"
  version: "0.0.1"
  code: do
    dom: ->
      pug.render """
      div
        plug(name="content") empty block
        hr
        div(ld-each="term")
          span(ld="delete") x
          span &nbsp;
          span(ld="name")
        div
          span(ld="add-term") add term
          input(ld="term-name")
        hr
        div powered by form block
      """
    style: ""
    script: -> do
      init: ({root, pubsub}) ->
        @lc = lc = {term: [123]}
        view = new ldView do
          root: root
          action: click: do
            "add-term": ->
              lc.term.push(view.get('term-name').value or Math.random!toString(36)substring(2))
              view.render!
              pubsub.fire \add-term, lc.term
          handler:
            term: do
              list: -> lc.term
              view:
                action: click: do
                  delete: ({context}) ->
                    lc.term.splice(lc.term.indexOf(context), 1)
                    view.render \term
                    pubsub.fire \add-term, lc.term
                handler: do
                  name: ({node, context}) ->
                    node.innerText = context

c = new block.class do
  name: "long-answer"
  version: "0.0.1"
  extend: cr
  code: do
    dom: ->
      pug.render """
      div: div(plug="content")
        input(ld="input")
        div(ld="warn") X
        div(ld="pass") V
        div(plug="test")
      """
    style: ""
    script: -> do
      init: ({root, parent, pubsub}) ->

        @form = form.block.get \long-answer
        @ <<< {valid: false, required: true}
        term-email = new form.term {opset: \string, op: \email}
        type-string = form.type.get \string
        view = new ldView do
          root: root
          init-render: false
          action: input: do
            input: ({node}) ~> validate!
          handler: do
            input: ({node}) ->
            warn: ({node}) ~>
              node.innerText = if type-string.is-empty(view.get('input').value) =>
                "this field is required."
              else "this is not an email"
              node.style.display = if !@valid => \block else \none
            pass: ({node}) ~>
              node.style.display = if @valid => \block else \none

        validate = ~>
          v = type-string.cast view.get('input').value
          @valid = term-email.verify v
          (parent.lc.[]term).map ~>
            if !~v.indexOf(it) => @valid = false
          view.render!
        view.render!

        pubsub.on \add-term, ->
          validate!
          view.render!


form.init = proxise ->
  bm.init!
    .then -> bm.set cr
    .then -> bm.set c

form.block.register 'long-answer', long-answer = -> @
long-answer.id = \long-answer
long-answer.prototype = Object.create(Object.prototype) <<< form.block.prototype <<< do
  attributes: ->
  serialize: ->
  deserialize: ->
  toString: ->
  parse: ->


form.type.register do
  name: \string
  id: \string
  opset: \string
  cast: (v) -> if v? => "#v" else ""
  is-empty: (v) -> (!(v?) or !v.length)

form.opset.register do
  name: \string
  id: \string
  default-op: \include
  ops:
    include:
      config: {i: 'some text'}
      func: ({v,c}) -> !!~v.indexOf(c.config.i)
    exclude:
      config: {i: 'some text'}
      func: ({v,c}) -> !~v.indexOf(c.config.i)
    email: ({v,c}) -> curegex.get(\email).exec(v)
    url: ({v,c}) -> curegex.get(\url).exec(v)
