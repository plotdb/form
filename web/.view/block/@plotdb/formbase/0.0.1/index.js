 (function() { function pug_attr(t,e,n,r){if(!1===e||null==e||!e&&("class"===t||"style"===t))return"";if(!0===e)return" "+(r?t:t+'="'+t+'"');var f=typeof e;return"object"!==f&&"function"!==f||"function"!=typeof e.toJSON||(e=e.toJSON()),"string"==typeof e||(e=JSON.stringify(e),n||-1===e.indexOf('"'))?(n&&(e=pug_escape(e))," "+t+'="'+e+'"'):" "+t+"='"+e.replace(/'/g,"&#39;")+"'"}
function pug_escape(e){var a=""+e,t=pug_match_html.exec(a);if(!t)return e;var r,c,n,s="";for(r=t.index,c=0;r<a.length;r++){switch(a.charCodeAt(r)){case 34:n="&quot;";break;case 38:n="&amp;";break;case 60:n="&lt;";break;case 62:n="&gt;";break;default:continue}c!==r&&(s+=a.substring(c,r)),c=r+1,s+=n}return c!==r?s+a.substring(c,r):s}
var pug_match_html=/["&<>]/;
function pug_rethrow(n,e,r,t){if(!(n instanceof Error))throw n;if(!("undefined"==typeof window&&e||t))throw n.message+=" on line "+r,n;try{t=t||require("fs").readFileSync(e,"utf8")}catch(e){pug_rethrow(n,null,r)}var i=3,a=t.split("\n"),o=Math.max(r-i,0),h=Math.min(a.length,r+i),i=a.slice(o,h).map(function(n,e){var t=e+o+1;return(t==r?"  > ":"    ")+t+"| "+n}).join("\n");throw n.path=e,n.message=(e||"Pug")+":"+r+"\n"+i+"\n\n"+n.message,n}function template(locals) {var pug_html = "", pug_mixins = {}, pug_interp;var pug_debug_filename, pug_debug_line;try {;pug_debug_line = 1;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv\u003E";
;pug_debug_line = 2;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv\u003E";
;pug_debug_line = 3;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cplug name=\"view\"\u003E\u003C\u002Fplug\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 4;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Chr\u002F\u003E";
;pug_debug_line = 5;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv\u003E";
;pug_debug_line = 5;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "control panel\u003C\u002Fdiv\u003E";
;pug_debug_line = 6;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Chr\u002F\u003E";
;pug_debug_line = 7;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mb-2 d-flex\"\u003E";
;pug_debug_line = 8;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"flex-grow-1\"\u003E";
;pug_debug_line = 9;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv\u003E";
;pug_debug_line = 9;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "title\u003C\u002Fdiv\u003E";
;pug_debug_line = 10;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cinput class=\"form-control\" ld=\"title\"\u002F\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 11;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"ml-4\"\u003E";
;pug_debug_line = 12;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv\u003E";
;pug_debug_line = 12;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "alias\u003C\u002Fdiv\u003E";
;pug_debug_line = 13;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cselect class=\"form-control\" ld=\"alias\"\u003E";
;pug_debug_line = 14;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Coption value=\"uid\"\u003E";
;pug_debug_line = 14;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "統編\u003C\u002Foption\u003E";
;pug_debug_line = 15;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Coption value=\"teamname\"\u003E";
;pug_debug_line = 15;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "單位名稱\u003C\u002Foption\u003E";
;pug_debug_line = 16;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Coption value=\"teamname\"\u003E";
;pug_debug_line = 16;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "自訂..\u003C\u002Foption\u003E\u003C\u002Fselect\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 17;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mb-2\"\u003E";
;pug_debug_line = 18;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv\u003E";
;pug_debug_line = 18;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "description\u003C\u002Fdiv\u003E";
;pug_debug_line = 19;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Ctextarea class=\"form-control\" rows=\"5\" ld=\"desc\"\u003E\u003C\u002Ftextarea\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 20;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"d-flex mb-2 align-items-center\"\u003E";
;pug_debug_line = 21;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
// iterate ["isRequired", "isPublic", "showDesc"]
;(function(){
  var $$obj = ["isRequired", "isPublic", "showDesc"];
  if ('number' == typeof $$obj.length) {
      for (var pug_index0 = 0, $$l = $$obj.length; pug_index0 < $$l; pug_index0++) {
        var i = $$obj[pug_index0];
;pug_debug_line = 22;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"d-flex align-items-center mr-4\"\u003E";
;pug_debug_line = 22;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "";
;pug_debug_line = 22;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cspan\u003E";
;pug_debug_line = 22;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + (pug_escape(null == (pug_interp = i) ? "" : pug_interp)) + "\u003C\u002Fspan\u003E";
;pug_debug_line = 22;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "";
;pug_debug_line = 22;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv" + (" class=\"switch ml-1\""+" ld=\"switch\""+pug_attr("data-name", i, true, false)) + "\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 22;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003C\u002Fdiv\u003E";
      }
  } else {
    var $$l = 0;
    for (var pug_index0 in $$obj) {
      $$l++;
      var i = $$obj[pug_index0];
;pug_debug_line = 22;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"d-flex align-items-center mr-4\"\u003E";
;pug_debug_line = 22;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "";
;pug_debug_line = 22;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cspan\u003E";
;pug_debug_line = 22;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + (pug_escape(null == (pug_interp = i) ? "" : pug_interp)) + "\u003C\u002Fspan\u003E";
;pug_debug_line = 22;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "";
;pug_debug_line = 22;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv" + (" class=\"switch ml-1\""+" ld=\"switch\""+pug_attr("data-name", i, true, false)) + "\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 22;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003C\u002Fdiv\u003E";
    }
  }
}).call(this);

pug_html = pug_html + "\u003C\u002Fdiv\u003E";
;pug_debug_line = 23;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mb-2\"\u003E";
;pug_debug_line = 24;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv\u003E";
;pug_debug_line = 24;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "critera\u003C\u002Fdiv\u003E";
;pug_debug_line = 25;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"d-flex mb-2\"\u003E";
;pug_debug_line = 26;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mr-2\"\u003E";
;pug_debug_line = 27;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv\u003E";
;pug_debug_line = 27;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "attr\u003C\u002Fdiv\u003E";
;pug_debug_line = 28;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cselect class=\"form-control mr-2\" ld=\"picked-attr\"\u003E";
;pug_debug_line = 29;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Coption ld-each=\"attr\"\u003E";
;pug_debug_line = 29;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "number\u003C\u002Foption\u003E\u003C\u002Fselect\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 30;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mr-2\"\u003E";
;pug_debug_line = 31;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv\u003E";
;pug_debug_line = 31;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "op\u003C\u002Fdiv\u003E";
;pug_debug_line = 32;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cselect class=\"form-control mr-2\" ld=\"picked-op\"\u003E";
;pug_debug_line = 33;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Coption ld-each=\"op\"\u003E";
;pug_debug_line = 33;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "between\u003C\u002Foption\u003E\u003C\u002Fselect\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 34;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mr-2 flex-grow-1\" ld-each=\"op-config\"\u003E";
;pug_debug_line = 35;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv ld=\"name\"\u003E";
;pug_debug_line = 35;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "name\u003C\u002Fdiv\u003E";
;pug_debug_line = 36;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cinput class=\"form-control mr-2\" ld=\"value\" value=\"1\"\u002F\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 37;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv\u003E";
;pug_debug_line = 38;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv\u003E";
;pug_debug_line = 38;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "&nbsp;\u003C\u002Fdiv\u003E";
;pug_debug_line = 39;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"btn btn-outline-primary\" ld=\"add-criteria\"\u003E";
;pug_debug_line = 39;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "";
;pug_debug_line = 39;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Ci class=\"i-plus\"\u003E\u003C\u002Fi\u003E";
;pug_debug_line = 39;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 40;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Chr\u002F\u003E";
;pug_debug_line = 41;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"d-flex mb-2 align-items-center\" ld-each=\"criteria\"\u003E";
;pug_debug_line = 42;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mr-2\"\u003E";
;pug_debug_line = 43;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv\u003E";
;pug_debug_line = 43;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "&nbsp;\u003C\u002Fdiv\u003E";
;pug_debug_line = 44;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"switch switch-lg\" ld=\"enabled\"\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 45;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mr-2\"\u003E";
;pug_debug_line = 46;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv\u003E";
;pug_debug_line = 46;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "attr\u003C\u002Fdiv\u003E";
;pug_debug_line = 47;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cselect class=\"form-control mr-2\" ld=\"attr\"\u003E";
;pug_debug_line = 48;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Coption ld-each=\"attr-option\"\u003E";
;pug_debug_line = 48;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "number\u003C\u002Foption\u003E\u003C\u002Fselect\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 49;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mr-2\"\u003E";
;pug_debug_line = 50;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv\u003E";
;pug_debug_line = 50;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "op\u003C\u002Fdiv\u003E";
;pug_debug_line = 51;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cselect class=\"form-control mr-2\" ld=\"op\"\u003E";
;pug_debug_line = 52;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Coption ld-each=\"op-option\"\u003E";
;pug_debug_line = 52;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "between\u003C\u002Foption\u003E\u003C\u002Fselect\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 53;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mr-2 flex-grow-1\" ld-each=\"op-config\"\u003E";
;pug_debug_line = 54;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv ld=\"name\"\u003E";
;pug_debug_line = 54;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "name\u003C\u002Fdiv\u003E";
;pug_debug_line = 55;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cinput class=\"form-control mr-2\" ld=\"value\" value=\"1\"\u002F\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 56;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv\u003E";
;pug_debug_line = 57;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv\u003E";
;pug_debug_line = 57;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "&nbsp;\u003C\u002Fdiv\u003E";
;pug_debug_line = 58;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"btn btn-outline-danger\" ld=\"delete\"\u003E";
;pug_debug_line = 58;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "";
;pug_debug_line = 58;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Ci class=\"i-close\"\u003E\u003C\u002Fi\u003E";
;pug_debug_line = 58;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 60;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cscript type=\"@plotdb\u002Fblock\"\u003E";
;pug_debug_line = 60;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "({\n  pkg: {\n    name: \"@plotdb\u002Fformbase\",\n    version: \"0.0.1\"\n  },\n  init: function(arg$){\n    var root;\n    root = arg$.root;\n    console.log(\"formbase\");\n    return function(it){\n      return new it();\n    }(function(){\n      var _, view, this$ = this;\n      this.root = root;\n      _ = this.data = {};\n      return this.view = view = new ldView({\n        root: this.root,\n        action: {\n          input: {\n            title: function(arg$){\n              var node;\n              node = arg$.node;\n              return _.title = node.value || '';\n            },\n            desc: function(arg$){\n              var node;\n              node = arg$.node;\n              return _.desc = node.value || '';\n            },\n            value: function(arg$){\n              var node;\n              node = arg$.node;\n              _.value = node.value;\n              return _.criteria.map(function(){\n                return form.term;\n              });\n            }\n          },\n          click: {\n            \"add-criteria\": function(){\n              _.criteria.push({});\n              return this$.view.render('criteria');\n            },\n            'switch': function(arg$){\n              var node, n;\n              node = arg$.node;\n              n = node.getAttribute('data-name');\n              if (!(n === 'isPublic' || n === 'isRequired' || n === 'showDesc')) {\n                return;\n              }\n              _[n] = !_[n];\n              return view.render();\n            }\n          }\n        },\n        handler: {\n          title: function(arg$){\n            var node;\n            node = arg$.node;\n            return node.value = _.title || '';\n          },\n          desc: function(arg$){\n            var node;\n            node = arg$.node;\n            return node.value = _.desc || '';\n          },\n          'switch': function(arg$){\n            var node, n;\n            node = arg$.node;\n            n = node.getAttribute('data-name');\n            if (!(n === 'isPublic' || n === 'isRequired' || n === 'showDesc')) {\n              return;\n            }\n            return node.classList.toggle('on', !!_[n]);\n          },\n          attr: {\n            list: function(){\n              var k, v;\n              return (function(){\n                var ref$, results$ = [];\n                for (k in ref$ = _.attr) {\n                  v = ref$[k];\n                  results$.push({\n                    k: k,\n                    v: v\n                  });\n                }\n                return results$;\n              }()) || [];\n            },\n            handler: function(arg$){\n              var node, data;\n              node = arg$.node, data = arg$.data;\n              node.setAttribute('value', data.k);\n              return node.innerText = data.v.name;\n            }\n          },\n          criteria: {\n            list: function(){\n              return _.criteria || [];\n            },\n            view: {\n              action: {\n                click: {\n                  enabled: function(arg$){\n                    var context;\n                    context = arg$.context;\n                    context.enabled = !context.enabled;\n                    return this$.view.render('criteria');\n                  },\n                  'delete': function(arg$){\n                    var context;\n                    context = arg$.context;\n                    _.criteria.splice(_.criteria.indexOf(context), 1);\n                    return this$.view.render('criteria');\n                  }\n                },\n                change: {\n                  attr: function(arg$){\n                    var node, context;\n                    node = arg$.node, context = arg$.context;\n                    context.opset = _.attr[node.value].opset;\n                    return view.render('criteria');\n                  },\n                  op: function(arg$){\n                    var node, context;\n                    node = arg$.node, context = arg$.context;\n                    context.op = form.opset.get(context.opset || 'number').getOp(node.value);\n                    return view.render('criteria');\n                  }\n                }\n              },\n              handler: {\n                enabled: function(arg$){\n                  var node, context;\n                  node = arg$.node, context = arg$.context;\n                  return node.classList.toggle('on', !!context.enabled);\n                },\n                \"attr-option\": {\n                  list: function(){\n                    var k, v;\n                    return (function(){\n                      var ref$, results$ = [];\n                      for (k in ref$ = _.attr) {\n                        v = ref$[k];\n                        results$.push({\n                          k: k,\n                          v: v\n                        });\n                      }\n                      return results$;\n                    }()) || [];\n                  },\n                  key: function(it){\n                    return it.k;\n                  },\n                  handler: function(arg$){\n                    var node, data;\n                    node = arg$.node, data = arg$.data;\n                    node.setAttribute('value', data.k);\n                    return node.innerText = data.v.name;\n                  }\n                },\n                \"op-option\": {\n                  list: function(arg$){\n                    var context, opset, k, ref$, v, results$ = [];\n                    context = arg$.context;\n                    opset = form.opset.get(context.opset || 'number');\n                    for (k in ref$ = opset.ops) {\n                      v = ref$[k];\n                      results$.push(v);\n                    }\n                    return results$;\n                  },\n                  handler: function(arg$){\n                    var node, data;\n                    node = arg$.node, data = arg$.data;\n                    node.setAttribute('value', data.id);\n                    return node.innerText = data.name;\n                  }\n                },\n                \"op-config\": {\n                  list: function(arg$){\n                    var context, k, ref$, v, results$ = [];\n                    context = arg$.context;\n                    for (k in ref$ = (context.op || (context.op = {})).config || {}) {\n                      v = ref$[k];\n                      results$.push({\n                        k: k,\n                        v: v\n                      });\n                    }\n                    return results$;\n                  },\n                  key: function(it){\n                    return it.k;\n                  },\n                  view: {\n                    text: {\n                      name: function(arg$){\n                        var node, context;\n                        node = arg$.node, context = arg$.context;\n                        return context.k;\n                      }\n                    }\n                  }\n                }\n              }\n            }\n          }\n        }\n      });\n    });\n  }\n});\u003C\u002Fscript\u003E\u003C\u002Fdiv\u003E";} catch (err) {pug_rethrow(err, pug_debug_filename, pug_debug_line);};return pug_html;}; module.exports = template; })() 