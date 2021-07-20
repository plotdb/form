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



## form.block

### attribute

An attribute is an aspect of data from a form.block. For example, a File form.block could contains following attributes:

 - `size` - size of all files combined.
 - `count` - count of files.
 - `modifiedtime` - modified time of last touched files.
 - `ext` - type of files.

Every attribute can be associated with one or multiple `form.opset` For example, above `ext` attribute can be associated with `extensions` type, which helps in determining if files in a given `ext` array all belong to certain file type.

