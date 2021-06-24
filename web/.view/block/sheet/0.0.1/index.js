 (function() { function pug_attr(t,e,n,r){if(!1===e||null==e||!e&&("class"===t||"style"===t))return"";if(!0===e)return" "+(r?t:t+'="'+t+'"');var f=typeof e;return"object"!==f&&"function"!==f||"function"!=typeof e.toJSON||(e=e.toJSON()),"string"==typeof e||(e=JSON.stringify(e),n||-1===e.indexOf('"'))?(n&&(e=pug_escape(e))," "+t+'="'+e+'"'):" "+t+"='"+e.replace(/'/g,"&#39;")+"'"}
function pug_escape(e){var a=""+e,t=pug_match_html.exec(a);if(!t)return e;var r,c,n,s="";for(r=t.index,c=0;r<a.length;r++){switch(a.charCodeAt(r)){case 34:n="&quot;";break;case 38:n="&amp;";break;case 60:n="&lt;";break;case 62:n="&gt;";break;default:continue}c!==r&&(s+=a.substring(c,r)),c=r+1,s+=n}return c!==r?s+a.substring(c,r):s}
var pug_match_html=/["&<>]/;
function pug_rethrow(e,n,r,t){if(!(e instanceof Error))throw e;if(!("undefined"==typeof window&&n||t))throw e.message+=" on line "+r,e;var o,a,i,s;try{t=t||require("fs").readFileSync(n,{encoding:"utf8"}),o=3,a=t.split("\n"),i=Math.max(r-o,0),s=Math.min(a.length,r+o)}catch(t){return e.message+=" - could not read from "+n+" ("+t.message+")",void pug_rethrow(e,null,r)}o=a.slice(i,s).map(function(e,n){var t=n+i+1;return(t==r?"  > ":"    ")+t+"| "+e}).join("\n"),e.path=n;try{e.message=(n||"Pug")+":"+r+"\n"+o+"\n\n"+e.message}catch(e){}throw e}function template(locals) {var pug_html = "", pug_mixins = {}, pug_interp;var pug_debug_filename, pug_debug_line;try {;pug_debug_line = 1;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fsheet\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv\u003E";
;pug_debug_line = 2;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fsheet\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv" + (" class=\"form-sheet\""+pug_attr("ld-scope", true, true, false)+" plug=\"view\"") + "\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 3;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fsheet\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cscript type=\"@plotdb\u002Fblock\"\u003E";
;pug_debug_line = 3;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fsheet\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "({\n  pkg: {\n    name: \"sheet\",\n    version: \"0.0.1\",\n    extend: {\n      name: \"base\",\n      version: \"0.0.1\"\n    },\n    license: \"MIT\",\n    description: \"\",\n    dependencies: [\n      {\n        url: \"\u002Fassets\u002Flib\u002F@plotdb\u002Fsheet\u002Fmain\u002Findex.min.css\"\n      }, {\n        url: \"\u002Fassets\u002Flib\u002F@plotdb\u002Fsheet\u002Fmain\u002Findex.min.js\"\n      }\n    ],\n    i18n: {\n      en: {\n        rowCount: \"row count\",\n        colCount: \"column count\"\n      },\n      \"zh-TW\": {\n        sheet: \"試算表\",\n        rowCount: \"列數\",\n        colCount: \"行數\"\n      }\n    }\n  },\n  init: function(arg$){\n    var root, parent, context, pubsub, form, sheet, node, s;\n    root = arg$.root, parent = arg$.parent, context = arg$.context, pubsub = arg$.pubsub;\n    form = context.form, sheet = context.sheet;\n    pubsub.on('change', function(){});\n    pubsub.on('update', function(){});\n    node = parent.node();\n    s = new sheet({\n      root: node\n    });\n    s.on('update', function(){\n      return parent.value(s.data, false, true);\n    });\n    return parent.opsets.push(new form.opset({\n      id: 'sheet',\n      ops: {\n        rowCount: {\n          func: function(v, c){\n            var max, i$, to$, i;\n            v == null && (v = []);\n            c == null && (c = {});\n            if (!Array.isArray(v) || isNaN(c.min) || isNaN(c.max)) {\n              return false;\n            }\n            max = 0;\n            for (i$ = 0, to$ = v.length; i$ \u003C to$; ++i$) {\n              i = i$;\n              if (Array.isArray(v[i]) && v[i].length && v[i].filter(fn$).length) {\n                max = i + 1;\n              }\n            }\n            return max \u003E= +c.min && max \u003C= +c.max;\n            function fn$(it){\n              return it != null && it !== \"\";\n            }\n          },\n          config: {\n            min: {\n              type: 'text',\n              name: \"min\",\n              hint: \"minimal value\"\n            },\n            max: {\n              type: 'text',\n              name: \"max\",\n              hint: \"maximal value\"\n            }\n          }\n        },\n        colCount: {\n          func: function(v, c){\n            var matched, i$, to$, i, u, max, j$, to1$, j;\n            v == null && (v = []);\n            c == null && (c = {});\n            if (!Array.isArray(v) || isNaN(c.min) || isNaN(c.max)) {\n              return false;\n            }\n            matched = false;\n            for (i$ = 0, to$ = v.length; i$ \u003C to$; ++i$) {\n              i = i$;\n              u = v[i] || [];\n              if (!(Array.isArray(u) && u.length && u.filter(fn$).length)) {\n                continue;\n              }\n              max = 0;\n              matched = true;\n              if (Array.isArray(u)) {\n                for (j$ = 0, to1$ = u.length; j$ \u003C to1$; ++j$) {\n                  j = j$;\n                  if (u[j] != null && u[j] !== \"\") {\n                    max = j + 1;\n                  }\n                }\n              }\n              if (max \u003C +c.min || max \u003E +c.max) {\n                return false;\n              }\n            }\n            return matched;\n            function fn$(it){\n              return it != null && it !== \"\";\n            }\n          },\n          config: {\n            min: {\n              type: 'text',\n              name: \"min\",\n              hint: \"minimal value\"\n            },\n            max: {\n              type: 'text',\n              name: \"max\",\n              hint: \"maximal value\"\n            }\n          }\n        }\n      }\n    }));\n  }\n});\u003C\u002Fscript\u003E";
;pug_debug_line = 4;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fsheet\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cstyle type=\"text\u002Fcss\"\u003E";
;pug_debug_line = 4;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fsheet\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "[plug=view] {\n  position: relative;\n  padding-top: 50%;\n  border: 1px solid #ccc;\n}\n[plug=view] .sheet {\n  position: absolute;\n  top: 0;\n  left: 0;\n}\n\u003C\u002Fstyle\u003E\u003C\u002Fdiv\u003E";} catch (err) {pug_rethrow(err, pug_debug_filename, pug_debug_line);};return pug_html;}; module.exports = template; })() 