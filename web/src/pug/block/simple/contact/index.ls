module.exports =
  pkg: extend: name: \@makeform/nest, dom: \overwrite
  init: ({pubsub}) ->
    conditions = [
    * src: \name, config: [
      * values: <[ok]>, path: <[title]>, enabled: false
      ]
    ]
    fields =
      name:
        type: \@makeform/input
        meta: title: "Contact Name", is-required: true
      title:
        type: \@makeform/input
        meta:
          title: "Position", is-required: true
          term: [{opset: \length, op: \lte, config: val: 5}]
      gender:
        type: \@makeform/input
        meta: title: "Gender", is-required: false
      email:
        type: \@makeform/input
        meta:
          title: "Email"
          desc: "email is required for production project"
          is-required: false, term: [{opset: \string, op: \email}]

    pubsub.fire \@makeform/nest:init, {mode: \object, view: {}, fields, cx: conditions}
