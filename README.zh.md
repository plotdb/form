# @plotdb/form

@plotdb/form 是一個表單控制控制函式庫。

 - manager - 管理多個表單元件並確認整體的狀態、事件追蹤與提供整合的資料輸出入。
 - widget - 管理單個輸入單元的狀態、內容資料的輸出入與事件
 - validator - 基於各類數值可執行的測試整合而成的數值條件控制器，包含：
   - opset / op:  運算元與運算集，可進行不同的運算測試，例如數值範圍、字串比對等等
   - term: 基於運算元的條件。例如，「使用字串比對運算元，應以 `https` 開頭」，即為一種 term。

一般來說，您會建立一個 manager, 其中包含多個 widget, 而各個 widget 中有不同的 termsheet ，並基於用戶輸入所得到的 manager 事件與狀態來判斷當前的輸入狀態。

@plotdb/form 僅定義基礎框架與通用的基本運算集；不過，我們基於 @plotdb/form 實作了一系列的表單元件，您可以在 [@makeform](https://github.com/makeform) 專案庫下略探一二；此外，[grantdash](https://grantdash.io) 則基於 @plotdb/form 與 @makeform 元件庫建立了一個線上徵件與表單系統，亦可參考。

基本安裝做法如下：

    npm install @plotdb/form

接著，依您的習慣載入安裝的 index.min.js 檔案 ( 於 `node_modules/@plotdb/form/index.min.js` ); 您亦可使用 [fedep](https://github.com/plotdb/fedep) 前端套件管理工具替您操作檔案的位置設定。

@plotdb/form 與 @plotdb/konfig 有些類似，但定位上 @plotdb/form 是針對需要複雜動態、內容驗證的表單填寫，而 @plotdb/konfig 則是更接近儀表板式的數值設定與參數調整。參閱 [@plotdb/konfig](https://github.com/plotdb/konfig) 以取得更多資訊。


## 基本概念

建立一個基本的管理物件:

    formmgr = new form.manager()

從某處取得一個表單元件，例如 `@makeform/input`，可透過 `@plotdb/block` 載入:

    blockmgr = new block.manager( ... );
    blockmgr.from({
      name: '@makeform/input'
    }, {
      root: document.body,
      data: { ... /* widget metadata, described below */ }
    })
        .then(function({interface: itf}) { ... })
      
取得其介面物件後，即可加入 form manager 中：

    ....
      .then(function({interface: itf}) { 
          formmgr.add({widget: itf, path: "some-name"
      })

其中 `path` 代表這個元件的值儲存於管理物件內存值的位置；在資料匯出時，你可以在這個位置找到此元件的值：

    val = formmgr.value!
    val["some-name"]     /* 此即為該元件的值 */


利用事件監控表單填寫狀態：

    formmgr.on("readystatechange", function(ready) {
        if(read) { console.log("finished.");
    });


## Widget Meta Data

一般來說，元件開發是較進階的議題；我們先討論使用已有的元件時，您該如何設定，即上個段落中的範例程式碼中我們提到的「widget metadata」的部份。

為了更細緻的控制元件的行為，在使用元件時您需要提供 widget metadata; 在上個段落的範例中，他使用了 @plotdb/block `manager.from` 中、"data" 參數將 widget metadata 帶入；這會依實作而可能有所差異，但在 @makeform 中的所有元件都遵循著這個規格。不過，當您已取得元件時，亦可以使用 `deserialize` API 來更新 widget metadata:

    widget.deserialize({
        /* ... metadata */
    })
  
widget metadata 是一個物件，裡面包含了通用以及專用的各類元件設定，比方說是否唯讀、標題與說明、數值限制條件測試等等。一個範例物件如下：

    {
        title: "Last Name"
        desc: "Yous last / family name"
        isRequired: true
        readonly: false
        tag: ["name"]
        term: [{opset: "string", op: "regex", config: {rule: "\\S{1}"}}]
        config: {
          limitation: "English Only"
        }
    }


