i18n-res = {}
module.exports =
  pkg:
    extend: name: "@makeform/nest", dom: "overwrite"
    i18n: i18n-res
  init: ({pubsub, parent, i18n}) ->
    i18n.addResourceBundles i18n-res
    for lng, res of i18n-res => block.i18n.addResourceBundle lng, '', res, true, true
    obj =
      mode: \object
      fields: fields
      conditions: conditions
      init: ->
        (cond = @manager!0.condition!)reset {conditions}
        @on \change, -> cond.run!
      view: common: handler: {}
    pubsub.fire("@makeform/nest:init", obj)

fields =
  name:
    type: \@makeform/input
    meta:
      title: "Project Name"
      is-required: true
  group:
    type: \@makeform/radio
    meta:
      title: \Group
      is-required: true
      config: values: <[Production Staging]>
  secret:
    type: \@makeform/textarea
    meta:
      title: "Secret Code"
      is-required: true
      desc: "Please provide secret code for this specific project"
  contact:
    type: ns: \local, name: \contact
    meta: {}

conditions = [
* src: \name, config: [
  * value: \secret, path: <[secret]>, enabled: true
  ]
* src: \group, config: [
  * value: \Production, path: [<[contact email]>], enabled: true
  ]
]

