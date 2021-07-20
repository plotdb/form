form
 - `manager` - manager of a form. Contains widgets.
 - `widget` - interface/bridge between manager and ui
 - `opset` - set of op.
 - `op` - operation for form value validation
 - `term` - a spec for validation

這個應該要包成 form 物件 ( 類似 chart 的做法 )
form widget interface ( defined as block )
 - `serialize()`: return serialized widget definition
 - `deserialize(v)`: deserialized widget definition (v)
 - `value(v, is-empty, source)`: set / get value
   - should fire `change` if value is changed and is not set by source.
 - `set-mode(m)`: set mode ( either 'edit' or 'view' )
 - `verify()`: verify if value is well-formatted accoroding to term and corresponding configs.

plug interface: ( 這個僅跟 base 有關 )
 - view: 用戶使用的介面
 - config: 額外的設定介面

events
 - update ( config updated. may need re-rendering )
 - change ( value changed )

form obj fields (serialized)
 - id
 - alias
 - name ( 跟 id, alias 或 title 差異在哪? )
 - title
 - desc
 - term ( check form.term definition )
 - config
   - is-required
   - is-public
