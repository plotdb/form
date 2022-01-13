<-(->it.apply {}) _
input = document.querySelector('input')
input.addEventListener \change, -> console.log @value

@mgr = new block.manager registry: ({name,version,path,type}) ->
  if type == \block => return "/dev/block/#name.html"
  return "/assets/lib/#name/#version/#{path or \index.min.js}"

view = new ldview root: document.body

@mgr.init!
  .then ~>
    @mgr.get name: \input
  .then (bc) ->
    bc.create!
  .then (bi) ->
    bi.attach {root: view.get('i')} .then -> console.log bi.interface!

