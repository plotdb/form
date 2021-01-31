form.def - form 相關類別
 - manager
 - form - 整個表單
 - block - 表單各欄. 對應 {attr, type}
 - type - 資料類別. 指定可使用的 opset


form.imp - 依照類別實作的各種定義

block

 - id
 - purpose ( 改為 alias? )
   - alias to `teamname`, `vatid`, `contact-phone`, etc
 - basic-config
   - title
   - desc ( in markdown? )
   - public
   - required
   - show-desc
 - specific-config
   - other-enabled
   - markdown-enabled
   - range-enabled
 - resources ( atached files, images in description ) 
