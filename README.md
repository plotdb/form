# form ( tentative )

表單設計. 希望涵蓋的部份有：

 * 互動式表單設計, 透過 GUI
 * GUI 設計出表單的同時, 生成表單/資料規格定義
 * 利用表單規格定義繪製表單, 供終端用戶填表.
 * 透過資料規格做資料驗證. 前、後端均可用.

# example

    term = new form.term {opset: \string, op: \email}
    str = form.type.get \string
    ret = str.cast 'test@test.com'
    ret = term.verify ret
    console.log ret


## form.op

`form.op` indicates how to test something, e.g., check if a given input is an email:

    email-op = new form.op( ... )
    email-op.verify("some@email.com")

 - constructor options:
   - `id`: unique id for used by program.
   - `name`: verbose name shown in interface. fallback to `id` if omitted.
   - `config`: an object representing configs of this `op`, in `@plotdb/config` format.
   - `func(value, config)`: verify `value` based on `config`. 
     - return either true/false or Promise.
     - return / resolve to true if `value` passed verification.

 - API
   - `id` - public member for the id of theis op.
   - `name` - public member for the name of this op.
   - `config` - public member for the config of this op.
   - `verify(params)` - return true / false or Promise.


Sample op that tests if a number is between two values:

    op = new form.op({
      id: "between",
      config: {
        value1: { type: "number", default: 0}, 
        value2: { type: "number", default: 10} 
      },
      func: (val, cfg) {
        if(!cfg) => cfg = {};
        return (val >= cfg.value1 && val <= cfg.value2);
      }
    });


## form.opset

Once we have ops, we would like to have them in group, based on similar usage or data type, so we can list them for users to choose. `form.opset` is a set of `op`s, grouped according to applicable type. For example, `string` opset may contain `include`, `exclude`, `email`, etc.

 - constructor options
   - `id`: unique id for used by program.
   - `name`: verbose name shown in interface. fallback to `id if omitted.
   - `ops`: Array or hash of `op`s.
     - `op` can be either:
       - `form.op` object
       - an object for constructor options
       - if `ops` is a hash, `op` can also be a function for `func` member of `op`.
     - key in hash will be used as op id if `op` is provided as constructor options.
   - `defaultOp`: id of the op in this opset that should be used as a default op.
     - if omitted, a random one will be picked.
 - API
   - `id` - public member for the id of theis opset.
   - `name` - public member for the name of this opset.
   - `get-op(id)` - get `op` with id `id` in this opset.
   - `get-ops() - get op list in this opset.

 - class API
   - `register(cfg)`
   - `get(id)`


## form.term

A term is a basically an `op` of a specific `opset` and a `config` that can be used to verify different values. It's `op` is expected to change, but should always be picked from the assigned `opset`.

    term = new form.term { ... }
    term.verify(...)

 - constructor options:
   - `opset` - either an opset, or id of opset to use.
   - `op` - id of the op to use. use `defaultOp` of `opset` if omitted.
   - `config` - config object used when calling `op.verify`. generated from default value of `op` if omitted.
   - `enabled` - if false, `verify` always return true. default true.
 - API
   - `toggle(v)` - toggle `enabled` value
   - `set-opset(opset, op, cfg)` - set opset.
     - `opset`:  either an opset or id of opset to use
     - `op`: id of the op ( in assigned opset ) to use. use `defaultOp` if omitted
     - `cfg`: config to use when calling `op.verify`. use default value if `cfg` is omitted.
   - `set-op(id)` - set op. id is the op to use. use `defaultOp` from `opset` if id is omitted
   - `set-config(cfg)` - use `cfg` as the config to use when calling `op.verify`
     - config is reset to default value if `cfg` is omitted.
   - `verify(v)` - verify a given value `v` based on the `op` and `config` set.
   - `serialize()` - return a serialized term that can be used to reconstruct a term object.


## form.block

### attribute

An attribute is an aspect of data from a form.block. For example, a File form.block could contains following attributes:

 - `size` - size of all files combined.
 - `count` - count of files.
 - `modifiedtime` - modified time of last touched files.
 - `ext` - type of files.

Every attribute can be associated with one or multiple `form.opset` For example, above `ext` attribute can be associated with `extensions` type, which helps in determining if files in a given `ext` array all belong to certain file type.

