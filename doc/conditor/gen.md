# conditor 設計筆記

## 背景

取代 `@makeform/nest` 的 `condctrl`，實作於 `@plotdb/form`。
現有 `condctrl` 保留以維持向下相容，未來依不同欄位定義決定使用哪套機制驅動。

---

## when（cond 物件）

條件定義，recursive 結構：

- **function**：`func()` 回傳 Promise resolving to boolean
- **array**：等價於 AND 所有成員，即 `{logic: "and", cond: [...]}`
- **object（帶 logic）**：
  - `logic`：`and` / `or` / `xor` / `not`
  - `cond`：cond 物件（recursive）
- **object（不帶 logic）**：依指定欄位求值
  - `src`：指涉特定 widget，以 path 形式表示（見下方 path traversal）；亦可為另一個 cond 的 id，此時取其 boolean 結果
  - `term`：list of term，AND 邏輯（同 widget 內 term，已為 promise-based）
  - `func()`：function，async
  - 可帶 `id` / `name`（name 支援 i18n）

所有 evaluate 路徑統一走 async（Promise），最外層 debounce 一次。

---

## effect

當 when 成立時要做什麼：

- **對象**：widget（by path / tag / virtual id）、或 form 外部 DOM（透過 virtual id）
- **行為**：
  - `enabled` / `is-required` / `readonly` 狀態調整
  - named preset：切換至預先定義的 meta 配置（preset 涉及 visual editor 的編輯體驗問題，列為未來難題）

---

## Path Traversal API

`resolve` 與 `paths` 兩個 API 同時實作於 **manager** 與 **widget**：

### `resolve(path)` → `Array<widget>`

Runtime traversal。消耗 path，回傳所有匹配的 widget（可 fan-out）。

```
manager.resolve(["member", "email"])
  → 找到 member widget
  → widget.resolve(["email"])        ← nest 自己處理
      → fan-out 所有 entry 的 mgr
      → 每個 entry mgr.resolve(["email"])
          → 回傳 email widget
```

- `widget.resolve(path)` 預設回傳 `[]`（非 container widget）
- nest list mode 中，`["member", "email"]` 預設 fan-out 至所有 entry
- 保留 `["member", 0, "email"]` 擴充性（數字 segment = 指定 entry index）
- widget 已有 `manager()` API，`resolve` 只需回傳 `Array<widget>`，不需附帶 mgr

### `paths(path)` → `Array<{id, name}>`

Design-time 用，給 form builder UI 做 autocomplete。回傳給定 path 後下一段的可選項，含 id 與 i18n name。

```
manager.paths([])                → [{id:"contact",...}, {id:"member",...}, ...]
manager.paths(["member"])        → [{id:"*",...}, {id:0,...}, {id:1,...}, ...]
manager.paths(["member", 0])     → [{id:"name",...}, {id:"email",...}, ...]
```

- 兩邊（manager / widget）預設皆回傳 `[]`
- nest 依 fields schema 決定回傳內容，與當下資料無關
