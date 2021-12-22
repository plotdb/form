module.exports =
  pkg:
    name: "sheet", version: "0.0.1"
    extend: name: "base", version: "0.0.1"
    license: "MIT"
    description: ""
    dependencies: [
      {url: "/assets/lib/@plotdb/sheet/main/index.min.css"}
      {url: "/assets/lib/@plotdb/sheet/main/index.min.js"}
    ]
    i18n:
      en:
        row-count: "row count"
        col-count: "column count"
      "zh-TW":
        sheet: "試算表"
        row-count: "列數"
        col-count: "行數"
  init: ({root,parent,context,pubsub}) ->
    {form,sheet} = context
    pubsub.on \change, ->
    pubsub.on \update, ->
    node = parent.node!
    s = new sheet root: node
    s.on \update, -> parent.value s.data, false, true

    parent.opsets.push new form.opset do
      id: 'sheet'
      ops:
        row-count:
          func: (v = [], c = {}) -> 
            if !Array.isArray(v) or isNaN(c.min) or isNaN(c.max) => return false
            max = 0
            for i from 0 til v.length =>
              if Array.isArray(v[i]) and v[i].length and v[i].filter(->it? and it != "").length => max = i + 1
            return max >= +c.min and max <= +c.max
          config:
            min: {type: \text, name: "min", hint: "minimal value"}
            max: {type: \text, name: "max", hint: "maximal value"}

        col-count:
          func: (v = [], c = {}) -> 
            if !Array.isArray(v) or isNaN(c.min) or isNaN(c.max) => return false
            matched = false
            for i from 0 til v.length =>
              u = v[i] or []
              if !(Array.isArray(u) and u.length and u.filter(->it? and it != "").length) => continue
              max = 0
              matched = true
              if Array.isArray(u) =>
                for j from 0 til u.length => if u[j]? and u[j] != "" => max = j + 1
              if max < +c.min or max > +c.max => return false
            return matched
          config:
            min: {type: \text, name: "min", hint: "minimal value"}
            max: {type: \text, name: "max", hint: "maximal value"}
