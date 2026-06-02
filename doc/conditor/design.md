condctrl 必須重新設計. 現有 conditions 做為 legacy 方法, 持續支援, 保持向下相容.
目前 production 上只有 @makeform/nest/src/condctrl.ls 有在用, @plotdb/form 的可以放棄沒關係.

condctrl 的概念: 當 when 時, 做 effect.

when: 我們稱之為 cond 物件, 可以是:
 - function: 當 func() Promise resolve true 時 ( 有 Promise, 所以 effect 需要 debounce )
 - 其它: 需要處理邏輯合併, 如 (a and (b or c)) or d; 條件判段可以使用 term 機制. 會是如下:
   - array: 等價於 logic and 所有成員的 cond 物件. 每個成員都是一個 cond 物件 (recursive defined).
     - [a, b, c ... ] == {logic: "and", cond: [a, b, c, ...]}
   - object: 有兩種, 
     1. 帶 logic 欄位: 依指定 logic 運算 cond 成員. 有以下欄位
       - `logic`: 可以是 and, or, xor, not
       - `cond`: cond 物件. (recursive defined)
     2. 未帶 logic 欄位: 依指定欄位得出結果. 有以下欄位: (TBD)
       - src: (TBD) 指涉特定 widget, 或一群 widget. 指涉細節待定 (若決定可指涉多個, 則要有 op 決定是 any or every)
         - src 以 consume 型式找查. 由 root mgr 開始, 若還沒耗完, 就交給下一層找到的 widget (的 mgr?)
           - 這個方式可以讓 src 定義很自由: 但問題會變成, 怎麼實作這個 ui. 會需要可以選
         - effect 可能也會需要有這個機制
       - term: list of term. term 邏輯為 and (類似 widget 內 term)
       - func(): function, 依執行 resolve 結果判斷
       - src 可以是 cond id, 直接取用其值
     3. 可帶 id, name, id 方便指涉重用, name ( 使用lngctx 或字串 ) 方便讀. 通常只用在最外層

effect: 當 when 成立, 我們要做什麼？
 - 對象
   - 某些 widget 上某些狀態
   - 可指涉 tag
   - 可對虛擬 id 設定狀態 ( 舊 condctrl 的 precond 做法 )
   - 虛擬 id 可以用來影響一般標籤 ( 影響到 form 之外, 對整個 DOM )
 - 行為
   - 目前最常用的: enabled / is-required / readonly 狀態的調整
   - 但: 也可以改其它值？比方說 1200 改 1500, 選項少一個，選項部份微調？
     - meta 可以有 preset, 也許可以用 named preset 來處理. 這樣, 我可以設定 effect: des: 'id', preset: 'name' 即可.
       - preset 的概念, 亦會涉及到 richtext 編輯. 會需要明顯提醒, 不然會很複雜.

