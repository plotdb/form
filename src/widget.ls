form.widget = (opt = {}) ->
  @root = if typeof(opt.root) == \string => document.querySelector(opt.root) else opt.root
  @evt-handler = {}
  @data = {config: {}, key: suuid!}
  @ <<< _value: null, _empty: true
  @_mode = opt.mode or \view
  @opsets = opt.opsets or []
  @errors = []
  @

form.widget.prototype = Object.create(Object.prototype) <<< do
  on: (n, cb) -> (if Array.isArray(n) => n else [n]).map (n) ~> @evt-handler.[][n].push cb
  fire: (n, ...v) -> for cb in (@evt-handler[n] or []) => cb.apply @, v
  serialize: ->
    ret = {} <<< @data{key, title, desc}
    ret.config = JSON.parse(JSON.stringify(@data.config or {}))
    ret.term = @data.term.map -> it.serialize!
    ret
  deserialize: (v) ->
    @data <<< v{key, title, desc}
    @data.config = JSON.parse(JSON.stringify(v.config or {}))
    # TODO
    @data.term = v.term.map -> new form.term!deserialize it

  mode: ->
    if !(it?) => return @_mode
    @mode = it
    @verify!
    @render!
  value: (v, is-empty = false, from-source = false) ->
    if v? =>
      @ <<< _value: v, _empty: is-empty
      @verify!
    if !source => @fire \change, @_value
    return @_value

  verify: ->
    if @_empty and @data.config.is-required =>
      @errors = ["required"]
      return view.render!
    Promise.all(
      @data.term
        .filter (t) -> t.enabled
        .map (t) ~> t.verify(@_value).then (v) ~> [t,v]
    )
      .then ~>
        @errors = it.filter(-> !it.1).map -> it.0.msg
        view.render!

  render: ->

