 (function() { function pug_rethrow(e,n,r,t){if(!(e instanceof Error))throw e;if(!("undefined"==typeof window&&n||t))throw e.message+=" on line "+r,e;var o,a,i,s;try{t=t||require("fs").readFileSync(n,{encoding:"utf8"}),o=3,a=t.split("\n"),i=Math.max(r-o,0),s=Math.min(a.length,r+o)}catch(t){return e.message+=" - could not read from "+n+" ("+t.message+")",void pug_rethrow(e,null,r)}o=a.slice(i,s).map(function(e,n){var t=n+i+1;return(t==r?"  > ":"    ")+t+"| "+e}).join("\n"),e.path=n;try{e.message=(n||"Pug")+":"+r+"\n"+o+"\n\n"+e.message}catch(e){}throw e}function template(locals) {var pug_html = "", pug_mixins = {}, pug_interp;var pug_debug_filename, pug_debug_line;try {;pug_debug_line = 1;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"rounded-lg shadow mb-4\"\u003E";
;pug_debug_line = 2;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"p-4\"\u003E";
;pug_debug_line = 3;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"d-flex\"\u003E";
;pug_debug_line = 4;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"flex-grow-1\"\u003E";
;pug_debug_line = 5;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Ch3 ld=\"title\" contenteditable=\"true\"\u003E";
;pug_debug_line = 5;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "問題的標題\u003C\u002Fh3\u003E";
;pug_debug_line = 6;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cp contenteditable=\"true\"\u003E";
;pug_debug_line = 6;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "關於問題的簡單描述 ...\u003C\u002Fp\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 7;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv\u003E";
;pug_debug_line = 8;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"ml-4\"\u003E";
;pug_debug_line = 8;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown\" ld=\"dropdown\"\u003E";
;pug_debug_line = 9;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"btn btn-light dropdown-toggle\" data-toggle=\"dropdown\"\u003E";
;pug_debug_line = 9;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "短名\u003C\u002Fdiv\u003E";
;pug_debug_line = 10;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown-menu dropdown-menu-right\"\u003E";
;pug_debug_line = 11;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown-item\"\u003E";
;pug_debug_line = 11;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "統一編號\u003C\u002Fdiv\u003E";
;pug_debug_line = 12;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown-item\"\u003E";
;pug_debug_line = 12;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "電話\u003C\u002Fdiv\u003E";
;pug_debug_line = 13;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown-item\"\u003E";
;pug_debug_line = 13;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "團隊名稱\u003C\u002Fdiv\u003E";
;pug_debug_line = 14;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown-item\"\u003E";
;pug_debug_line = 14;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cinput class=\"form-control\" placeholder=\"自訂 ...\"\u002F\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 16;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cplug name=\"view\"\u003E\u003C\u002Fplug\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 17;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"border-top border-bottom\"\u003E";
;pug_debug_line = 18;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"m-4\"\u003E";
;pug_debug_line = 19;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"d-flex mb-1 align-items-center justify-content-between\" ld-each=\"criteria\"\u003E";
;pug_debug_line = 20;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mr-2\"\u003E";
;pug_debug_line = 20;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"switch switch-lg\" ld=\"enabled\"\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 21;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mr-2\"\u003E";
;pug_debug_line = 21;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown\" ld=\"dropdown\"\u003E";
;pug_debug_line = 22;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"btn btn-light dropdown-toggle\" data-toggle=\"dropdown\"\u003E";
;pug_debug_line = 22;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "數值\u003C\u002Fdiv\u003E";
;pug_debug_line = 23;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown-menu\"\u003E";
;pug_debug_line = 24;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown-item\"\u003E";
;pug_debug_line = 24;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "字串\u003C\u002Fdiv\u003E";
;pug_debug_line = 25;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown-item\"\u003E";
;pug_debug_line = 25;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "列表\u003C\u002Fdiv\u003E";
;pug_debug_line = 26;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown-item\"\u003E";
;pug_debug_line = 26;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "檔案大小\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 27;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mr-2\"\u003E";
;pug_debug_line = 27;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown\" ld=\"dropdown\"\u003E";
;pug_debug_line = 28;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"btn btn-light dropdown-toggle\" data-toggle=\"dropdown\"\u003E";
;pug_debug_line = 28;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "≧ 大於或等於\u003C\u002Fdiv\u003E";
;pug_debug_line = 29;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown-menu\"\u003E";
;pug_debug_line = 30;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown-item\"\u003E";
;pug_debug_line = 30;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "≦ 小於或等於\u003C\u002Fdiv\u003E";
;pug_debug_line = 31;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown-item\"\u003E";
;pug_debug_line = 31;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "≠ 不等於\u003C\u002Fdiv\u003E";
;pug_debug_line = 32;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown-item\"\u003E";
;pug_debug_line = 32;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "= 等於\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 33;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mr-2\"\u003E";
;pug_debug_line = 33;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cinput class=\"form-control simple\" placeholder=\"值 1\"\u002F\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 34;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mr-2\"\u003E";
;pug_debug_line = 34;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cinput class=\"form-control simple\" placeholder=\"值 2\"\u002F\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 35;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Ci class=\"i-close text-danger clickable\" ld=\"delete\"\u003E\u003C\u002Fi\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 36;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mt-4\"\u003E";
;pug_debug_line = 36;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"btn btn-link p-0\" ld=\"add-criteria\"\u003E";
;pug_debug_line = 36;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "增加條件 ...\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 37;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"p-4\"\u003E";
;pug_debug_line = 38;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"d-flex align-items-center\"\u003E";
;pug_debug_line = 39;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mr-2\"\u003E";
;pug_debug_line = 39;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"btn btn-sm btn-outline-danger\" ld=\"delete\"\u003E";
;pug_debug_line = 39;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "";
;pug_debug_line = 39;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Ci class=\"i-close\"\u003E\u003C\u002Fi\u003E";
;pug_debug_line = 39;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + " 刪除\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 40;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mr-2\"\u003E";
;pug_debug_line = 40;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"btn btn-sm btn-outline-secondary\" ld=\"clone\"\u003E";
;pug_debug_line = 40;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "";
;pug_debug_line = 40;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Ci class=\"i-clone\"\u003E\u003C\u002Fi\u003E";
;pug_debug_line = 40;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + " 複製\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 41;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"flex-grow-1 justify-content-end d-flex\"\u003E";
;pug_debug_line = 42;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"ml-4 d-flex align-items-center line-height-1em\"\u003E";
;pug_debug_line = 42;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "公開 ";
;pug_debug_line = 42;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"switch ml-2\" ld=\"switch\" data-name=\"isPublic\"\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 42;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003C\u002Fdiv\u003E";
;pug_debug_line = 43;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"ml-4 d-flex align-items-center line-height-1em\"\u003E";
;pug_debug_line = 43;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "必填 ";
;pug_debug_line = 43;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"switch ml-2 on\" ld=\"switch\" data-name=\"isRequired\"\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 43;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003C\u002Fdiv\u003E";
;pug_debug_line = 44;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"ml-4 d-flex align-items-center line-height-1em\"\u003E";
;pug_debug_line = 44;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "顯示描述 ";
;pug_debug_line = 44;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"switch ml-2\" ld=\"switch\" data-name=\"showDesc\"\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 44;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 46;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cscript type=\"@plotdb\u002Fblock\"\u003E";
;pug_debug_line = 46;pug_debug_filename = "src\u002Fpug\u002Fblock\u002F@plotdb\u002Fformbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "({\n  pkg: {\n    name: \"@plotdb\u002Fbase\",\n    version: \"0.0.1\",\n    dependencies: [{\n      url: \"\u002Fassets\u002Flib\u002Fbootstrap.native\u002Fmain\u002Fbootstrap-native.min.js\"\n    }]\n  },\n  init: function(arg$){\n    var root, context, BSN;\n    root = arg$.root, context = arg$.context;\n    BSN = context.BSN;\n    return function(it){\n      return new it();\n    }(function(){\n      var _, view, this$ = this;\n      this.root = root;\n      _ = this.data = {};\n      return this.view = view = new ldView({\n        root: this.root,\n        action: {\n          input: {\n            title: function(arg$){\n              var node;\n              node = arg$.node;\n              return _.title = node.value || '';\n            },\n            desc: function(arg$){\n              var node;\n              node = arg$.node;\n              return _.desc = node.value || '';\n            },\n            value: function(arg$){\n              var node;\n              node = arg$.node;\n              _.value = node.value;\n              return _.criteria.map(function(){\n                return form.term;\n              });\n            }\n          },\n          click: {\n            \"add-criteria\": function(){\n              (_.criteria || (_.criteria = [])).push({});\n              return this$.view.render('criteria');\n            },\n            'switch': function(arg$){\n              var node, n;\n              node = arg$.node;\n              n = node.getAttribute('data-name');\n              if (!(n === 'isPublic' || n === 'isRequired' || n === 'showDesc')) {\n                return;\n              }\n              _[n] = !_[n];\n              return view.render();\n            }\n          }\n        },\n        init: {\n          dropdown: function(arg$){\n            var node;\n            node = arg$.node;\n            return new BSN.Dropdown(node);\n          }\n        },\n        handler: {\n          title: function(arg$){\n            var node;\n            node = arg$.node;\n            return node.value = _.title || '';\n          },\n          desc: function(arg$){\n            var node;\n            node = arg$.node;\n            return node.value = _.desc || '';\n          },\n          'switch': function(arg$){\n            var node, n;\n            node = arg$.node;\n            n = node.getAttribute('data-name');\n            if (!(n === 'isPublic' || n === 'isRequired' || n === 'showDesc')) {\n              return;\n            }\n            return node.classList.toggle('on', !!_[n]);\n          },\n          attr: {\n            list: function(){\n              var k, v;\n              return (function(){\n                var ref$, results$ = [];\n                for (k in ref$ = _.attr) {\n                  v = ref$[k];\n                  results$.push({\n                    k: k,\n                    v: v\n                  });\n                }\n                return results$;\n              }()) || [];\n            },\n            handler: function(arg$){\n              var node, data;\n              node = arg$.node, data = arg$.data;\n              node.setAttribute('value', data.k);\n              return node.innerText = data.v.name;\n            }\n          },\n          criteria: {\n            list: function(){\n              return _.criteria || [];\n            },\n            view: {\n              action: {\n                click: {\n                  enabled: function(arg$){\n                    var context;\n                    context = arg$.context;\n                    context.enabled = !context.enabled;\n                    return this$.view.render('criteria');\n                  },\n                  'delete': function(arg$){\n                    var context;\n                    context = arg$.context;\n                    _.criteria.splice(_.criteria.indexOf(context), 1);\n                    return this$.view.render('criteria');\n                  }\n                },\n                change: {\n                  attr: function(arg$){\n                    var node, context;\n                    node = arg$.node, context = arg$.context;\n                    context.opset = _.attr[node.value].opset;\n                    return view.render('criteria');\n                  },\n                  op: function(arg$){\n                    var node, context;\n                    node = arg$.node, context = arg$.context;\n                    context.op = form.opset.get(context.opset || 'number').getOp(node.value);\n                    return view.render('criteria');\n                  }\n                }\n              },\n              init: {\n                dropdown: function(arg$){\n                  var node;\n                  node = arg$.node;\n                  return new BSN.Dropdown(node);\n                }\n              },\n              handler: {\n                enabled: function(arg$){\n                  var node, context;\n                  node = arg$.node, context = arg$.context;\n                  return node.classList.toggle('on', !!context.enabled);\n                },\n                \"attr-option\": {\n                  list: function(){\n                    var k, v;\n                    return (function(){\n                      var ref$, results$ = [];\n                      for (k in ref$ = _.attr) {\n                        v = ref$[k];\n                        results$.push({\n                          k: k,\n                          v: v\n                        });\n                      }\n                      return results$;\n                    }()) || [];\n                  },\n                  key: function(it){\n                    return it.k;\n                  },\n                  handler: function(arg$){\n                    var node, data;\n                    node = arg$.node, data = arg$.data;\n                    node.setAttribute('value', data.k);\n                    return node.innerText = data.v.name;\n                  }\n                },\n                \"op-option\": {\n                  list: function(arg$){\n                    var context, opset, k, ref$, v, results$ = [];\n                    context = arg$.context;\n                    opset = form.opset.get(context.opset || 'number');\n                    for (k in ref$ = opset.ops) {\n                      v = ref$[k];\n                      results$.push(v);\n                    }\n                    return results$;\n                  },\n                  handler: function(arg$){\n                    var node, data;\n                    node = arg$.node, data = arg$.data;\n                    node.setAttribute('value', data.id);\n                    return node.innerText = data.name;\n                  }\n                },\n                \"op-config\": {\n                  list: function(arg$){\n                    var context, k, ref$, v, results$ = [];\n                    context = arg$.context;\n                    for (k in ref$ = (context.op || (context.op = {})).config || {}) {\n                      v = ref$[k];\n                      results$.push({\n                        k: k,\n                        v: v\n                      });\n                    }\n                    return results$;\n                  },\n                  key: function(it){\n                    return it.k;\n                  },\n                  view: {\n                    text: {\n                      name: function(arg$){\n                        var node, context;\n                        node = arg$.node, context = arg$.context;\n                        return context.k;\n                      }\n                    }\n                  }\n                }\n              }\n            }\n          }\n        }\n      });\n    });\n  }\n});\u003C\u002Fscript\u003E\u003C\u002Fdiv\u003E";} catch (err) {pug_rethrow(err, pug_debug_filename, pug_debug_line);};return pug_html;}; module.exports = template; })() 