驗證數值的方法.

針對資料型態 ( type ), 提供簡易判斷式 ( rule )
多重驗證

criteria: [
  * type: \number, rule: \eg, value: 1  ( 數值等於 1 )
]

value 可能有多組. rule 可能複雜, 而且依 type 不同.
type 又不一定.

這邊的想像比較適合像這樣:

v = block.get(type)
func = eg(value)
result = func(v) (0: ok, 1: pending, 2: fail)


block 必須

我們提供預設的 type, rule, value 組
block 可以延伸定義.
block 表列支援的 type. 針對 type 回傳指定的數值供比較.
