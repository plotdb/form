// Generated by LiveScript 1.6.0
(function(){
  var form;
  form = {};
  form.manager = function(o){
    var this$ = this;
    o == null && (o = {});
    this._ws = {
      w: {},
      p: new WeakMap(),
      s: {},
      l: {}
    };
    this._evthdr = {};
    this._status = 1;
    this._mode = 'edit';
    this.mod = {
      afterCheck: o.mod.afterCheck
    } || {};
    this.afterCheck = debounce(330, function(){
      var args, res$, i$, to$;
      res$ = [];
      for (i$ = 0, to$ = arguments.length; i$ < to$; ++i$) {
        res$.push(arguments[i$]);
      }
      args = res$;
      return this$._afterCheck.apply(this$, args);
    });
    this._checkDebounced = debounce(10, function(){
      var args, res$, i$, to$;
      res$ = [];
      for (i$ = 0, to$ = arguments.length; i$ < to$; ++i$) {
        res$.push(arguments[i$]);
      }
      args = res$;
      return this$._check.apply(this$, args);
    });
    return this;
  };
  form.manager.prototype = import$(Object.create(Object.prototype), {
    on: function(n, cb){
      var ref$;
      return ((ref$ = this._evthdr)[n] || (ref$[n] = [])).push(cb);
    },
    fire: function(n){
      var v, res$, i$, to$, ref$, len$, cb, results$ = [];
      res$ = [];
      for (i$ = 1, to$ = arguments.length; i$ < to$; ++i$) {
        res$.push(arguments[i$]);
      }
      v = res$;
      for (i$ = 0, len$ = (ref$ = this._evthdr[n] || []).length; i$ < len$; ++i$) {
        cb = ref$[i$];
        results$.push(cb.apply(this, v));
      }
      return results$;
    },
    add: function(o){
      var ref$, w, p, this$ = this;
      if (Array.isArray(o)) {
        return o.map(function(it){
          return this$.add(it);
        });
      }
      ref$ = [o.widget, o.path], w = ref$[0], p = ref$[1];
      if (this._ws.p.get(w)) {
        return;
      }
      this._ws.w[p] = w;
      this._ws.p.set(w, p);
      this._ws.l[p] = {};
      w.on('change', this._ws.l[p].c = function(v){
        this$.check({
          widget: w,
          path: p
        });
        return this$.fire('change', {
          widget: w,
          path: p,
          value: v
        });
      });
      return w.on('status', this._ws.l[p].s = function(s){
        return this$.check({
          widget: w,
          path: p
        });
      });
    },
    remove: function(o){
      var ws, ref$, key$, ref1$, this$ = this;
      if (Array.isArray(o)) {
        return o.map(function(it){
          return this$.remove(it);
        });
      }
      if (!(ws = this._ws.w[o.path])) {
        return;
      }
      o.off('change', this._ws.l[o.path].c);
      o.off('status', this._ws.l[o.path].s);
      this._ws.p['delete'](ws);
      delete this._ws.w[o.path];
      return ref1$ = (ref$ = this._ws.l)[key$ = o.path], delete ref$[key$], ref1$;
    },
    widget: function(p){
      return this._ws[p];
    },
    status: function(v){
      return !(v != null)
        ? this._status
        : this._status = v;
    },
    progress: function(){
      var ret, k, s;
      ret = {
        total: (function(){
          var results$ = [];
          for (k in this._ws.w) {
            results$.push(k);
          }
          return results$;
        }.call(this)).length,
        done: (function(){
          var ref$, results$ = [];
          for (k in ref$ = this._ws.s) {
            s = ref$[k];
            results$.push(s);
          }
          return results$;
        }.call(this)).filter(function(s){
          return s != null && s === 0;
        }).length
      };
      ret.percent = ret.done / ret.total;
      return ret;
    },
    _afterCheck: function(){
      var os, ret, k, v;
      os = this._status;
      delete this._status;
      this.mod.afterCheck.apply(this);
      if (!(this._status != null)) {
        ret = (function(){
          var ref$, results$ = [];
          for (k in ref$ = this._ws.w) {
            v = ref$[k];
            results$.push(this._ws.s[k]);
          }
          return results$;
        }.call(this)).filter(function(s){
          return !(s != null && s === 0);
        }).length;
        this._status = ret ? 1 : 0;
      }
      if (os !== this._status) {
        return this.fire('readystatechange', this._status === 0);
      }
    },
    check: function(o, now){
      var p, w;
      now == null && (now = false);
      if (!o) {
        return this.check((function(){
          var ref$, results$ = [];
          for (p in ref$ = this._ws.w) {
            w = ref$[p];
            results$.push({
              widget: w,
              path: p
            });
          }
          return results$;
        }.call(this)), now);
      }
      this.checkList = (this.checkList || (this.checkList = [])).concat(Array.isArray(o)
        ? o
        : [o]);
      return now
        ? this._check(null, true)
        : this._checkDebounced();
    },
    _check: function(o, now){
      var list, this$ = this;
      if (!o) {
        list = this.checkList || [];
        this.checkList = [];
        return this._check(list, now);
      }
      if (Array.isArray(o)) {
        return Promise.all(o.map(function(it){
          return this$._check(it, now);
        })).then(function(it){
          return it.filter(function(it){
            return it;
          });
        });
      }
      return new Promise(function(res, rej){
        var ref$, w, p, _now;
        ref$ = [o.widget, o.path, o.now], w = ref$[0], p = ref$[1], _now = ref$[2];
        if (!(w && p)) {
          return res();
        }
        if (!w && !(w = this$._ws.w[p])) {
          return res();
        }
        if (!p) {
          p = this$._ws.p[w];
        }
        return w.validate().then(function(){
          var os, promise;
          os = this$._ws.s[p];
          this$._ws.s[p] = w.status();
          promise = now || _now
            ? Promise.resolve(this$.afterCheck().now())
            : this$.afterCheck();
          return promise.then(function(){
            if (os !== this$._ws.s[p]) {
              this$.fire('status', {
                path: p,
                widget: w,
                status: this$._ws.s[p]
              });
            }
            return this$._ws.s[p];
          });
        }).then(function(){
          if (this$._ws.s[p] === 2) {
            return res({
              widget: w,
              path: p
            });
          } else {
            return res();
          }
        });
      });
    },
    formData: function(){
      var fd, p, ref$, w, val, i$, to$, i;
      fd = new FormData();
      for (p in ref$ = this._ws.w) {
        w = ref$[p];
        val = w.value();
        if (Array.isArray(v)) {
          for (i$ = 0, to$ = v.length; i$ < to$; ++i$) {
            i = i$;
            fd.append(p + "[]", v[i]);
          }
        } else {
          fd.append(p, val);
        }
      }
      return fd;
    },
    value: function(v){
      var ret, p, ref$, w, results$ = [];
      if (!v) {
        ret = {};
        for (p in ref$ = this._ws.w) {
          w = ref$[p];
          ret[p] = w.value();
        }
        return ret;
      }
      for (p in ref$ = this._ws.w) {
        w = ref$[p];
        results$.push(w.value(v[p]));
      }
      return results$;
    },
    mode: function(m){
      var ref$, p, w, results$ = [];
      if (!(m != null)) {
        return this._mode;
      }
      if (!(m === 'edit' || m === 'view' || m === 'config')) {
        throw ref$ = new Error(), ref$.name = 'lderror', ref$.id = 1015, ref$;
      }
      if (this._mode === m) {
        return;
      }
      this._mode = m;
      this.fire('mode', m);
      for (p in ref$ = this._ws.w) {
        w = ref$[p];
        results$.push(w.mode(m));
      }
      return results$;
    }
  });
  form.op = function(opt){
    opt == null && (opt = {});
    this.id = opt.id;
    this.name = opt.name;
    this.config = opt.config;
    this.func = opt.func;
    this.opset = opt.opset;
    return this;
  };
  form.op.prototype = import$(Object.create(Object.prototype), {
    validate: function(val, cfg){
      var ret;
      cfg == null && (cfg = {});
      if (this.opset.convert) {
        val = this.opset.convert(val);
      }
      if ((ret = this.func(val, cfg)) instanceof Promise) {
        return ret;
      } else {
        return Promise.resolve(!!ret);
      }
    },
    configDefault: function(){
      var cfg, k, ref$, v;
      cfg = {};
      for (k in ref$ = this.config) {
        v = ref$[k];
        cfg[k] = v['default'];
      }
      return cfg;
    }
  });
  form.opset = function(opt){
    var ops, k, v, this$ = this;
    opt == null && (opt = {});
    this.name = opt.name;
    this.id = opt.id;
    this.i18n = opt.i18n;
    this.convert = opt.convert;
    this.ops = {};
    ops = Array.isArray(opt.ops)
      ? opt.ops.map(function(it){
        return {
          v: it,
          k: it.id
        };
      })
      : (function(){
        var ref$, results$ = [];
        for (k in ref$ = opt.ops) {
          v = ref$[k];
          results$.push({
            k: k,
            v: v
          });
        }
        return results$;
      }());
    ops.map(function(arg$){
      var k, v, ref$, ref1$, results$ = [];
      k = arg$.k, v = arg$.v;
      this$.ops[k] = v instanceof form.op
        ? v
        : k
          ? new form.op((ref$ = typeof v === 'function' ? {
            func: v
          } : v, ref$.id = k, ref$.opset = this$, ref$))
          : (function(){
            throw new Error('[@plotdb/form/opset] invalid op when initializing opset.');
          }());
      for (k in ref$ = opt.ops) {
        v = ref$[k];
        results$.push(this$.ops[k] = new form.op((ref1$ = typeof v === 'function' ? {
          func: v
        } : v, ref1$.name = k, ref1$.id = k, ref1$.opset = this$, ref1$)));
      }
      return results$;
    });
    this.defaultOp = this.ops[opt.defaultOp]
      ? opt.defaultOp
      : (function(){
        var ref$, results$ = [];
        for (k in ref$ = this.ops) {
          v = ref$[k];
          results$.push(k);
        }
        return results$;
      }.call(this))[0];
    return this;
  };
  form.opset.prototype = import$(Object.create(Object.prototype), {
    getOp: function(id){
      return this.ops[id || this.defaultOp];
    },
    getOps: function(){
      var k, ref$, v, results$ = [];
      for (k in ref$ = this.ops) {
        v = ref$[k];
        results$.push(v);
      }
      return results$;
    }
  });
  form.opset.register = function(it){
    return (this.list || (this.list = [])).push(it instanceof form.opset
      ? it
      : new form.opset(it));
  };
  form.opset.get = function(id){
    return (this.list || (this.list = [])).filter(function(it){
      return (it.id || it.name) === id;
    })[0];
  };
  form.opset['default'] = [
    {
      id: 'string',
      i18n: {
        "zh-TW": {
          string: "文字",
          include: "包含",
          exclude: "排除",
          email: "電子郵件"
        }
      },
      ops: {
        include: {
          func: function(v, c){
            c == null && (c = {});
            return ~("" + (v || '')).indexOf(c.str || '');
          },
          config: {
            str: {
              type: 'text'
            }
          }
        },
        exclude: {
          func: function(v, c){
            c == null && (c = {});
            return !~("" + (v || '')).indexOf(c.str || '');
          },
          config: {
            str: {
              type: 'text'
            }
          }
        },
        email: {
          func: function(v){
            return /^[^@]+@[^@]+$/.exec(v);
          },
          config: {}
        }
      }
    }, {
      id: 'length',
      i18n: {
        "zh-TW": {
          length: "長度",
          lte: "≦ 小於或等於",
          number: "數字",
          "maximal length": "長度上限"
        }
      },
      ops: {
        lte: {
          func: function(v, c){
            c == null && (c = {});
            return (v + "").length <= +c.val;
          },
          config: {
            val: {
              type: 'number',
              hint: "maximal length"
            }
          }
        }
      }
    }, {
      id: 'number',
      i18n: {
        "zh-TW": {
          number: "數字",
          lte: "≦ 小於或等於",
          gte: "≧ 大於或等於",
          ne: "≠ 不等於",
          eq: "= 等於",
          is: "任何數字"
        }
      },
      convert: function(v){
        return +(v + "").replace(/,/g, '');
      },
      ops: {
        lte: {
          func: function(v, c){
            c == null && (c = {});
            if (isNaN(v) || isNaN(c.val)) {
              return false;
            } else {
              return +v <= +c.val;
            }
          },
          config: {
            val: {
              type: 'text',
              hint: "number for comparison"
            }
          }
        },
        gte: {
          func: function(v, c){
            c == null && (c = {});
            if (isNaN(v) || isNaN(c.val)) {
              return false;
            } else {
              return +v >= +c.val;
            }
          },
          config: {
            val: {
              type: 'text',
              hint: "number for comparison"
            }
          }
        },
        ne: {
          func: function(v, c){
            c == null && (c = {});
            if (isNaN(v) || isNaN(c.val)) {
              return false;
            } else {
              return +v !== +c.val;
            }
          },
          config: {
            val: {
              type: 'text',
              hint: "number for comparison"
            }
          }
        },
        eq: {
          func: function(v, c){
            c == null && (c = {});
            if (isNaN(v) || isNaN(c.val)) {
              return false;
            } else {
              return +v === +c.val;
            }
          },
          config: {
            val: {
              type: 'text',
              hint: "number for comparison"
            }
          }
        },
        is: {
          func: function(v){
            return !isNaN(v);
          },
          config: {}
        }
      }
    }
  ];
  form.opset['default'].map(function(it){
    return form.opset.register(it);
  });
  /**
   * term, for verification of values based on assigned op and config.
   * @constructor
   * @param {boolean} enabled - determine if this term is enabled or not
   * @param {string} opset - id of opset used by this term.
   * @param {string} op - id of op used by this term
   * @param {object} config - additional config for chosen op.
   */
  form.term = function(opt){
    opt == null && (opt = {});
    import$((this.enabled = true, this.opset = null, this.op = null, this.config = {}, this), opt);
    this.setOpset(opt.opset, opt.op, opt.config);
    return this;
  };
  form.term.prototype = import$(Object.create(Object.prototype), {
    toggle: function(it){
      return this.enabled = it != null
        ? it
        : !this.enabled;
    },
    setOpset: function(opset, op, cfg){
      if (typeof opset === 'string') {
        if (!(this.opset = form.opset.get(opset))) {
          throw new Error("no such opset '" + opset + "'");
        }
      } else if (opset instanceof form.opset) {
        this.opset = opset;
      } else {
        throw new Error("invalid opset");
      }
      return this.setOp(op, cfg);
    },
    setOp: function(id, cfg){
      if (!this.opset) {
        throw new Error("opset not set");
      }
      if (!(this.op = this.opset.getOp(id))) {
        throw new Error("no such op '" + id + "'");
      }
      return this.setConfig(cfg);
    },
    setConfig: function(cfg){
      if (!this.op) {
        throw new Error("op not set");
      }
      return this.config = !cfg ? this.op.configDefault() : cfg;
    },
    validate: function(v){
      if (!this.op) {
        Promis.reject(new Error("op not set"));
      }
      return this.op.validate(v, this.config);
    },
    serialize: function(){
      return {
        enabled: this.enabled,
        opset: this.opset.id,
        op: this.op.id,
        config: this.config
      };
    },
    deserialize: function(v){
      this.toggle(v.enabled);
      return this.setOpset(v.opset, v.op, v.config);
    }
  });
  form.widget = function(opt){
    var this$ = this;
    opt == null && (opt = {});
    this._root = typeof opt.root === 'string'
      ? document.querySelector(opt.root)
      : opt.root;
    this.evtHandler = {};
    this.mod = opt.mod || null;
    this.i18n = {};
    this._custom = {};
    this._status = 1;
    this._meta = {
      config: {},
      key: Math.random().toString(36).substring(2)
    };
    this._value = null;
    this._empty = true;
    this._mode = opt.mode || 'edit';
    this._validate = opt.validate || null;
    this._opsets = (opt.opsets || []).map(function(opset){
      if (typeof opset === 'string') {
        return form.opset.get(opset);
      } else if (typeof opset === form.opset) {
        return opset;
      } else {
        return new form.opset(opset);
      }
    });
    this._opsets.filter(function(it){
      return it.i18n;
    }).map(function(it){
      var k, ref$, v, ref1$, results$ = [];
      for (k in ref$ = it.i18n) {
        v = ref$[k];
        results$.push(import$((ref1$ = this$.i18n)[k] || (ref1$[k] = {}), v));
      }
      return results$;
    });
    this._errors = [];
    this.init = proxise.once(function(){
      return this$._init();
    });
    return this;
  };
  form.widget.prototype = import$(Object.create(Object.prototype), {
    on: function(n, cb){
      var this$ = this;
      return (Array.isArray(n)
        ? n
        : [n]).map(function(n){
        var ref$;
        return ((ref$ = this$.evtHandler)[n] || (ref$[n] = [])).push(cb);
      });
    },
    off: function(n, cb){
      var this$ = this;
      return (Array.isArray(n)
        ? n
        : [n]).map(function(n){
        var l, ref$;
        l = (ref$ = this$.evtHandler)[n] || (ref$[n] = []);
        if (l.indexOf(cb) >= 0) {
          return l.splice(l.indexOf(cb), 1);
        }
      });
    },
    fire: function(n){
      var v, res$, i$, to$, ref$, len$, cb, results$ = [];
      res$ = [];
      for (i$ = 1, to$ = arguments.length; i$ < to$; ++i$) {
        res$.push(arguments[i$]);
      }
      v = res$;
      for (i$ = 0, len$ = (ref$ = this.evtHandler[n] || []).length; i$ < len$; ++i$) {
        cb = ref$[i$];
        results$.push(cb.apply(this, v));
      }
      return results$;
    },
    root: function(){
      return this._root;
    },
    _init: function(){
      return Promise.resolve(this.mod && this.mod.init ? this.mod.init.apply(this) : '');
    },
    key: function(keyonly){
      keyonly == null && (keyonly = false);
      return keyonly
        ? this._meta.key
        : this._meta.alias || this._meta.key;
    },
    status: function(v){
      var ov;
      if (!(v != null)) {
        return this._status;
      }
      ov = this._status;
      this._status = v;
      if (ov !== v) {
        return this.fire('status', v);
      }
    },
    serialize: function(){
      var ref$, ret, ref1$;
      ret = (ref1$ = {}, ref1$.key = (ref$ = this._meta).key, ref1$.title = ref$.title, ref1$.desc = ref$.desc, ref1$);
      ret.config = JSON.parse(JSON.stringify(this._meta.config || {}));
      ret.term = this._meta.term.map(function(it){
        return it.serialize();
      });
      return ret;
    },
    deserialize: function(v){
      var ref$;
      ref$ = this._meta;
      ref$.key = v.key;
      ref$.title = v.title;
      ref$.desc = v.desc;
      this._meta.config = JSON.parse(JSON.stringify(v.config || {}));
      this._meta.term = (v.term || []).map(function(it){
        return new form.term(it);
      });
      this.validate({
        init: true
      });
      return this.render();
    },
    mode: function(m){
      var ref$;
      if (!(m != null)) {
        return this._mode;
      }
      if (!(m === 'edit' || m === 'view' || m === 'config')) {
        throw ref$ = new Error(), ref$.name = 'lderror', ref$.id = 1015, ref$;
      }
      if (this._mode === m) {
        return;
      }
      this._mode = m;
      this.fire('mode', m);
      this.validate({
        init: true
      });
      return this.render();
    },
    errors: function(){
      return this._errors;
    },
    value: function(v, fromSource){
      fromSource == null && (fromSource = false);
      if (!(v != null)) {
        return this._value;
      }
      this._value = v;
      this._empty = this.mod && this.mod.isEmpty
        ? this.mod.isEmpty.apply(this, v)
        : !v;
      this.validate();
      if (!fromSource) {
        return this.fire('change', this._value);
      }
    },
    validate: function(opt){
      var this$ = this;
      opt == null && (opt = {});
      if (this.mod && this.mod.validate) {
        return this.mod.validate.apply(this, this._value);
      }
      if (this._validate) {
        return Promise.resolve(this._validate(this._value));
      }
      if (this._empty && this._meta.config.isRequired) {
        this._errors = ["required"];
        this.status(opt.init && this.status() === 1 ? 1 : 2);
        return this.render();
      }
      return Promise.all(this._meta.term.filter(function(t){
        return t.enabled;
      }).map(function(t){
        return t.validate(this$._value).then(function(v){
          return [t, v];
        });
      })).then(function(it){
        this$._errors = it.filter(function(it){
          return !it[1];
        }).map(function(it){
          return it[0].msg || 'error';
        });
        this$.status(this$._errors.length ? 2 : 0);
        return this$.render();
      }).then(function(){
        return this$._errors;
      });
    },
    render: function(){
      this.fire('render');
      if (this.mod && this.mod.render) {
        return this.mod.render.apply(this);
      }
    },
    adapt: function(){
      var args, res$, i$, to$;
      res$ = [];
      for (i$ = 0, to$ = arguments.length; i$ < to$; ++i$) {
        res$.push(arguments[i$]);
      }
      args = res$;
      if (this.mod && this.mod.adapt) {
        return this.mod.adapt.apply(this, args);
      }
    }
  });
  if (typeof module != 'undefined' && module !== null) {
    module.exports = form;
  } else if (typeof window != 'undefined' && window !== null) {
    window.form = form;
  }
  function import$(obj, src){
    var own = {}.hasOwnProperty;
    for (var key in src) if (own.call(src, key)) obj[key] = src[key];
    return obj;
  }
}).call(this);
