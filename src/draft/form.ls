form = (opt = {}) ->
  @defs = opt.defs
  /* defs:
  [{ blockdef }, { blockdef }, ...]
  */
  @
form.prototype = Object.create(Object.prototype) <<< do
  # data sync method
  insert-block: (b, idx) -> @defs.splice (if idx? => idx else @defs.length), 0, b
  delete-block: (idx) -> @defs.splice idx, 1
  move-block: (i, j) ->
    if i == j => return
    block = @defs.splice i, 1
    @defs.splice if (i > j => j else j - 1), 0, block

/*
form.blockdef = (opt={}) ->
  @def = opt.def
  
  # {
  #   id, type
  #   config: {title, description, required, public}
  #   criteria: [
  #     {attr, ruleset, config},
  #     ...
  #   ]
  # }

  @set-type @def.type
  @

form.blockdef.prototype = Object.create(Object.prototype) <<< do
  set-type: -> @type = form.types.get it
*/

form.type = (opt={}) ->
  @ <<< opt{name, attr}
  /* attr: {ruleset, get} */

form.type.prototype = Object.create(Object.prototype) <<< {}

form.ruleset = (opt={}) ->
  @ <<< opt{name,sanity-check,convert,default-operation,operations}

form.ruleset.prototype = Object.create(Object.prototype) <<< {}


