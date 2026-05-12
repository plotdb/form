module.exports =
  pkg: extend: name: \@makeform/nest, dom: \overwrite
  init: ({pubsub}) ->
    conditions = [
    * src: \category, config:
        values: <[互動體驗 行動應用]>
        targets: [\features]
        enabled: true
    ]

    fields =
      \work-title :
        type: \@makeform/input
        meta:
          title: "作品名稱"
          is-required: true
          config: placeholder: "請輸入作品名稱"
      year:
        type: \@makeform/datetime
        meta:
          title: "完成年份"
          is-required: true
      category:
        type: \@makeform/radio
        meta:
          title: "參賽類別"
          is-required: true
          config:
            values: <[數位影音 互動體驗 數位出版 行動應用 其他]>
            layout: \inline
      brief:
        type: \@makeform/textarea
        meta:
          title: "作品簡介"
          is-required: true
          desc: "請以 200 字以內說明作品內容"
          config:
            placeholder: "簡要描述作品的主題、形式與特色..."
            hint: enabled: true
          term: [{opset: \length, op: \lte, config: val: 200}]
      concept:
        type: \@makeform/richtext
        meta:
          title: "創作理念"
          is-required: true
          desc: "說明此作品的創作動機、理念與目標受眾"
      features:
        type: \@makeform/textarea
        meta:
          title: "技術特色"
          is-required: false
          desc: "說明作品採用的技術方案、互動設計或創新功能（限互動體驗、行動應用類別填寫）"
          config: placeholder: "請描述作品的技術亮點..."
      url:
        type: \@makeform/input
        meta:
          title: "作品網址"
          is-required: false
          desc: "可填入線上展示連結、試玩網址或影片連結"
          config:
            placeholder: "https://"
            as-link: true
          term: [{opset: \string, op: \url}]
      cover:
        type: \@makeform/image
        meta:
          title: "作品封面／截圖"
          is-required: true
          desc: "請上傳一張代表作品的圖片（建議尺寸 1200×675，JPG 或 PNG）"
          config:
            crop:
              enabled: true
              width: 1200
              height: 675
      attachment:
        type: \@makeform/upload
        meta:
          title: "其他附件"
          is-required: false
          desc: "可附上作品簡報、說明文件或補充資料（PDF，最大 20MB）"
      agreement:
        type: \@makeform/agreement
        meta:
          title: "參賽同意聲明"
          is-required: true
          config:
            value: "本人已詳閱並同意「數位內容創新獎」參賽規則，確認所提交之作品為原創，且未侵犯任何第三方之智慧財產權，並授權主辦單位於活動推廣使用。"

    pubsub.fire \@makeform/nest:init, {mode: \object, view: {}, fields, conditions}
