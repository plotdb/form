
# multiple criteria - 若 datatype 有多個值 ( 如多個檔案 ), 有可能分別指定型態、長度等? 
# 亦或者 ruleset 要能處理 Array of Data

datatype
  attrs
    <name>: 屬性名
      ruleset: 使用的規則. 可以是字串 ( 對應到公用規則 ), 或是物件 ( 自訂規則 )
      get: 取得數值




# 輸入的資料類型為檔案
datatype-file = do
  # 該類型的屬性
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


file = ->
  value = (block.value or {}).list or []
  if !(value and value.length) => if empty-helper({block, empty: true, force}) => return that
  for c in (block.criteria or []) =>
    if !c.enabled => continue
    if c.type == \file-size =>
      ret = /^([0-9.,]+)([mk]b)?$/.exec(("#{c.input1 or '0'}").trim!.toLowerCase!)
      if ret =>
	limit = ret.1.replace(',','') * (if !ret.2 => 1 else if ret.2 == 'mb' => 1048576 else 1024)
      else limit = 0
      if value.map(-> it.size).filter(-> it >= limit).length => return {result: false, criteria: c}
    else if c.type == \file-format =>
      exts = (c.input1 or "").toLowerCase!.split(',')
      v = value.map ->
	ext = ((if it.name => it.name.split('.')[* - 1]) or it.ext or '').toLowerCase!
      if v.filter(->!(it in exts)).length => return {result: false, criteria: c}
    else if c.type == \file-count => if apply-criteria(c, value) => return that
  return {result: true}

text = ->
  return {result: true}

