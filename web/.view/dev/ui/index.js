 (function() { function pug_attr(t,e,n,r){if(!1===e||null==e||!e&&("class"===t||"style"===t))return"";if(!0===e)return" "+(r?t:t+'="'+t+'"');var f=typeof e;return"object"!==f&&"function"!==f||"function"!=typeof e.toJSON||(e=e.toJSON()),"string"==typeof e||(e=JSON.stringify(e),n||-1===e.indexOf('"'))?(n&&(e=pug_escape(e))," "+t+'="'+e+'"'):" "+t+"='"+e.replace(/'/g,"&#39;")+"'"}
function pug_attrs(t,r){var a="";for(var s in t)if(pug_has_own_property.call(t,s)){var u=t[s];if("class"===s){u=pug_classes(u),a=pug_attr(s,u,!1,r)+a;continue}"style"===s&&(u=pug_style(u)),a+=pug_attr(s,u,!1,r)}return a}
function pug_classes(s,r){return Array.isArray(s)?pug_classes_array(s,r):s&&"object"==typeof s?pug_classes_object(s):s||""}
function pug_classes_array(r,a){for(var s,e="",u="",c=Array.isArray(a),g=0;g<r.length;g++)(s=pug_classes(r[g]))&&(c&&a[g]&&(s=pug_escape(s)),e=e+u+s,u=" ");return e}
function pug_classes_object(r){var a="",n="";for(var o in r)o&&r[o]&&pug_has_own_property.call(r,o)&&(a=a+n+o,n=" ");return a}
function pug_escape(e){var a=""+e,t=pug_match_html.exec(a);if(!t)return e;var r,c,n,s="";for(r=t.index,c=0;r<a.length;r++){switch(a.charCodeAt(r)){case 34:n="&quot;";break;case 38:n="&amp;";break;case 60:n="&lt;";break;case 62:n="&gt;";break;default:continue}c!==r&&(s+=a.substring(c,r)),c=r+1,s+=n}return c!==r?s+a.substring(c,r):s}
var pug_has_own_property=Object.prototype.hasOwnProperty;
var pug_match_html=/["&<>]/;
function pug_merge(e,r){if(1===arguments.length){for(var t=e[0],g=1;g<e.length;g++)t=pug_merge(t,e[g]);return t}for(var l in r)if("class"===l){var n=e[l]||[];e[l]=(Array.isArray(n)?n:[n]).concat(r[l]||[])}else if("style"===l){var n=pug_style(e[l]);n=n&&";"!==n[n.length-1]?n+";":n;var a=pug_style(r[l]);a=a&&";"!==a[a.length-1]?a+";":a,e[l]=n+a}else e[l]=r[l];return e}
function pug_rethrow(e,n,r,t){if(!(e instanceof Error))throw e;if(!("undefined"==typeof window&&n||t))throw e.message+=" on line "+r,e;var o,a,i,s;try{t=t||require("fs").readFileSync(n,{encoding:"utf8"}),o=3,a=t.split("\n"),i=Math.max(r-o,0),s=Math.min(a.length,r+o)}catch(t){return e.message+=" - could not read from "+n+" ("+t.message+")",void pug_rethrow(e,null,r)}o=a.slice(i,s).map(function(e,n){var t=n+i+1;return(t==r?"  > ":"    ")+t+"| "+e}).join("\n"),e.path=n;try{e.message=(n||"Pug")+":"+r+"\n"+o+"\n\n"+e.message}catch(e){}throw e}
function pug_style(r){if(!r)return"";if("object"==typeof r){var t="";for(var e in r)pug_has_own_property.call(r,e)&&(t=t+e+":"+r[e]+";");return t}return r+""}function template(locals) {var pug_html = "", pug_mixins = {}, pug_interp;var pug_debug_filename, pug_debug_line;try {;
    var locals_for_with = (locals || {});
    
    (function (Array, JSON, b64img, blockLoader, cssLoader, decache, escape, prefix, scriptLoader, version) {
      ;pug_debug_line = 2;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fweb\u002Fsrc\u002Fpug\u002Fbase.pug";
pug_html = pug_html + "\u003C!DOCTYPE html\u003E";
;pug_debug_line = 3;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fweb\u002Fsrc\u002Fpug\u002Fbase.pug";
pug_html = pug_html + "\u003Chtml\u003E";
;pug_debug_line = 4;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fweb\u002Fsrc\u002Fpug\u002Fbase.pug";
;pug_debug_line = 2;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fnode_modules\u002F@loadingio\u002Fbootstrap.ext\u002Fdist\u002Findex.pug";
if(!scriptLoader) { scriptLoader = {url: {}, config: {}}; }
;pug_debug_line = 3;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fnode_modules\u002F@loadingio\u002Fbootstrap.ext\u002Fdist\u002Findex.pug";
if(!decache) { decache = (version? "?v=" + version : ""); }
;pug_debug_line = 4;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fnode_modules\u002F@loadingio\u002Fbootstrap.ext\u002Fdist\u002Findex.pug";
pug_mixins["script"] = pug_interp = function(url,config){
var block = (this && this.block), attributes = (this && this.attributes) || {};
;pug_debug_line = 5;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fnode_modules\u002F@loadingio\u002Fbootstrap.ext\u002Fdist\u002Findex.pug";
scriptLoader.config = (config ? config : {});
;pug_debug_line = 6;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fnode_modules\u002F@loadingio\u002Fbootstrap.ext\u002Fdist\u002Findex.pug";
if (!scriptLoader.url[url]) {
;pug_debug_line = 7;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fnode_modules\u002F@loadingio\u002Fbootstrap.ext\u002Fdist\u002Findex.pug";
scriptLoader.url[url] = true;
;pug_debug_line = 8;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fnode_modules\u002F@loadingio\u002Fbootstrap.ext\u002Fdist\u002Findex.pug";
if (/^https?:\/\/./.exec(url)) {
;pug_debug_line = 9;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fnode_modules\u002F@loadingio\u002Fbootstrap.ext\u002Fdist\u002Findex.pug";
pug_html = pug_html + "\u003Cscript" + (" type=\"text\u002Fjavascript\""+pug_attr("src", url, true, true)+pug_attr("defer", !!scriptLoader.config.defer, true, true)+pug_attr("async", !!scriptLoader.config.async, true, true)) + "\u003E\u003C\u002Fscript\u003E";
}
else {
;pug_debug_line = 12;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fnode_modules\u002F@loadingio\u002Fbootstrap.ext\u002Fdist\u002Findex.pug";
pug_html = pug_html + "\u003Cscript" + (" type=\"text\u002Fjavascript\""+pug_attr("src", url + decache, true, true)+pug_attr("defer", !!scriptLoader.config.defer, true, true)+pug_attr("async", !!scriptLoader.config.async, true, true)) + "\u003E\u003C\u002Fscript\u003E";
}
}
};
;pug_debug_line = 15;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fnode_modules\u002F@loadingio\u002Fbootstrap.ext\u002Fdist\u002Findex.pug";
if(!cssLoader) { cssLoader = {url: {}}; }
;pug_debug_line = 16;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fnode_modules\u002F@loadingio\u002Fbootstrap.ext\u002Fdist\u002Findex.pug";
pug_mixins["css"] = pug_interp = function(url,config){
var block = (this && this.block), attributes = (this && this.attributes) || {};
;pug_debug_line = 17;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fnode_modules\u002F@loadingio\u002Fbootstrap.ext\u002Fdist\u002Findex.pug";
cssLoader.config = (config ? config : {});
;pug_debug_line = 18;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fnode_modules\u002F@loadingio\u002Fbootstrap.ext\u002Fdist\u002Findex.pug";
if (!cssLoader.url[url]) {
;pug_debug_line = 19;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fnode_modules\u002F@loadingio\u002Fbootstrap.ext\u002Fdist\u002Findex.pug";
cssLoader.url[url] = true;
;pug_debug_line = 20;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fnode_modules\u002F@loadingio\u002Fbootstrap.ext\u002Fdist\u002Findex.pug";
pug_html = pug_html + "\u003Clink" + (" rel=\"stylesheet\" type=\"text\u002Fcss\""+pug_attr("href", url + decache, true, true)) + "\u003E";
}
};
;pug_debug_line = 22;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fnode_modules\u002F@loadingio\u002Fbootstrap.ext\u002Fdist\u002Findex.pug";
if(!blockLoader) { blockLoader = {name: {}, config: {}}; }
;pug_debug_line = 23;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fnode_modules\u002F@loadingio\u002Fbootstrap.ext\u002Fdist\u002Findex.pug";










;pug_debug_line = 28;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fnode_modules\u002F@loadingio\u002Fbootstrap.ext\u002Fdist\u002Findex.pug";
var escjson = function(obj) { return 'JSON.parse(unescape("' + escape(JSON.stringify(obj)) + '"))'; };
;pug_debug_line = 30;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fnode_modules\u002F@loadingio\u002Fbootstrap.ext\u002Fdist\u002Findex.pug";
var eschtml = (function() { var MAP = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&#34;', "'": '&#39;' }; var repl = function(c) { return MAP[c]; }; return function(s) { return s.replace(/[&<>'"]/g, repl); }; })();
;pug_debug_line = 33;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fnode_modules\u002F@loadingio\u002Fbootstrap.ext\u002Fdist\u002Findex.pug";









;pug_debug_line = 36;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fnode_modules\u002F@loadingio\u002Fbootstrap.ext\u002Fdist\u002Findex.pug";
var b64img = {};
;pug_debug_line = 37;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fnode_modules\u002F@loadingio\u002Fbootstrap.ext\u002Fdist\u002Findex.pug";
b64img.px1 = "data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAAAAAAALAAAAAABAAEAQAICRAEAOw=="
;pug_debug_line = 39;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fnode_modules\u002F@loadingio\u002Fbootstrap.ext\u002Fdist\u002Findex.pug";
var loremtext = {
  zh: "料何緊許團人受間口語日是藝一選去，得系目、再驗現表爸示片球法中轉國想我樹我，色生早都沒方上情精一廣發！能生運想毒一生人一身德接地，說張在未安人、否臺重壓車亞是我！終力邊技的大因全見起？切問去火極性現中府會行多他千時，來管表前理不開走於展長因，現多上我，工行他眼。總務離子方區面人話同下，這國當非視後得父能民觀基作影輕印度民雖主他是一，星月死較以太就而開後現：國這作有，他你地象的則，引管戰照十都是與行求證來亞電上地言裡先保。大去形上樹。計太風何不先歡的送但假河線己綠？計像因在……初人快政爭連合多考超的得麼此是間不跟代光離制不主政重造的想高據的意臺月飛可成可有時情乎為灣臺我養家小，叫轉於可！錢因其他節，物如盡男府我西上事是似個過孩而過要海？更神施一關王野久沒玩動一趣庭顧倒足要集我民雲能信爸合以物頭容戰度系士我多學一、區作一，過業手：大不結獨星科表小黨上千法值之兒聲價女去大著把己。",
  en: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
};

;pug_debug_line = 45;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fnode_modules\u002F@loadingio\u002Fbootstrap.ext\u002Fdist\u002Findex.pug";







;pug_debug_line = 47;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fnode_modules\u002F@loadingio\u002Fbootstrap.ext\u002Fdist\u002Findex.pug";













;pug_debug_line = 1;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fnode_modules\u002Fldview\u002Fdist\u002Findex.pug";
prefix = function(n) { return (!n?[]:(Array.isArray(n)?n:[n])).map(function(it){ return `${prefix.currentName}$${it}`; }).join(' ');}
;pug_debug_line = 2;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fnode_modules\u002Fldview\u002Fdist\u002Findex.pug";





















;pug_debug_line = 7;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fweb\u002Fsrc\u002Fpug\u002Fbase.pug";
pug_html = pug_html + "\u003Chead\u003E";
;pug_debug_line = 8;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fweb\u002Fsrc\u002Fpug\u002Fbase.pug";
;pug_debug_line = 3;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cbase href=\"\u002F\"\u003E";
;pug_debug_line = 9;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fweb\u002Fsrc\u002Fpug\u002Fbase.pug";
pug_mixins["css"]("https://fonts.googleapis.com/css?family=Roboto:300,400,700|Roboto+Mono");
;pug_debug_line = 10;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fweb\u002Fsrc\u002Fpug\u002Fbase.pug";
pug_mixins["css"]("assets/lib/bootstrap/main/css/bootstrap.min.css");
;pug_debug_line = 11;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fweb\u002Fsrc\u002Fpug\u002Fbase.pug";
pug_mixins["css"]("assets/lib/@loadingio/bootstrap.ext/main/index.min.css");
;pug_debug_line = 12;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fweb\u002Fsrc\u002Fpug\u002Fbase.pug";
pug_mixins["css"]("assets/lib/ldcover/main/ldcv.min.css");
;pug_debug_line = 13;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fweb\u002Fsrc\u002Fpug\u002Fbase.pug";
pug_mixins["css"]("assets/lib/ldiconfont/main/ldif.min.css");
;pug_debug_line = 14;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fweb\u002Fsrc\u002Fpug\u002Fbase.pug";
pug_mixins["css"]("css/index.css");
;pug_debug_line = 15;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fweb\u002Fsrc\u002Fpug\u002Fbase.pug";
;pug_debug_line = 5;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cstyle type=\"text\u002Fcss\"\u003E";
;pug_debug_line = 5;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + ".form-control.simple {\n  border-width: 0 0 1px 0;\n  border-color: #f9f9f9;\n  background: #fdfdfd;\n}\n.form-control::placeholder {\n  color: #d9dadb;\n}\n\u003C\u002Fstyle\u003E\u003C\u002Fhead\u003E";
;pug_debug_line = 16;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fweb\u002Fsrc\u002Fpug\u002Fbase.pug";
pug_html = pug_html + "\u003Cbody\u003E";
;pug_debug_line = 18;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fweb\u002Fsrc\u002Fpug\u002Fbase.pug";
;pug_debug_line = 13;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"w-640 mx-auto rwd my-4\"\u003E";
;pug_debug_line = 14;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"rounded-lg shadow\"\u003E";
;pug_debug_line = 15;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"p-4\"\u003E";
;pug_debug_line = 16;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"d-flex\"\u003E";
;pug_debug_line = 17;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"flex-grow-1\"\u003E";
;pug_debug_line = 18;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Ch3\u003E";
;pug_debug_line = 18;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "問題的標題\u003C\u002Fh3\u003E";
;pug_debug_line = 19;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cp\u003E";
;pug_debug_line = 19;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "關於問題的簡單描述 ...\u003C\u002Fp\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 20;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv\u003E";
;pug_debug_line = 21;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"ml-4\"\u003E";
;pug_debug_line = 21;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown\"\u003E";
;pug_debug_line = 22;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"btn btn-light dropdown-toggle\" data-toggle=\"dropdown\"\u003E";
;pug_debug_line = 22;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "短名\u003C\u002Fdiv\u003E";
;pug_debug_line = 23;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown-menu dropdown-menu-right\"\u003E";
;pug_debug_line = 24;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown-item\"\u003E";
;pug_debug_line = 24;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "統一編號\u003C\u002Fdiv\u003E";
;pug_debug_line = 25;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown-item\"\u003E";
;pug_debug_line = 25;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "電話\u003C\u002Fdiv\u003E";
;pug_debug_line = 26;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown-item\"\u003E";
;pug_debug_line = 26;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "團隊名稱\u003C\u002Fdiv\u003E";
;pug_debug_line = 27;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown-item\"\u003E";
;pug_debug_line = 27;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cinput class=\"form-control\" placeholder=\"自訂 ...\"\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 29;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cinput class=\"form-control simple\" placeholder=\"請在這裡輸入 ...\"\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 31;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"border-top border-bottom\"\u003E";
;pug_debug_line = 32;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
// iterate [1,2,3]
;(function(){
  var $$obj = [1,2,3];
  if ('number' == typeof $$obj.length) {
      for (var pug_index0 = 0, $$l = $$obj.length; pug_index0 < $$l; pug_index0++) {
        var i = $$obj[pug_index0];
;pug_debug_line = 33;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"m-4\"\u003E";
;pug_debug_line = 34;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"d-flex align-items-center justify-content-between\"\u003E";
;pug_debug_line = 35;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mr-2\"\u003E";
;pug_debug_line = 35;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"switch switch-lg\"\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 36;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mr-2\"\u003E";
;pug_debug_line = 36;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown\"\u003E";
;pug_debug_line = 37;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"btn btn-light dropdown-toggle\"\u003E";
;pug_debug_line = 37;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "數值\u003C\u002Fdiv\u003E";
;pug_debug_line = 38;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown-menu\"\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 39;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mr-2\"\u003E";
;pug_debug_line = 39;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown\"\u003E";
;pug_debug_line = 40;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"btn btn-light dropdown-toggle\"\u003E";
;pug_debug_line = 40;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "≧大於或等於\u003C\u002Fdiv\u003E";
;pug_debug_line = 41;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown-menu\"\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 42;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mr-2\"\u003E";
;pug_debug_line = 42;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cinput class=\"form-control simple\" placeholder=\"值 1\"\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 43;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv\u003E";
;pug_debug_line = 43;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cinput class=\"form-control simple\" placeholder=\"值 2\"\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
      }
  } else {
    var $$l = 0;
    for (var pug_index0 in $$obj) {
      $$l++;
      var i = $$obj[pug_index0];
;pug_debug_line = 33;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"m-4\"\u003E";
;pug_debug_line = 34;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"d-flex align-items-center justify-content-between\"\u003E";
;pug_debug_line = 35;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mr-2\"\u003E";
;pug_debug_line = 35;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"switch switch-lg\"\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 36;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mr-2\"\u003E";
;pug_debug_line = 36;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown\"\u003E";
;pug_debug_line = 37;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"btn btn-light dropdown-toggle\"\u003E";
;pug_debug_line = 37;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "數值\u003C\u002Fdiv\u003E";
;pug_debug_line = 38;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown-menu\"\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 39;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mr-2\"\u003E";
;pug_debug_line = 39;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown\"\u003E";
;pug_debug_line = 40;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"btn btn-light dropdown-toggle\"\u003E";
;pug_debug_line = 40;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "≧大於或等於\u003C\u002Fdiv\u003E";
;pug_debug_line = 41;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown-menu\"\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 42;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mr-2\"\u003E";
;pug_debug_line = 42;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cinput class=\"form-control simple\" placeholder=\"值 1\"\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 43;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv\u003E";
;pug_debug_line = 43;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cinput class=\"form-control simple\" placeholder=\"值 2\"\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
    }
  }
}).call(this);

pug_html = pug_html + "\u003C\u002Fdiv\u003E";
;pug_debug_line = 45;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"p-4\"\u003E";
;pug_debug_line = 46;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"d-flex align-items-center\"\u003E";
;pug_debug_line = 47;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mr-2\"\u003E";
;pug_debug_line = 47;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"btn btn-sm btn-outline-danger\"\u003E";
;pug_debug_line = 47;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "刪除\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 48;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mr-2\"\u003E";
;pug_debug_line = 48;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"btn btn-sm btn-outline-secondary\"\u003E";
;pug_debug_line = 48;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "";
;pug_debug_line = 48;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Ci class=\"i-clone\"\u003E\u003C\u002Fi\u003E";
;pug_debug_line = 48;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + " 複製\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 49;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"flex-grow-1 justify-content-end d-flex\"\u003E";
;pug_debug_line = 50;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"ml-4 d-flex align-items-center\"\u003E";
;pug_debug_line = 50;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "公開 ";
;pug_debug_line = 50;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"switch ml-2\"\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 50;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003C\u002Fdiv\u003E";
;pug_debug_line = 51;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"ml-4 d-flex align-items-center\"\u003E";
;pug_debug_line = 51;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "必填 ";
;pug_debug_line = 51;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"switch ml-2 on\"\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 51;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003C\u002Fdiv\u003E";
;pug_debug_line = 52;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"ml-4 d-flex align-items-center\"\u003E";
;pug_debug_line = 52;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "顯示描述 ";
;pug_debug_line = 52;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"switch ml-2\"\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 52;pug_debug_filename = "src\u002Fpug\u002Fdev\u002Fui\u002Findex.pug";
pug_html = pug_html + "\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 19;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fweb\u002Fsrc\u002Fpug\u002Fbase.pug";
pug_mixins["script"]("assets/lib/bootstrap.native/main/bootstrap-native.min.js");
;pug_debug_line = 20;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fweb\u002Fsrc\u002Fpug\u002Fbase.pug";
pug_mixins["script"]("assets/lib/i18next/main/umd/i18next.min.js");
;pug_debug_line = 21;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fweb\u002Fsrc\u002Fpug\u002Fbase.pug";
pug_mixins["script"]("assets/lib/@loadingio/debounce.js/main/debounce.min.js");
;pug_debug_line = 22;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fweb\u002Fsrc\u002Fpug\u002Fbase.pug";
pug_mixins["script"]("assets/lib/@loadingio/ldquery/main/ldq.min.js");
;pug_debug_line = 23;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fweb\u002Fsrc\u002Fpug\u002Fbase.pug";
pug_mixins["script"]("assets/lib/proxise/main/proxise.min.js");
;pug_debug_line = 24;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fweb\u002Fsrc\u002Fpug\u002Fbase.pug";
pug_mixins["script"]("assets/lib/ldcover/main/ldcv.min.js");
;pug_debug_line = 25;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fweb\u002Fsrc\u002Fpug\u002Fbase.pug";
pug_mixins["script"]("assets/lib/ldview/main/index.min.js");
;pug_debug_line = 26;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fweb\u002Fsrc\u002Fpug\u002Fbase.pug";
pug_mixins["script"]("assets/lib/@plotdb/datadom/main/datadom.min.js");
;pug_debug_line = 27;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fweb\u002Fsrc\u002Fpug\u002Fbase.pug";
pug_mixins["script"]("assets/lib/@plotdb/datahub/main/datahub.bundle.min.js");
;pug_debug_line = 28;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fweb\u002Fsrc\u002Fpug\u002Fbase.pug";
pug_mixins["script"]("assets/lib/@plotdb/csscope/main/csscope.min.js");
;pug_debug_line = 29;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fweb\u002Fsrc\u002Fpug\u002Fbase.pug";
pug_mixins["script"]("assets/lib/@plotdb/rescope/main/rescope.min.js");
;pug_debug_line = 30;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fweb\u002Fsrc\u002Fpug\u002Fbase.pug";
pug_mixins["script"]("assets/lib/@plotdb/block/main/block.min.js");
;pug_debug_line = 31;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fweb\u002Fsrc\u002Fpug\u002Fbase.pug";
pug_mixins["script"]("assets/lib/@plotdb/form/dev/form.min.js");
;pug_debug_line = 32;pug_debug_filename = "\u002FUsers\u002Ftkirby\u002Fworkspace\u002Fzbryikt\u002Fplotdb\u002Fprojects\u002Fform\u002Fweb\u002Fsrc\u002Fpug\u002Fbase.pug";
pug_html = pug_html + "\u003C\u002Fbody\u003E\u003C\u002Fhtml\u003E";
    }.call(this, "Array" in locals_for_with ?
        locals_for_with.Array :
        typeof Array !== 'undefined' ? Array : undefined, "JSON" in locals_for_with ?
        locals_for_with.JSON :
        typeof JSON !== 'undefined' ? JSON : undefined, "b64img" in locals_for_with ?
        locals_for_with.b64img :
        typeof b64img !== 'undefined' ? b64img : undefined, "blockLoader" in locals_for_with ?
        locals_for_with.blockLoader :
        typeof blockLoader !== 'undefined' ? blockLoader : undefined, "cssLoader" in locals_for_with ?
        locals_for_with.cssLoader :
        typeof cssLoader !== 'undefined' ? cssLoader : undefined, "decache" in locals_for_with ?
        locals_for_with.decache :
        typeof decache !== 'undefined' ? decache : undefined, "escape" in locals_for_with ?
        locals_for_with.escape :
        typeof escape !== 'undefined' ? escape : undefined, "prefix" in locals_for_with ?
        locals_for_with.prefix :
        typeof prefix !== 'undefined' ? prefix : undefined, "scriptLoader" in locals_for_with ?
        locals_for_with.scriptLoader :
        typeof scriptLoader !== 'undefined' ? scriptLoader : undefined, "version" in locals_for_with ?
        locals_for_with.version :
        typeof version !== 'undefined' ? version : undefined));
    ;} catch (err) {pug_rethrow(err, pug_debug_filename, pug_debug_line);};return pug_html;}; module.exports = template; })() 