# op and opset

`op` ( `form.op` ) and `opset` ( `form.opset` ) are rules for validating user inputs.


## op

`op` indicates how to validate something, e.g., check if a given input is an email:

    email-op = new form.op( ... ) # setup an op.
    email-op.validate("some@email.com") # resolve to true or false based on how we setup this op.

### Constructor Options

 - `id`: unique id for used by program.
 - `name`: verbose name shown in interface. fallback to `id` if omitted.
 - `config`: an object representing configs of this `op`, in `@plotdb/konfig` format.
 - `func(value, config)`: validate `value` based on `config`.
   - return either true / false, or Promise resolving to true / false.
   - return / resolve to true only if `value` passed validation.
 - (TODO) `i18n`: metadata for i18n. in `i18next` schema.
 - (TBD) `cast(value)`: convert given value into the format requred by this op.


### API

 - `id`: public member for the id of theis op.
 - `name`: public member for the name of this op.
 - `config`: public member for the config of this op.
 - `validate(value, cfg)`: return Promise which resolves to either true or false.
   - `value`: the value to validate
   - `cfg`: config corresponding the `config` spec when constructing.
 - `configDefault()`: return default config defined by `config` spec when constructing.
 - (TBD) `cast(value)`: convert given value into the format required by this op.

### Sample Code

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


## opset

`opset` is used to group similar ops which expect the same data type of input values. With `opset`, a form widget can simply pick opsets that supports the type of validation it needs, and list available ops for users to choose.

For example, a `string` opset may contain ops such as `include`, `exclude`, `email`, etc.

    stringOpset = new form.opset({
      id: 'string',
      ops:
        include:
          func: (v, c = {}) -> ~("" + (v or '')).indexOf(c.str or '')
          config: {str: {type: \text}}
        exclude:
          func: (v, c = {}) -> !~("" + (v or '')).indexOf(c.str or '')
          config: {str: {type: \text}}
        email:
          func: (v) -> /^[^@]+@[^@]+$/.exec(v)
          config: {}
    });


### Constructor Options

 - `id`: unique id for used by program.
 - `name`: verbose name shown in interface. fallback to `id if omitted.
 - `i18n`: metadata for i18n. in `i18next` schema.
   - (TODO) `opset` should respect i18n config in `op`, if any.
 - `convert`: convert input value to a new value that can be used in op, if possible.
 - `ops`: Array or hash of `op`s.
   - `op` can be either:
     - `form.op` object
     - an object for constructor options
     - if `ops` is a hash, `op` can also be a function for `func` member of `op`.
   - key in hash will be used as op id if `op` is provided as constructor options.
 - `defaultOp`: id of the op in this opset that should be used as a default op.
   - if omitted, a random one will be picked ( usually the first one ).


### API

 - `id` - public member for the id of theis opset.
 - `name` - public member for the name of this opset.
 - `getOp(id)` - get `op` with id `id` in this opset.
 - `getOps() - get op list in this opset.


### Static Methods / Class API

 - `register(cfg)` - register an `opset` ( stored in `cfg` as either an `opset` object or an config object for constructing ) and associate given id with this `opset`.
 - `get(id)` - return an `opset` object corresponding to specified `id`. null if not found.


### Default opset

By default `@plotdb/form` provides following opsets:

 - `string`, including following ops:
   - `include`: input includes specified substring.
   - `exclude`: input does not include specified substring.
   - `email`: input is an email.
 - `number`, including following ops:
   - `lte`: input is less or equal than specified value
   - `gte`: input is greater or equal than specified value
   - `ne`: input does not euqal to specified value
   - `eq`: input euqals to specified value
 - `length`: calculate string length.
   - different approaches to count length includes:
     - `char`: by string length from javascript. default value
     - `simple-word`: a naive approach by separating words with space, and count all unicodes as one word.
   - here is a sample term for length op `lte` with `simple-word` algorithm:

         {opset: \length, enabled: true, op: \lte, msg: '太長了', config: val: 300, method: \simple-word}

   - including following ops:
     - `lte`: length is less than or equal to given value.
     - `eq`: length is equal to given value.
 - `file`, including following ops:
   - `extension`: file extension, with config:
     - `str`: comma separated extensions.
   - `size-limit`: file size limitation, with config:
     - `val`: maximal file size (in bytes)
   - `count-limit`: (deprecated) file count limitation
     - `val`: maximal file count - 1
   - `count-max`: maximal file count, with config:
     - `val`: maximal value
   - `count-min`: minimal file count, with config:
     - `val`: minimal value
   - `count-range`: file count range, with configs:
     - `min`: minimal value
     - `max`: maimal value

Please check `term.md` for convenient copy-past common term examples.
