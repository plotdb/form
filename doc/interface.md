
## Abstract

對於某個概念, 我們會使用某實作來實現. 但在不同需求下, 實作有可能會不同. 

比方說, 表單中「填空」這個概念, 我們可以使用 input box 實現, 但也可以使用 textarea 來實現. 這個實現方式可能會依情境、軟體框架、介面或視覺設計而有所不同.

由於我們已經有了用於定義實作的 block ( `@plotdb/block` ), 所以定義可以逕自使用 block 來做, 但我們仍會需要定義 `概念`. 接著, 設計一個 `概念` 到 `實作` 的對應機制,  讓實作更容易被抽換. 最後, 除了預設的 `概念` 以外,  我們需要讓 `概念` 容易被擴充.

 - concept: `概念` 的定義方式
 - implementation: `實作` 的定義方式
 - mapping: `概念` 到 `實作` 的對應方式
 - preset: `概念` 的預設集
 - extension: `概念` 的擴充方式
 - 實際上使用的實作定義

## Definition

概念可以使用類似變數的定義方式. 接受小寫英文字母、數字跟 `-` 的組合 ( `[a-z]([a-z0-9]-?)*` ). 若想使用類似模組定義的格式, 則可以再接受 `@`, `/`, `.` 等字元.

實作則簡單使用 `block` 的定義規格即可.

我們可以使用簡單函式做對應, 如下例將一概念名對應到一個區塊定義:

    mapping = (concept) -> return Promise.resolve({name: '...', version: '...', path: '...'});

考慮到客製對應不一定能完全對應現有的概念空間, 我們可以使用串接式對應, 並以 Promise.reject 傳回值代表無對應:

    mapping = (concept) -> return if /.../.exec(concept) => Promise.resolve(...) else Promise.reject(new Error!)
    mapping-default = (concept) ->
      Promise.resolve!mapping(concept).catch ->
        return { name: '...', ...}


對於 form 模組, 我們可以定義下列預設集以及定義:

 - short-answer -> {name: '@plotdb/form.widget.default', path: 'short-answer'}
 - long-answer -> {name: '@plotdb/form.widget.default', path: 'short-answer'}

並定義擴充用的命名空間為:

    ext.org-name.widget-name

最後, 實際使用區塊時, 則會將對應的區塊識別物件紀錄起來, 以處理相容性問題. 若未紀錄, 則逕自使用程式預設提供的版本. 例如使用 short-answer 建立了一個短答物件後:

    {
      name: "short-answer"
      block: {name: 'short-answer', version: '0.0.1'}
      config: { title: '...', desc: '...', ... }
    }


    idmap = (opt) ->
      @names = opt.names or []
      @

    idmap.prototype = Object.create(Object.prototype) <<< do
      map: (c) ->
        Promise.resolve!
          .then ~> @_ext c
          .catch ~>
            if !c in @names => return Promise.reject(new Error! <<< {name: \lderror, id: 404})
            { ... }
      set-ext: -> @ext = it
    
    map = new idmap names: <[short-answer long-answer choice multiple-choice]>
