var _;
_ = function(){
  var fh, formDef, view;
  this.data = {};
  this.fh = fh = new formHost({
    root: ld$.find('#root', 0),
    domMode: 2
  });
  fh.register("form-file", formFile);
  formDef = {
    block: [{
      name: "form-file",
      id: 'file',
      criteria: [{
        type: 'number',
        rule: 'gte',
        cfg: {
          a: 1
        }
      }]
    }]
  };
  fh.prepare(formDef);
  console.log('done.');
  view = {};
  view.criteria = {
    action: {
      click: {
        'delete': function(arg$){
          var node, context, idx;
          node = arg$.node, context = arg$.context;
          idx = context.context.data.criteria.indexOf(context.data);
          if (~idx) {
            context.context.data.criteria.splice(idx, 1);
          }
          return context.context.local.view.render();
        }
      },
      input: {
        input: function(arg$){
          var node, context, n;
          node = arg$.node, context = arg$.context;
          n = node.getAttribute('name');
          return context.data[n] = node.value;
        }
      }
    }
  };
  view.block = {
    action: {
      click: {
        "add-criteria": function(arg$){
          var context;
          context = arg$.context;
          context.data.criteria.push({});
          return context.local.view.render();
        }
      },
      change: {
        check: function(arg$){
          var node, context, n, ref$;
          node = arg$.node, context = arg$.context;
          n = node.getAttribute('name');
          return ((ref$ = context.data).config || (ref$.config = {}))[n] = node.checked;
        }
      },
      input: {
        input: function(arg$){
          var node, context, n;
          node = arg$.node, context = arg$.context;
          n = node.getAttribute('name');
          return context.data[n] = node.value;
        }
      }
    },
    init: {
      check: function(arg$){
        var node, id;
        node = arg$.node;
        node.setAttribute('id', id = Math.random().toString(36).substring(2));
        return node.nextSibling.setAttribute('for', id);
      }
    },
    handler: {
      criteria: {
        list: function(arg$){
          var context;
          context = arg$.context;
          return context.data.criteria;
        },
        init: function(opt){
          var context, node, data, local, ref$;
          context = opt.context, node = opt.node, data = opt.data, local = opt.local;
          local.context = opt;
          return local.view = new ldView((ref$ = view.criteria, ref$.root = node, ref$.context = opt, ref$));
        },
        handler: function(arg$){
          var context, node, data, local, ref$;
          context = arg$.context, node = arg$.node, data = arg$.data, local = arg$.local;
          local.view.setContext((ref$ = import$({}, local.context), ref$.context = context, ref$.data = data, ref$));
          return local.view.render();
        }
      }
    }
  };
  view.root = new ldView({
    root: '[ld-scope=ui]',
    action: {
      click: {
        "new-block": function(){
          formDef.block.push({
            name: "form-file",
            key: Math.random().toString(36).substring(2),
            criteria: []
          });
          return view.root.render();
        },
        "render": function(){
          return output.innerText = JSON.stringify(formDef);
        }
      }
    },
    handler: {
      bok: {
        key: function(it){
          return it.key;
        },
        list: function(){
          return formDef.block;
        },
        init: function(opt){
          var node, local, ref$;
          node = opt.node, local = opt.local;
          local.context = opt;
          return local.view = new ldView((ref$ = view.block, ref$.root = node, ref$.context = opt, ref$));
        },
        handler: function(arg$){
          var node, local, data, ref$;
          node = arg$.node, local = arg$.local, data = arg$.data;
          local.view.setContext((ref$ = import$({}, local.context), ref$.data = data, ref$));
          return local.view.render();
        }
      }
    }
  });
  return this;
};
new _();
function import$(obj, src){
  var own = {}.hasOwnProperty;
  for (var key in src) if (own.call(src, key)) obj[key] = src[key];
  return obj;
}