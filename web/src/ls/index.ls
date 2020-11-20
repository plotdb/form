form-host = (opt = {}) ->
  @opt = do
    # dom generation mode:
    # 0 - form block one by one ( google form style )
    # 1 - inject into specific location
    # 2 - query instead of generating
    dom-mode: 0
  @opt <<< JSON.parse(JSON.stringify(opt))
  root = opt.root
  @root = root = if typeof(root) == \string => document.querySelector(root) else if root => root else null
  @blocks = {}
  @criteria = {}
  @

form-host.prototype = Object.create(Object.prototype) <<< do
  register: (n,o) -> @blocks[n] = o

  # type, rule 需要 verbose name
  list-type: -> [v{name,key} for k,v of @criteria]
  list-rule: (type) -> [v{name,key} for k,v of @criteria[type]]
  list-block-type: -> [k for k of @blocks]

  set-rule: ({name, key, rules}) ->
    @criteria[type] = {name,key,rules}

  get-rule: (type, rule) ->
    @criteria{}[type].{}rules[rule] or (->false)

  feedback: (node, value) ->
    console.log node, value
    ld$.find(node, '.feedback', 0).innerText = value
  validate: (value, criteria = []) ->
    console.log criteria
    for c in criteria =>
      func = @get-rule(c.type, c.rule)
      ret = func value, c.cfg
      console.log func, ret
      if !ret => return c
    return null


  dom-wrapper: (n, id) ->
    """
    <div ld-form="#id" class="form-block">
    #n
    </div>
    """
  prepare: (o) ->
    html = ""
    bs = o.block.map (b,i) ~>
      n = ld$.find(@root, "[ld-form=#{b.id}]", 0)
      obj = new @blocks[b.name] {root: n, cfg: b, host: @}
      if !@opt.dom-mode => html += (ret = @dom-wrapper obj.dom!, b.id)
      obj
    if !@opt.dom-mode => @root.innerHTML = html

    bs.map (b,i) ~>
      n = ld$.find(@root, "[ld-form=#{b.cfg.id}]", 0)
      b.set-node n


form-block = (opt) ->
  @init opt
  @

form-block.prototype = Object.create(Object.prototype) <<< do
  init: (opt) ->
    @opt = opt
    @cfg = opt.cfg
    @host = opt.host
    if @opt.root => @set-node @opt.root
  set-node: (r) ->
    if @n => @n.removeEventListener \change, @_listener 
    @root = if typeof(r) == \string => document.querySelector(r) else if r => r else null
    @n = ld$.find(@root.parentNode, 'input', 0)
    @n.addEventListener \change, (@_listener = ~> @validate @n.files)
  validate: (v) ->
    console.log "validating #v"
    ret = @host.validate v, @opt.cfg.criteria
    if ret =>
      @host.feedback @root, 'invalid'
    console.log ret


form-file = (opt) ->
  @init opt
  @

form-file.prototype = Object.create(form-block.prototype) <<< do
  dom: ->
    return """<input type="file">"""


