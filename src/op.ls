# 規則運算子
form.op = (opt = {}) ->
  @ <<< opt{id, name, config, func, opset}
  @

form.op.prototype = Object.create(Object.prototype) <<< do
  validate: (val, cfg = {}) ->
    if @opset.convert => val = @opset.convert val
    if (ret = @func val, cfg) instanceof Promise => ret else Promise.resolve(!!ret)

  config-default: ->
    cfg = {}
    for k,v of @config => cfg[k] = v.default
    return cfg


# 資料驗證的規則集
form.opset = (opt={}) ->
  @ <<< opt{name, id, i18n, convert}
  @ <<< {ops: {}}
  ops = if Array.isArray(opt.ops) => opt.ops.map -> {v: it, k: it.id}
  else [{k,v} for k,v of opt.ops]
  ops.map ({k,v}) ~>
    @ops[k] = if v instanceof form.op => v
    else if k => new form.op((if typeof(v) == \function => {func: v} else v) <<< {id: k, opset: @})
    else throw new Error('[@plotdb/form/opset] invalid op when initializing opset.')
    for k,v of opt.ops =>
      @ops[k] = new form.op((if typeof(v) == \function => {func: v} else v) <<< {name: k, id: k, opset: @})
  @default-op = if @ops[opt.default-op] => opt.default-op else [k for k,v of @ops].0
  @

form.opset.prototype = Object.create(Object.prototype) <<< do
  get-op: (id) -> @ops[id or @default-op]
  get-ops: -> [v for k,v of @ops]

form.opset.register = -> @[]list.push if it instanceof form.opset => it else new form.opset(it)
form.opset.get = (id) -> @[]list.filter(->(it.id or it.name) == id).0

word-len = (v = "", method) ->
  return if method == \simple-word =>
    v.split(/\s|[,.;:!?，。；：︰！？、．　"]/).filter(->it)
      .map ->
        # segment by non-ascii codes
        it.split(/[\u1000-\uffff]/).map(-> if it.length => 2 else 1).reduce(((a,b) -> a + b),0) - 1
      .reduce(((a,b) -> a + b), 0)
  else v.length

count-ops =
  "count-max":
    func: (v, c = {}) -> v.length <= c.val
    config: {val: {type: \number, hint: "maximal amount"}}
  "count-min":
    func: (v, c = {}) -> v.length >= c.val
    config: {val: {type: \number, hint: "minimal amount"}}
  "count-range":
    func: (v, c = {}) -> v.length >= c.min and v.length <= c.max
    config:
      min: {type: \number, hint: "minimal amount"}
      max: {type: \number, hint: "maximal amount"}
  "count":
    func: (v, c = {}) -> v.length == c.val
    config: {val: {type: \number, hint: "number of entries"}}

form.opset.default = [
  {
    id: "list"
    i18n:
      "zh-TW":
        "count-max": "數量上限"
        "count-min": "數量下限"
        "count-range": "數量範圍"
        "count": "數量要求"
    convert: (v) ->
      ret = if Array.isArray(v) => v
      else if v and Array.isArray(v.list) =>
        v.list ++ (if v.other and v.other.enabled => [v.other.text] else [])
      else [v]
      ret.filter -> it
    ops: {} <<< count-ops

  }, {
    id: "file"
    i18n:
      "zh-TW":
        "size-limit": "檔案大小上限"
        "count-limit": "檔案數量上限"
        "extension": "副檔名限制"
        "count-max": "檔案數量上限"
        "count-min": "檔案數量下限"
        "count-range": "檔案數量範圍"
    convert: (v) -> (if Array.isArray(v) => v else [v]).filter -> it
    ops: {
      "size-limit":
        func: (v, c = {}) -> !v.filter(-> it.size > c.val).length
        config: {val: {type: \number, hint: "maximal size"}}
      extension:
        func: (v, c = {}) ->
          exts = (c.str.split(',') or []).map -> it.toLowerCase!
          !v.filter(->!(((ext = it.filename.split('.')[* - 1]) or '').toLowerCase! in exts)).length
        config: {str: {type: \text, hint: "extension, comma separated, without dot"}}
      "count-limit": # deprecated. use `count-max` instead. note the difference between `<` and `<=`
        func: (v, c = {}) -> v.length < c.val
        config: {val: {type: \number, hint: "maximal file amount"}}
    } <<< count-ops
  }, {
    # file object modifier is required to be run before using this opset
    # for width, height, long, short, pixels fields
    id: "image"
    i18n:
      "zh-TW":
        "long-size": "長邊尺寸限制"
        "short-size": "短邊尺寸限制"
        "width": "寬度限制"
        "height": "高度限制"
        "pixel-count": "像素量限制"
    convert: (v) -> (if Array.isArray(v) => v else [v]).filter -> it
    ops: Object.fromEntries(
      [<[long-side long]>, <[short-side short]>, <[width width]>, <[height height]>, <[pixel-count pixels]>]
      .map (n) -> [
        n.0,
        ((k) -> {
          func: (v = [], c = {}) ->
            !v.filter(->!((!c.min? or it[k] >= (c.min or 0)) and (!c.max? or it[k] <= c.max))).length
          config: {min: {type: \number, hint: "minimal size"}, max: {type: \number, hint: "minimal size"}}
        }) n.1
      ]
    )
  }, {
    id: 'string'
    i18n:
      "zh-TW":
        string: "文字"
        include: "包含"
        exclude: "排除"
        email: "電子郵件"
        url: "網址"
        regex: "正規表達式"
    ops:
      include:
        func: (v, c = {}) -> ~("" + (v or '')).indexOf(c.str or '')
        config: {str: {type: \text}}
      exclude:
        func: (v, c = {}) -> !~("" + (v or '')).indexOf(c.str or '')
        config: {str: {type: \text}}
      email:
        func: (v) -> /^[^@]+@[^@]+$/.exec(v)
        config: {}
      url:
        func: (v) -> /^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#()?&//=]*)$/.exec(v)
        config: {}
      regex:
        func: (v, c={}) ->
          if !c.rule => return true
          if typeof(c.rule) == \object and c.rule.exec => return c.rule.exec(v)
          return new RegExp(c.rule).exec(v)
        config: {rule: {type: \text}}
  }, {
    id: 'length'
    i18n:
      "zh-TW":
        length: "長度"
        lte: "≦ 小於或等於"
        range: "範圍"
        number: "數字"
        "minimal length": "長度下限"
        "maximal length": "長度上限"
    ops:
      range:
        func: (v, c = {}) ->
          len = word-len("#v", c.method)
          len >= +c.min and len <= +c.max
        config:
          min: {type: \number, hint: "minimal length"}
          max: {type: \number, hint: "maximal length"}
          method: type: \choice, default: \char, values: <[char simple-word]>
      lte:
        func: (v, c = {}) -> word-len("#v", c.method) <= +c.val
        config:
          val: {type: \number, hint: "maximal length"}
          method: type: \choice, default: \char, values: <[char simple-word]>
      eq:
        func: (v, c = {}) -> word-len("#v", c.method) == +c.val
        config:
          val: {type: \number, hint: "length"}
          method: type: \choice, default: \char, values: <[char simple-word]>

  }, {
    id: 'number'
    i18n:
      "zh-TW":
        number: "數字"
        lte: "≦ 小於或等於"
        gte: "≧ 大於或等於"
        ne: "≠ 不等於"
        eq: "= 等於"
        is: "任何數字"
    convert: (v) -> +"#v".replace(/,/g,'')
    ops:
      lte:
        func: (v, c = {}) -> if isNaN(v) or isNaN(c.val) => false else +v <= +c.val
        config: {val: {type: \text, hint: "number for comparison"}}
      gte:
        func: (v, c = {}) -> if isNaN(v) or isNaN(c.val) => false else +v >= +c.val
        config: {val: {type: \text, hint: "number for comparison"}}
      ne:
        func: (v, c = {}) -> if isNaN(v) or isNaN(c.val) => false else +v != +c.val
        config: {val: {type: \text, hint: "number for comparison"}}
      eq:
        func: (v, c = {}) -> if isNaN(v) or isNaN(c.val) => false else +v == +c.val
        config: {val: {type: \text, hint: "number for comparison"}}
      is:
        func: (v) -> !isNaN(v)
        config: {}
  }, {
    id: \date
    i18n: "zh-TW":
      "min age": "最小年齡"
      "max age": "最大年齡"
      age: "年齡"
    convert: (v) -> return new Date(v)
    ops:
      age:
        config:
          min: {type: \number, hint: 'min age'}
          max: {type: \number, hint: 'max age'}
        func: (v, c = {}) ->
          dmin = (new Date(v.getYear! + 1900 + (c.min or 0), v.getMonth!, v.getDate!)).getTime!
          dmax = (new Date(v.getYear! + 1900 + (c.max or 0), v.getMonth!, v.getDate!)).getTime!
          dnow = Date.now!
          if c.min? and dmin > dnow => return false
          if c.max? and dmax < dnow => return false
          return true
  }
]

form.opset.default.map -> form.opset.register it

/**
 * term, for verification of values based on assigned op and config.
 * @constructor
 * @param {boolean} enabled - determine if this term is enabled or not
 * @param {string} opset - id of opset used by this term.
 * @param {string} op - id of op used by this term
 * @param {object} config - additional config for chosen op.
 */
form.term = (opt={}) ->
  @ <<< {enabled: true, opset: null, op: null, config: {}} <<< opt
  @set-opset opt.opset, opt.op, opt.config
  @

form.term.prototype = Object.create(Object.prototype) <<< do
  toggle: -> @enabled = if it? => it else !@enabled
  set-opset: (opset, op, cfg) ->
    if typeof(opset) == \string =>
      if !(@opset = form.opset.get opset) => throw new Error("no such opset '#opset'")
    else if (opset instanceof form.opset) =>
      @opset = opset
    else throw new Error("invalid opset")
    @set-op op, cfg

  set-op: (id, cfg) ->
    if !@opset => throw new Error("opset not set")
    if !(@op = @opset.get-op(id)) => throw new Error("no such op '#id'")
    @set-config cfg

  set-config: (cfg) ->
    if !@op => throw new Error("op not set")
    @config = if !cfg => @op.config-default! else cfg

  validate: (v) ->
    if !@op => Promis.reject(new Error("op not set"))
    @op.validate(v, @config)

  serialize: ->
    return {enabled: @enabled, opset: @opset.id, op: @op.id, config: @config, msg: @msg}

  # TBD - do we need this? ( we already can deserialize directly from new form.term(serializedObject) )
  deserialize: (v) ->
    @toggle v.enabled
    @set-opset v.opset, v.op, v.config
