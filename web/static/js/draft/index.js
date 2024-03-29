var formHost, formBlock, formFile;
formHost = function(opt){
  var root;
  opt == null && (opt = {});
  this.opt = {
    domMode: 0
  };
  import$(this.opt, JSON.parse(JSON.stringify(opt)));
  root = opt.root;
  this.root = root = typeof root === 'string'
    ? document.querySelector(root)
    : root ? root : null;
  this.blocks = {};
  this.criteria = {};
  return this;
};
formHost.prototype = import$(Object.create(Object.prototype), {
  register: function(n, o){
    return this.blocks[n] = o;
  },
  listType: function(){
    var k, ref$, v, results$ = [];
    for (k in ref$ = this.criteria) {
      v = ref$[k];
      results$.push({
        name: v.name,
        key: v.key
      });
    }
    return results$;
  },
  listRule: function(type){
    var k, ref$, v, results$ = [];
    for (k in ref$ = this.criteria[type]) {
      v = ref$[k];
      results$.push({
        name: v.name,
        key: v.key
      });
    }
    return results$;
  },
  listBlockType: function(){
    var k, results$ = [];
    for (k in this.blocks) {
      results$.push(k);
    }
    return results$;
  },
  setRule: function(arg$){
    var name, key, rules;
    name = arg$.name, key = arg$.key, rules = arg$.rules;
    return this.criteria[type] = {
      name: name,
      key: key,
      rules: rules
    };
  },
  getRule: function(type, rule){
    var ref$, ref1$;
    return ((ref$ = (ref1$ = this.criteria)[type] || (ref1$[type] = {})).rules || (ref$.rules = {}))[rule] || function(){
      return false;
    };
  },
  feedback: function(node, value){
    console.log(node, value);
    return ld$.find(node, '.feedback', 0).innerText = value;
  },
  validate: function(value, criteria){
    var i$, len$, c, func, ret;
    criteria == null && (criteria = []);
    console.log(criteria);
    for (i$ = 0, len$ = criteria.length; i$ < len$; ++i$) {
      c = criteria[i$];
      func = this.getRule(c.type, c.rule);
      ret = func(value, c.cfg);
      console.log(func, ret);
      if (!ret) {
        return c;
      }
    }
    return null;
  },
  domWrapper: function(n, id){
    return "<div ld-form=\"" + id + "\" class=\"form-block\">\n" + n + "\n</div>";
  },
  prepare: function(o){
    var html, bs, this$ = this;
    html = "";
    bs = o.block.map(function(b, i){
      var n, obj, ret;
      n = ld$.find(this$.root, "[ld-form=" + b.id + "]", 0);
      obj = new this$.blocks[b.name]({
        root: n,
        cfg: b,
        host: this$
      });
      if (!this$.opt.domMode) {
        html += ret = this$.domWrapper(obj.dom(), b.id);
      }
      return obj;
    });
    if (!this.opt.domMode) {
      this.root.innerHTML = html;
    }
    return bs.map(function(b, i){
      var n;
      n = ld$.find(this$.root, "[ld-form=" + b.cfg.id + "]", 0);
      return b.setNode(n);
    });
  }
});
formBlock = function(opt){
  this.init(opt);
  return this;
};
formBlock.prototype = import$(Object.create(Object.prototype), {
  init: function(opt){
    this.opt = opt;
    this.cfg = opt.cfg;
    this.host = opt.host;
    if (this.opt.root) {
      return this.setNode(this.opt.root);
    }
  },
  setNode: function(r){
    var this$ = this;
    if (this.n) {
      this.n.removeEventListener('change', this._listener);
    }
    this.root = typeof r === 'string'
      ? document.querySelector(r)
      : r ? r : null;
    this.n = ld$.find(this.root.parentNode, 'input', 0);
    return this.n.addEventListener('change', this._listener = function(){
      return this$.validate(this$.n.files);
    });
  },
  validate: function(v){
    var ret;
    console.log("validating " + v);
    ret = this.host.validate(v, this.opt.cfg.criteria);
    if (ret) {
      this.host.feedback(this.root, 'invalid');
    }
    return console.log(ret);
  }
});
formFile = function(opt){
  this.init(opt);
  return this;
};
formFile.prototype = import$(Object.create(formBlock.prototype), {
  dom: function(){
    return "<input type=\"file\">";
  }
});
function import$(obj, src){
  var own = {}.hasOwnProperty;
  for (var key in src) if (own.call(src, key)) obj[key] = src[key];
  return obj;
}