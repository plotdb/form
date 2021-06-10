manager = new block.manager registry: ({name,version}) -> "/block/#name/#version/index.html"
manager.init!
  .then ->
    manager.get {name: "short-answer", version: "0.0.1"}
  .then -> it.create!
  .then -> it.attach {root}
