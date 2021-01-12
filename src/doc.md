form.def - form 相關類別
 - manager
 - form - 整個表單
 - block - 表單各欄. 對應 {attr, type}
 - type - 資料類別. 指定可使用的 opset
 - opset - 運算集. 包含多個 op
   - name: opset 名稱
   - id: opset id
   - ops: hash 型式的 op 列表. op 可為 func 或物件.
     - func: 無預設參數時用. name / id 以 key 代表.
     - obj: 包含 op constructor 的各參數. 若省略 name 或 id, 預設使用 key 代表
 - op - 運算
   - constructor({id, name, config, func})
     - id:  運算 id. 若省略, 以 name 為準.
     - name: 運算顯示名
     - config: 預設設定
     - func: 執行驗證的欄位.
   - get-config: 取得預設設定值
   - verify({v, c}): 以 `c` 做參數, 對 `v` 做 `op` 運算的驗證.
 - term - 條件
   - constructor({enabled, opset, op, config})
     - enabled: 是否啟用
     - opset: 使用的 opset id
     - op: 使用的 op id
     - config: op 執行時參考的參數值.


form.imp - 依照類別實作的各種定義
