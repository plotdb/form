/*
blockbase object
 - `title`
 - `desc`
 - `isPublic`
 - `isRequired`
 - `showDesc`
blockbase.prototype
 - serialize
 - deserialize
*/
var lform;
lform = function(){
  this.title = 'untitled';
  this.desc = 'no description...';
  this.isPublic = true;
  this.isRequired = true;
  this.showDesc = true;
  this.criteria = [{}];
  this.attr = {
    length: {
      name: "length",
      opset: 'count'
    },
    string: {
      name: "string",
      opset: 'string'
    },
    number: {
      name: "number",
      opset: 'number'
    }
  };
  this.init();
  return this;
};
lform.prototype = import$(Object.create(Object.prototype), {
  serialize: function(){
    var ret;
    return ret = {
      title: this.title,
      desc: this.desc,
      isPublic: this.isPublic,
      isRequired: this.isRequired,
      showDesc: this.showDesc,
      criteria: this.criteria
    };
  },
  deserialize: function(obj){
    var ref$;
    return this.title = (ref$ = obj.data || (obj.data = {})).title, this.desc = ref$.desc, this.isPublic = ref$.isPublic, this.isRequired = ref$.isRequired, this.showDesc = ref$.showDesc, this.criteria = ref$.criteria, this;
  },
  init: function(){
    var view, this$ = this;
    return this.view = view = new ldView({
      root: document.body,
      action: {
        input: {
          title: function(arg$){
            var node;
            node = arg$.node;
            return this$.title = node.value || '';
          },
          desc: function(arg$){
            var node;
            node = arg$.node;
            return this$.desc = node.value || '';
          },
          value: function(arg$){
            var node;
            node = arg$.node;
            this.value = node.value;
            return this.criteria.map(function(){
              return form.term;
            });
          }
        },
        click: {
          "add-criteria": function(){
            this$.criteria.push({});
            return this$.view.render('criteria');
          },
          'switch': function(arg$){
            var node, n;
            node = arg$.node;
            n = node.getAttribute('data-name');
            if (!(n === 'isPublic' || n === 'isRequired' || n === 'showDesc')) {
              return;
            }
            this$[n] = !this$[n];
            return view.render();
          }
        }
      },
      handler: {
        title: function(arg$){
          var node;
          node = arg$.node;
          return node.value = this$.title;
        },
        desc: function(arg$){
          var node;
          node = arg$.node;
          return node.value = this$.desc;
        },
        'switch': function(arg$){
          var node, n;
          node = arg$.node;
          n = node.getAttribute('data-name');
          if (!(n === 'isPublic' || n === 'isRequired' || n === 'showDesc')) {
            return;
          }
          return node.classList.toggle('on', !!this$[n]);
        },
        attr: {
          list: function(){
            var k, v;
            return (function(){
              var ref$, results$ = [];
              for (k in ref$ = this.attr) {
                v = ref$[k];
                results$.push({
                  k: k,
                  v: v
                });
              }
              return results$;
            }.call(this$)) || [];
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
            return this$.criteria || [];
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
                  this$.criteria.splice(this$.criteria.indexOf(context), 1);
                  return this$.view.render('criteria');
                }
              },
              change: {
                attr: function(arg$){
                  var node, context;
                  node = arg$.node, context = arg$.context;
                  context.opset = this$.attr[node.value].opset;
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
                    for (k in ref$ = this.attr) {
                      v = ref$[k];
                      results$.push({
                        k: k,
                        v: v
                      });
                    }
                    return results$;
                  }.call(this$)) || [];
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
new lform();
function import$(obj, src){
  var own = {}.hasOwnProperty;
  for (var key in src) if (own.call(src, key)) obj[key] = src[key];
  return obj;
}