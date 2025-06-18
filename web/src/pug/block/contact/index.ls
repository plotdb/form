module.exports =
  pkg: extend: name: \@makeform/nest, dom: \overwrite
  init: ({pubsub}) ->
    fields = 
      name:
        type: \@makeform/input
        meta:
          title: "name"
          is-required: true
      title:
        type: \@makeform/input
        meta:
          title: "title"
          is-required: true
          term: [{opset: \length, op: \lte, config: val: 5}]
      gender:
        type: \@makeform/input
        meta:
          title: "gender"
          is-required: false

    pubsub.fire \init.nest, {mode: \object, view: {}, fields}
