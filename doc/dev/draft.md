form
field
field-group / block
criteria
validator

 * 一個完整的表單會有很多的欄位可以輸入.
 * 甚至有一個完整的閱讀體驗. ( webedit > form )
 * 就表單部份, 就是一個輸入介面 -> 驗證 -> 資料 -> 回饋 的一個流程
 * 所以我們要注意元件間的互動
 * 還有元件的設計
 

data: 資料單元. 內容物未定
block: 資料單元的細節定義.
 - 如何驗證?
 - 如何輸入?
 - 互動模式?

比方說, 一個單純的數字: <input>                (介面)
<input name=xx> 輸入 -> data.xx = xx.value     (取值)
  -> 如果 data.xx > 10 : validation failed     (驗證)
  -> 如果 data.xx > 20 : 顯示額外參數          (回饋)

或一個完整的預算表: <div> ... </div>

do
  key:                  ( id )
  description
  config
  name: xx              ( 資料命名 )
  type: number          ( 型態 )
  validation: ->        ( 如何驗證 )
  trigger: ->           ( 回饋程式 )


validation 也可以單純做一個函式, 但這樣無法輕易客製, 也太累.
 所以我們要設計一個 validation language
