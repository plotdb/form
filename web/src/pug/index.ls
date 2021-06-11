manager = new block.manager registry: ({name,version}) -> "/block/#name/#version/index.html"

/*
 use chainedbackend / resources
 - https://www.i18next.com/how-to/backend-fallback#browser-fallback-with-local-bundled-translations
 - https://www.i18next.com/overview/getting-started
*/

i18next
  .use i18nextChainedBackend
  .init do
    fallbackLng: \en
    resources:
      en:
        translation:
          "hi": "hello world"
    /*
    backend: backends: [
      i18nextResourcesToBackend {
        en: translations: hi: \hello
      }
    ]
    */
  .then ->
    console.log i18next.t('hi')
    manager.init!
  .then ->
    manager.get {name: "short-answer", version: "0.0.1"}
  .then -> it.create {data: {i18n: i18next, data: 'hello world'}}
  .then ->
    it.attach {root}
    obj = it.interface!

    view = new ldview do
      root: document
      action: click:
        serialize: -> console.log obj.serialize!
        mode: ({node}) -> obj.set-mode node.getAttribute \data-name
        set: ({node}) -> obj.value Math.random!
    obj.set-mode \view
    debounce 1000 .then ->
      obj.set-mode \edit
