mgr = new block.manager registry: ({name,version}) -> "/block/#name/#version/index.html"
mgr.init!
  .then -> mgr.get {name: "@plotdb/short-answer", version: "0.0.1"}
  .then (bc) -> bc.create!
  .then (bi) -> bi.attach root: document.querySelector('#container')
  .then -> mgr.get {name: "@plotdb/long-answer", version: "0.0.1"}
  .then (bc) -> bc.create!
  .then (bi) -> bi.attach root: document.querySelector('#container')

