ruleset = do
  i18n: count: zh-tw: \正規表達式, en: 'Regular Expression'
  type: \regex
  sanity-check: ({v,c}) -> [v,c.config.i,cconfig.j].reduce(((a,b) -> a and (typeof(b) == \string)),true)
  convert: ({v,c}) -> return [v,c.config.i, c.config.j].map -> "#it"
  regex: do
    type: (v,i,j) -> 
    convert: (v, i, j) -> return [v,i,j].map -> "#it"
    match: (v,i) -> (new RegExp(i).exec(v))
    "not-match": (v,i) -> !(new RegExp(i).exec(v))

module.exports = ruleset
