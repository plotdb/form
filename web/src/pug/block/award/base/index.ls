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
      init: -> (cond = @manager!0.condition!)reset {conditions}
      view: common: handler: {}
    pubsub.fire("@makeform/nest:init", obj)

fields =
  contact:
    type: ns: \local, name: \award/contact
    meta: {}
  member:
    type: ns: \local, name: \award/member
    meta: {}
  detail:
    type: ns: \local, name: \award/detail
    meta: {}

conditions = []
