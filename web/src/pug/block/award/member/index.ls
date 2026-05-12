module.exports =
  pkg: extend: name: \@makeform/nest, dom: \overwrite
  init: ({pubsub}) ->
    fields =
      name:
        type: \@makeform/input
        meta:
          title: "姓名"
          is-required: true
          config: placeholder: "請輸入成員姓名"
      role:
        type: \@makeform/input
        meta:
          title: "擔任角色"
          is-required: true
          config: placeholder: "例：導演、工程師、設計師"
      organization:
        type: \@makeform/input
        meta:
          title: "所屬單位"
          is-required: false
          config: placeholder: "請輸入所屬單位"
      email:
        type: \@makeform/input
        meta:
          title: "電子郵件"
          is-required: false
          config: placeholder: "example@email.com"
          term: [{opset: \string, op: \email}]

    pubsub.fire \@makeform/nest:init, {mode: \list, view: {}, fields}
