main = do
  attrs: 
    size: 
      ruleset: \number
      get: ->
        ret = /^([0-9.,]+)([mk]b)?$/.exec(("#{config.i or '0'}").trim!.toLowerCase!)
        if !ret => limit = 0
        else limit = ret.1.replace(',','') * (if !ret.2 => 1 else if ret.2 == 'mb' => 1048576 else 1024)
        return value.map -> {v: it.size, c: {config: {i: limit}}}
    createdtime: -> /* not implemented */
    modifiedtime: -> /* not implemented */
    format:
      ruleset: 
        i18n: fileformat: zh-tw: \檔案格式, en: 'file format'
        type: \fileformat
        sanity-check: ({v,c}) -> v? and c.config.i? and c.config.j?
        convert: ({v,c}) ->
          c = {config: {i: c.config.i.split(',').filter(->it)}}
          return {v,c}
        default-operation: \inside
        operations:
          inside:
            args: <[i]>
            func: ({v,c}) -> (v in c.config.i)
      get: ->
        exts = (c.input1 or "").toLowerCase!.split(',')
        v = value.map ->
          ext = ((if it.name => it.name.split('.')[* - 1]) or it.ext or '').toLowerCase!
        if v.filter(->!(it in exts)).length => return {result: false, criteria: c}
    count: -> /* not implemented */

module.exports = main
