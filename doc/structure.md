form-data = {
  (suuid): {value:...}, 
]

form-def = [
  {id: ..(suuid).., type: type-file, ..., config: {
    title: ...
    description: ...
    required: bool
    public: bool
    criteria: [{ attr: ..., ruleset: ..., config: {...}}]
  }}
  {id: ..(suuid).., type: type-show-answer, ..., config: { ... }}
]

block-file:
  type: type-file

block-short-answer:
  type: type-text


type-file:
  name: "file"
  attr:
    format:
      ruleset: ruleset-format
      get: -> ...

type-text:
  name: "text"
  attr:
    text:
      ruleset: ruleset-text
      get: ->


ruleset-format
ruleset-text
  type: \text
  sanity-check: ->
  convert: ->
  default-operation: ...
  operations:
    <op-name>:
      args: [...]
      func: ->
