var formBlock, formPkg, mgr;
formBlock = function(opt){
  var that, this$ = this;
  opt == null && (opt = {});
  this.root = typeof opt.root === 'string'
    ? document.querySelector(opt.root)
    : (that = opt.root) ? that : null;
  this.data = {};
  this.init = proxise.once(function(){
    return this$._init();
  });
  this.init();
  return this;
};
import$(formBlock.prototype, {
  _init: function(){
    var _, view, this$ = this;
    _ = this.data;
    return this.view = view = new ldView({
      root: this.root,
      action: {
        input: {
          title: function(arg$){
            var node;
            node = arg$.node;
            return _.title = node.value || '';
          },
          desc: function(arg$){
            var node;
            node = arg$.node;
            return _.desc = node.value || '';
          },
          value: function(arg$){
            var node;
            node = arg$.node;
            _.value = node.value;
            return _.criteria.map(function(){
              return form.term;
            });
          }
        },
        click: {
          "add-criteria": function(){
            _.criteria.push({});
            return this$.view.render('criteria');
          },
          'switch': function(arg$){
            var node, n;
            node = arg$.node;
            n = node.getAttribute('data-name');
            if (!(n === 'isPublic' || n === 'isRequired' || n === 'showDesc')) {
              return;
            }
            _[n] = !_[n];
            return view.render();
          }
        }
      },
      handler: {
        title: function(arg$){
          var node;
          node = arg$.node;
          return node.value = _.title || '';
        },
        desc: function(arg$){
          var node;
          node = arg$.node;
          return node.value = _.desc || '';
        },
        'switch': function(arg$){
          var node, n;
          node = arg$.node;
          n = node.getAttribute('data-name');
          if (!(n === 'isPublic' || n === 'isRequired' || n === 'showDesc')) {
            return;
          }
          return node.classList.toggle('on', !!_[n]);
        },
        attr: {
          list: function(){
            var k, v;
            return (function(){
              var ref$, results$ = [];
              for (k in ref$ = _.attr) {
                v = ref$[k];
                results$.push({
                  k: k,
                  v: v
                });
              }
              return results$;
            }()) || [];
          },
          handler: function(arg$){
            var node, data;
            node = arg$.node, data = arg$.data;
            node.setAttribute('value', data.k);
            return node.innerText = data.v.name;
          }
        },
        criteria: {
          list: function(){
            return _.criteria || [];
          },
          view: {
            action: {
              click: {
                enabled: function(arg$){
                  var context;
                  context = arg$.context;
                  context.enabled = !context.enabled;
                  return this$.view.render('criteria');
                },
                'delete': function(arg$){
                  var context;
                  context = arg$.context;
                  _.criteria.splice(_.criteria.indexOf(context), 1);
                  return this$.view.render('criteria');
                }
              },
              change: {
                attr: function(arg$){
                  var node, context;
                  node = arg$.node, context = arg$.context;
                  context.opset = _.attr[node.value].opset;
                  return view.render('criteria');
                },
                op: function(arg$){
                  var node, context;
                  node = arg$.node, context = arg$.context;
                  context.op = form.opset.get(context.opset || 'number').getOp(node.value);
                  return view.render('criteria');
                }
              }
            },
            handler: {
              enabled: function(arg$){
                var node, context;
                node = arg$.node, context = arg$.context;
                return node.classList.toggle('on', !!context.enabled);
              },
              "attr-option": {
                list: function(){
                  var k, v;
                  return (function(){
                    var ref$, results$ = [];
                    for (k in ref$ = _.attr) {
                      v = ref$[k];
                      results$.push({
                        k: k,
                        v: v
                      });
                    }
                    return results$;
                  }()) || [];
                },
                key: function(it){
                  return it.k;
                },
                handler: function(arg$){
                  var node, data;
                  node = arg$.node, data = arg$.data;
                  node.setAttribute('value', data.k);
                  return node.innerText = data.v.name;
                }
              },
              "op-option": {
                list: function(arg$){
                  var context, opset, k, ref$, v, results$ = [];
                  context = arg$.context;
                  opset = form.opset.get(context.opset || 'number');
                  for (k in ref$ = opset.ops) {
                    v = ref$[k];
                    results$.push(v);
                  }
                  return results$;
                },
                handler: function(arg$){
                  var node, data;
                  node = arg$.node, data = arg$.data;
                  node.setAttribute('value', data.id);
                  return node.innerText = data.name;
                }
              },
              "op-config": {
                list: function(arg$){
                  var context, k, ref$, v, results$ = [];
                  context = arg$.context;
                  for (k in ref$ = (context.op || (context.op = {})).config || {}) {
                    v = ref$[k];
                    results$.push({
                      k: k,
                      v: v
                    });
                  }
                  return results$;
                },
                key: function(it){
                  return it.k;
                },
                view: {
                  text: {
                    name: function(arg$){
                      var node, context;
                      node = arg$.node, context = arg$.context;
                      return context.k;
                    }
                  }
                }
              }
            }
          }
        }
      }
    });
  }
});
formPkg = {
  pkg: {
    name: "form",
    dependencies: []
  },
  init: function(){
    return console.log('pkg');
  }
};
/*
    new form-block root: document.body
    bc = new block.class do
      code: script: ->
        console.log \ok
        form-pkg
    bc.create!
  .then (bi) ->
    bi.attach root: document.body
*/
mgr = new block.manager({
  registry: function(arg$){
    var name, version;
    name = arg$.name, version = arg$.version;
    return "/block/" + name + "/" + version + "/index.html";
  }
});
mgr.init().then(function(){
  return mgr.get({
    name: "@plotdb/long-answer",
    version: "0.0.1"
  });
}).then(function(bc){
  return bc.create();
}).then(function(bi){
  return bi.attach({
    root: document.querySelector('#container')
  });
});
function import$(obj, src){
  var own = {}.hasOwnProperty;
  for (var key in src) if (own.call(src, key)) obj[key] = src[key];
  return obj;
}