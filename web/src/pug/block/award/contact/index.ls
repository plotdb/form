module.exports =
  pkg: extend: name: \@makeform/nest, dom: \overwrite
  init: ({pubsub}) ->
    fields =
      name:
        type: \@makeform/input
        meta:
          title: "申請人姓名"
          is-required: true
          config: placeholder: "請輸入真實姓名"
      title:
        type: \@makeform/input
        meta:
          title: "職稱"
          is-required: true
          config: placeholder: "例：設計師、製作人、工程師"
      organization:
        type: \@makeform/input
        meta:
          title: "所屬單位／公司"
          is-required: true
          config: placeholder: "請輸入所屬單位全名"
      phone:
        type: \@makeform/input
        meta:
          title: "聯絡電話"
          is-required: false
          desc: "若有問題主辦單位將以電話確認"
          config: placeholder: "例：0912-345-678"
      email:
        type: \@makeform/input
        meta:
          title: "電子郵件"
          is-required: true
          desc: "主辦單位將以此信箱與您聯繫"
          config: placeholder: "example@email.com"
          term: [{opset: \string, op: \email}]

    pubsub.fire \@makeform/nest:init, {mode: \object, view: {}, fields}
