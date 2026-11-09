# form.conditor

依表單的值，控制欄位的狀態（是否啟用、必填、唯讀）。規則全部是資料，可以序列化。取代 `form.condctrl`。

```ls
manager.conditor!init rules   # 設定規則並執行; 之後值改變時自動重算
manager.conditor!result \id   # 某條規則目前是否成立
manager.conditor!clear!       # 移除所有規則造成的效果
```

每個 manager 都可以有自己的 conditor ( `manager.conditor!` )，規則中的路徑相對於該 manager。
規則可以寫在根部 manager，經由路徑指到 nested widget 內的欄位；
nested widget 也可以在自己內部的 manager 帶規則。不同 conditor 作用在同一欄位時，效果會合併 ( 見下方 )。


## 規則

```
{id, name, when, precond, effect}
```

 - `id`: 省略時為 `_r<序號>`。
 - `when`: 判斷式，見下方。
 - `precond`: 另一條規則的 id；該規則不成立時，這條規則也不成立。
 - `effect`: `{targets, enabled | disabled, isRequired, readonly}`
   - `targets`: 路徑的陣列。
   - 規則成立時，對象套用這些狀態；不成立時套用相反的狀態。只寫需要控制的狀態。


## 判斷式

JSONLogic ( https://jsonlogic.com ) 的子集合:

 - `var`: 不在 `some` / `all` / `none` 的判斷式中時，讀取路徑上 widget 的 content ( 見「路徑」 )。
   - 路徑對應到一個 widget 時，為它的 content；路徑含有 `*` 或 tag 選擇器時，為所有 widget content 攤平後的陣列。
   - 停用的 widget 照常讀取，規則的結果只取決於欄位的值，不受其他規則的效果影響。若要隨上游條件失效，請使用 `precond` 或在 `when` 中明確加上該條件。
   - 不支援 JSONLogic 的預設值寫法 ( `{"var": ["a", 1]}` 在這裡是路徑 `a` > `1` )。
 - `some` / `all` / `none`: `[<陣列>, <判斷式>]`。陣列若是 `var`，一律讀為攤平的陣列，
   因此 checkbox 這類有多個值的欄位，和多筆資料中的同一欄位，用法相同。
   判斷式中的 `var` 讀取目前的項目: `{"var": ""}` 為項目本身，`{"var": "a"}` 為項目的 `a` 欄位。
 - `and` / `or` / `!` / `!!` / `if`
 - `==` / `!=` / `===` / `!==` / `<` / `<=` / `>` / `>=` ( `<` 與 `<=` 可帶第三個運算元，表示介於 )
 - `in`: `[值, 陣列或字串]`
 - `empty`: 值為空 ( `null`、`''` 或空陣列 )
 - `rule`: 另一條規則的結果，如 `{"rule": "r1"}`
 - 程式中使用時，`when` 也可以是函式 ( 不可序列化; 任何值改變都會重算 )。

例:

```js
// 偏好聯絡方式選了 line 或 telegram
{"some": [{"var": "pref"}, {"in": [{"var": ""}, ["line", "telegram"]]}]}
// 任一成員的角色為 lead
{"some": [{"var": ["members", "*", "role"]}, {"==": [{"var": ""}, "lead"]}]}
// 類型為 team, 且預算大於 10000
{"and": [{"==": [{"var": "type"}, "team"]}, {">": [{"var": "budget"}, 10000]}]}
```


## 路徑

路徑是陣列，每一段是欄位的 key，或選擇器；只有一段時可以寫成字串。
由 manager 開始，每一層解析自己的那一段，剩下的交給找到的 widget ( `widget.resolve` )，
因此 nested widget 怎麼組成 ( 一或多個 manager ) 由它自己決定。

選擇器:

| 選擇器 | 意義 | manager | nested widget ( 如 list 模式的 nest ) |
|---|---|---|---|
| `*` | 全部 | 所有 widget | 所有 entry |
| `#<key>` | 指定 key | 該 key 的 widget | 該 key 的 entry |
| `[tag~=<tag>]` | 帶有 tag | meta.tag 含有此 tag 的 widget | ( 自行定義 ) |
| `:nth-child(<n>)` / 數字 | 第 n 個 ( 從 1 起 ) / 索引 ( 從 0 起 ) | 不支援 | 指定的 entry |

nested widget 實作 `resolve(path)` 時，遇到不是選擇器的第一段，建議視為對所有 entry 解析，
與 `*` 相同 ( 例如 `["members", "role"]` 等於 `["members", "*", "role"]` )。


## 重算

 - manager 發出 `change` 時，只重算讀取該 key 的規則、對象在該 key 之下的規則，以及依賴它們結果的規則
   ( `precond` 與 `rule` )。同一個 microtask 中的多次改變會合併處理。
 - nested widget 內的值改變，在上層 manager 視為該 widget 改變。
 - 讀取或對象以選擇器開頭的規則，任何改變都會重算。


## 合併

作用在同一個 widget 同一個狀態的效果 ( 不論來自哪條規則、哪個 conditor ) 會合併:
任一效果要它成立，它就成立；只有在所有相關效果都不要它成立時才不成立。
沒有任何效果作用時，回到效果介入前的狀態。

例如兩條規則都控制欄位 A 的顯示，A 只有在兩條規則都要它顯示時才會顯示。


## 相關函式

 - `form.conditor.deps(rule)`: 規則讀取的路徑第一段 ( `*` 表示不確定 )
 - `form.conditor.targets(rule)`: 規則的對象路徑
 - `form.conditor.refs(rule)`: 規則以 `rule` 引用的其他規則
 - `form.conditor.is-selector(segment)`: 路徑的一段是否為選擇器
