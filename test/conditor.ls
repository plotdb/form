# conditor tests, with real managers and widgets. run: npx lsc test/conditor.ls
require! <[assert]>
global.debounce = require \@loadingio/debounce.js
global.proxise = require \proxise
form = require "../dist/index.js"

wait = -> new Promise (res) -> setTimeout res, 10
mk = (meta = {}, mod) -> w = new form.widget {mod}; w.deserialize({} <<< meta); w
mgr = (ws) ->
  m = new form.manager!
  for k,w of ws => m.add {widget: w, path: k}
  m
st = (w) -> m = w.serialize!; [!!m.disabled, !!m.isRequired, !!m.readonly]

# a nest-like widget in list mode: entries, each with its own manager.
# resolve: `*` ( or no selector ) for all entries, `#<key>` or an index for one.
list = (entries) ->
  w = mk {}, do
    content: -> [{[k, v.content!] for k,v of e.m.widgets!} for e in entries]
    resolve: (p) ->
      [h, ...t] = p
      es = if h == \* => entries
      else if typeof(h) == \number => [entries[h]].filter(->it)
      else if /^#/.exec(h) => entries.filter((e) -> "##{e.key}" == h)
      else (t = p; entries)
      es.map((e) -> e.m.resolve t).reduce(((a, b) -> a ++ b), [])
  w.entries = entries
  w

entry = (key, role) ->
  ws = role: mk!, title: mk!
  ws.role.value role
  {key, m: mgr(ws), ws}

ok = (name, f) -> f!then (-> console.log "ok   #name"), (e) -> console.log "FAIL #name\n", e; process.exitCode = 1

do ->
  w =
    type: mk!, pref: mk!, im: mk!, note: mk!, extra: mk!, a: mk!, b: mk!
    members: list [entry(\e1, \member), entry(\e2, \member)]
  root = mgr w
  c = root.conditor!
  c.init [
  * id: \im
    when: {some: [{var: \pref}, {in: [{var: ''}, <[line telegram]>]}]}
    effect: {targets: [\im], enabled: true, isRequired: true}
  * id: \team
    when: {'==': [{var: \type}, \team]}
    effect: {targets: [[\members, \*, \title]], enabled: true}
  * id: \lead
    when: {some: [{var: [\members, \*, \role]}, {'==': [{var: ''}, \lead]}]}
    effect: {targets: [\note], isRequired: true}
  * id: \extra
    precond: \team
    when: {'==': [{var: \pref}, null]}
    effect: {targets: [\extra], enabled: true}
  * id: \by-tag
    when: {rule: \team}
    effect: {targets: ['[tag~=t]'], readonly: true}
  * id: \m1
    when: {'==': [{var: \type}, \x]}
    effect: {targets: [\a], enabled: true}
  * id: \m2
    when: {'==': [{var: \type}, \y]}
    effect: {targets: [\a], enabled: true}
  ]
  e1 = w.members.entries.0.ws
  <- ok "initial states" (-> wait!then ->
    assert.deepEqual st(w.im), [true, false, false]
    assert.deepEqual st(e1.title), [true, false, false]
    assert.deepEqual st(w.note), [false, false, false]
  ) .then _
  <- ok "checkbox value in a list of values" (-> w.pref.value(<[sms line]>).then(wait).then ->
    assert.deepEqual st(w.im), [false, true, false]
    assert.equal c.result(\im), true
  ) .then _
  <- ok "path into list entries, all of them" (-> w.type.value(\team).then(wait).then ->
    assert.deepEqual st(e1.title), [false, false, false]
    assert.deepEqual st(w.members.entries.1.ws.title), [false, false, false]
  ) .then _
  <- ok "`some` over a field in all entries" (-> e1.role.value(\lead).then(wait).then ->
    # entry changes reach root as a change of `members` in real nests; emulate it
    root.fire \change, {path: \members}
    wait!then -> assert.deepEqual st(w.note), [false, true, false]
  ) .then _
  <- ok "precond" (->
    assert.equal c.result(\extra), false
    w.pref.value(null).then(wait).then ->
      assert.equal c.result(\extra), true
      w.type.value(\solo).then(wait).then -> assert.equal c.result(\extra), false
  ) .then _
  <- ok "merge: on if any rule turns it on" (->
    # m1 and m2 both control `a`: shown only if both are active ( disabled if any turns it on )
    w.type.value(\x).then(wait).then ->
      assert.deepEqual st(w.a), [true, false, false]
  ) .then _
  <- ok "conditors at different levels on the same widget" (->
    # an entry's own rule makes title required; root rule controls visibility
    ce = w.members.entries.0.m.conditor!
    ce.init [{when: {'==': [{var: \role}, \lead]}, effect: {targets: [\title], isRequired: true}}]
    w.type.value(\team).then(wait).then ->
      assert.deepEqual st(e1.title), [false, true, false]
      ce.init []
      assert.deepEqual st(e1.title), [false, false, false]
  ) .then _
  <- ok "selector by tag" (->
    w.b.deserialize({} <<< w.b.serialize! <<< tag: <[t]>)
    c.init c.rules!
    wait!then -> assert.deepEqual st(w.b), [false, false, true]
  ) .then _
  <- ok "clear restores states before effects" (->
    c.init []
    assert.deepEqual st(w.im), [false, false, false]
    assert.deepEqual st(w.b), [false, false, false]
    Promise.resolve!
  ) .then _
  <- ok "deps and refs" (->
    r = {when: {and: [{var: \x}, {some: [{var: [\y, \*, \z]}, {var: \inner}]}, {rule: \r0}]}}
    assert.deepEqual form.conditor.deps(r).sort!, <[x y]>
    assert.deepEqual form.conditor.refs(r), <[r0]>
    Promise.resolve!
  ) .then _
