<div>
<input id="input" type="file">
<div class="feedback">
</div>


field = do
  html: "..." <- customizable?
    - ( 因為這個牽涉到介面, 我們必須考慮讓他可以依照不同需求而客製. )
    - 也許可以提供一組預設值, 但讓他可以被我們 overwrite 掉.
    - 由於 block 眾多, 未被客製掉的 block 必須要在編輯時提供一個提示
    - 也就是說我們要有一個統一的客製管道, 才能有一個一致的提示管道.

  criteria: [
    ["filesize", "smaller", {a: 100}, "some feedback"]
  ]

  config: do


input.addEventListener \change, ->
  value = @files
  if !(valid.fileSize.smaller value, {a: 100}) => feedback.innerText = feedback


form-host
  customizer: (name) ->
    - 若有定義, 則由此取得各 field 的客製.
    - 必須要可以設定 "未客製時的行為".
  feedback-driver ( 如何驅使 feedback 被顯示 ) 
    - 這需要有一個明確的 dom structure. customizer 亦需配合 feedback-driver 來設定.

field

form-host
  criteria
  field
    criteria


block = (opt = {}) ->
  @opt = opt
  @html = """<input type="file">""" # 甚至要可以由用戶自己定義? 
  @

block.prototype = Object.create(Object.prototype) <<< do
  set-criteria: ->
  get-criteria: ->
  set-config: ->
  get-config: ->

# 這裡應該由 form-host 來處理, 我們主要是提供定義檔
b = new block!

