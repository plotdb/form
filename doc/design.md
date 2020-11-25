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


# 表單元件

定義各種輸入方式, 其對應的介面、格式驗證、輸出值等.

1. 元件 ( block )
  - 由元件名, UI, 對應的資料類型 (type) 與資料驗證的條件 (criteria) 所組成

2. 資料類型 ( type )
  - 輸入資料的分類. 如「檔案」、「預算表」、「文字」、「電話」等.
  - 同一個資料類型可以有多個元件實作.
  - 一個分類可以有一個或多個屬性 ( attr )

3. 資料屬性 ( attr )
  - 特定資料類型下, 可以取出的不同成份. 
  - 比方說, 「檔案大小」、「預算總額」、「預算項目數」、「電話國碼」等等.
  - 每個屬性至少有兩個成份
    - ruleset - 用以限制條件的規則集 ruleset. 可以是:
      - `string` - 取用公用 ruleset 
      - `object` - 自定義 ruleset
      - `array` - 內容包含前兩者, 代表可選多組不同定義
    - get - 取值

4. 規則集 ( ruleset )
  - 一組規則, 沿用同一種資料型態跟設定. 包含:
    - sanity-check - 確認輸入正確
    - convert - 預轉換輸入格式
      - args - 用到的參數
      - test - 測試函式


5. 驗證條件 ( criteria )
  - 附屬於 block, 依 type 所定義之屬性、規則設定的一組數值, 用以執行驗證. 比方說
    { attr: "format", ruleset: "format", rule: "contain", config: { ... } }
 
