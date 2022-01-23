<-(->it.apply {}) _

@mgr = new block.manager registry: ({name,version,path,type}) ->
  if type == \block => return "/block/simple/#name/#{path or \index.html}"
  return "/assets/lib/#name/#version/#{path or \index.min.js}"

@root = document.querySelector \#root

Promise.all <[short-answer single-choice multi-choice]>.map (name) ->
@mgr.get name: 'base'
  .then (bc) -> bc.create!
  .then (bi) ~> bi.attach {root: @root} .then -> bi.interface!
  .then -> console.log "interface: ", it

