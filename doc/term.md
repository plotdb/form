# term

A `term` ( `form.term` ) is a pair of id of `op` and `opset`, with a config object following given `op`'s config spec. Id of `op` in a `term` is subjected to change but should always be from one of the ops in specified `opset`.


Sample usage:

    term = new form.term({ opset: 'string', enabled: true })
    term.validate(...)


## Constructor Options

 - `opset`: either an opset, or id of opset to use.
 - `op`: id of the op to use. use `defaultOp` of `opset` if omitted.
 - `config`: config object used when calling `op.validate`. generated from default value of `op` if omitted.
 - `enabled`: if false, `validate` always return true. default true.
 - `msg`: message to show when there is an error by this term.


## API

 - `toggle(v)`: toggle `enabled` value
 - `set-opset(opset, op, cfg)`: set opset.
   - `opset`:  either an opset or id of opset to use
   - `op`: id of the op ( in assigned opset ) to use. use `defaultOp` if omitted
   - `cfg`: config to use when calling `op.validate`. use default value if `cfg` is omitted.
 - `set-op(id)`: set op. id is the op to use. use `defaultOp` from `opset` if id is omitted
 - `set-config(cfg)`: use `cfg` as the config to use when calling `op.validate`
   - config is reset to default value if `cfg` is omitted.
 - `validate(v)`: return Promise, resolving to either true or false, based on the validation result of a given value `v` based on the `op` and `config` set.
 - `serialize()`: return a serialized term that can be used to reconstruct a term object.
   - to deserialize, simply use `new form.term(serializedObject)`.
 - (TBD) `deserialize(v)`: deserialize a serialized object `v` into this object.
