 (function() { function pug_rethrow(e,n,r,t){if(!(e instanceof Error))throw e;if(!("undefined"==typeof window&&n||t))throw e.message+=" on line "+r,e;var o,a,i,s;try{t=t||require("fs").readFileSync(n,{encoding:"utf8"}),o=3,a=t.split("\n"),i=Math.max(r-o,0),s=Math.min(a.length,r+o)}catch(t){return e.message+=" - could not read from "+n+" ("+t.message+")",void pug_rethrow(e,null,r)}o=a.slice(i,s).map(function(e,n){var t=n+i+1;return(t==r?"  > ":"    ")+t+"| "+e}).join("\n"),e.path=n;try{e.message=(n||"Pug")+":"+r+"\n"+o+"\n\n"+e.message}catch(e){}throw e}function template(locals) {var pug_html = "", pug_mixins = {}, pug_interp;var pug_debug_filename, pug_debug_line;try {;pug_debug_line = 1;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fconfig\u002Fnumber\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv\u003E";
;pug_debug_line = 2;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fconfig\u002Fnumber\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv plug=\"config\"\u003E";
;pug_debug_line = 3;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fconfig\u002Fnumber\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cinput class=\"ldrs\" ld=\"ldrs\"\u002F\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 4;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fconfig\u002Fnumber\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv plug=\"ctrl\"\u003E";
;pug_debug_line = 4;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fconfig\u002Fnumber\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv ld=\"switch\"\u003E";
;pug_debug_line = 4;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fconfig\u002Fnumber\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "switch\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 5;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fconfig\u002Fnumber\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cstyle type=\"text\u002Fcss\"\u003E";
;pug_debug_line = 5;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fconfig\u002Fnumber\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "input {\n  width: 100%;\n}\n\u003C\u002Fstyle\u003E";
;pug_debug_line = 7;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fconfig\u002Fnumber\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cscript type=\"@plotdb\u002Fblock\"\u003E";
;pug_debug_line = 7;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fconfig\u002Fnumber\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "(function(it){\n  return it();\n})(function(){\n  var blockFactory;\n  blockFactory = {\n    pkg: {\n      name: 'config\u002Fnumber',\n      version: '0.0.1',\n      extend: {\n        name: 'config\u002Fbase',\n        version: '0.0.1'\n      },\n      dependencies: [\n        {\n          url: \"\u002Fassets\u002Flib\u002Fldslider\u002Fmain\u002Fldrs.css\",\n          type: 'css'\n        }, {\n          url: \"\u002Fassets\u002Flib\u002Fldslider\u002Fmain\u002Fldrs.js\",\n          async: false\n        }\n      ]\n    },\n    init: function(arg$){\n      var root, context, data, pubsub, ldview, ldrs, obj, view;\n      root = arg$.root, context = arg$.context, data = arg$.data, pubsub = arg$.pubsub;\n      ldview = context.ldview, ldrs = context.ldrs;\n      obj = {};\n      pubsub.fire('init', {\n        get: function(){\n          return obj.ldrs.get();\n        },\n        set: function(it){\n          return obj.ldrs.set(it);\n        },\n        data: data\n      });\n      return view = new ldview({\n        root: root,\n        action: {\n          click: {\n            'switch': function(){\n              return obj.ldrs.edit();\n            }\n          }\n        },\n        init: {\n          ldrs: function(arg$){\n            var node, ref$;\n            node = arg$.node;\n            obj.ldrs = new ldslider((ref$ = {\n              root: node\n            }, ref$.min = data.min, ref$.max = data.max, ref$.step = data.step, ref$.from = data.from, ref$.to = data.to, ref$.exp = data.exp, ref$.limitMax = data.limitMax, ref$.range = data.range, ref$.label = data.label, ref$.limitMax = data.limitMax, ref$));\n            return obj.ldrs.on('change', function(it){\n              return pubsub.fire('event', 'change', it);\n            });\n          }\n        }\n      });\n    }\n  };\n  return blockFactory;\n});\u003C\u002Fscript\u003E\u003C\u002Fdiv\u003E";} catch (err) {pug_rethrow(err, pug_debug_filename, pug_debug_line);};return pug_html;}; module.exports = template; })() 