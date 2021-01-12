# Form Design

這裡定義表單元件設計的基本結構.

 - form-lib
   - blocks
   - types
   - rulesets
   - block
     - type ( name, or inline )
   - type
     - name
     - attrs
       - <attr-name>:
         - ruleset ( name, or inline )
         - get 
   - ruleset
     - name
     - sanity-check
     - convert
     - default-operation
     - operations
       - <operation-name>:
         - args
         - func
   - criteria

 - form-def
   - block
   - data


# 表單整體

使用 block design. 請參考 plotdb/block.


