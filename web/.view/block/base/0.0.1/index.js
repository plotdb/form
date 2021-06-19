 (function() { function pug_rethrow(e,n,r,t){if(!(e instanceof Error))throw e;if(!("undefined"==typeof window&&n||t))throw e.message+=" on line "+r,e;var o,a,i,s;try{t=t||require("fs").readFileSync(n,{encoding:"utf8"}),o=3,a=t.split("\n"),i=Math.max(r-o,0),s=Math.min(a.length,r+o)}catch(t){return e.message+=" - could not read from "+n+" ("+t.message+")",void pug_rethrow(e,null,r)}o=a.slice(i,s).map(function(e,n){var t=n+i+1;return(t==r?"  > ":"    ")+t+"| "+e}).join("\n"),e.path=n;try{e.message=(n||"Pug")+":"+r+"\n"+o+"\n\n"+e.message}catch(e){}throw e}function template(locals) {var pug_html = "", pug_mixins = {}, pug_interp;var pug_debug_filename, pug_debug_line;try {;pug_debug_line = 1;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"rounded-lg shadow mb-4\"\u003E";
;pug_debug_line = 2;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"p-4\"\u003E";
;pug_debug_line = 3;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"d-flex\"\u003E";
;pug_debug_line = 4;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"flex-grow-1\"\u003E";
;pug_debug_line = 5;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Ch3 ld=\"title\" contenteditable=\"true\"\u003E";
;pug_debug_line = 5;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "問題的標題\u003C\u002Fh3\u003E";
;pug_debug_line = 6;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cp contenteditable=\"true\"\u003E";
;pug_debug_line = 6;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "關於問題的簡單描述 ...\u003C\u002Fp\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 7;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv ld=\"edit-only\"\u003E";
;pug_debug_line = 8;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"ml-4\"\u003E";
;pug_debug_line = 8;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown\" ld=\"dropdown\"\u003E";
;pug_debug_line = 9;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"btn btn-light dropdown-toggle\" ld=\"shortname\" data-toggle=\"dropdown\"\u003E";
;pug_debug_line = 9;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "代稱\u003C\u002Fdiv\u003E";
;pug_debug_line = 10;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown-menu dropdown-menu-right\"\u003E";
;pug_debug_line = 11;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown-item\" ld=\"set-shortname\" data-value=\"統一編號\"\u003E";
;pug_debug_line = 11;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "統一編號\u003C\u002Fdiv\u003E";
;pug_debug_line = 12;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown-item\" ld=\"set-shortname\" data-value=\"電話\"\u003E";
;pug_debug_line = 12;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "電話\u003C\u002Fdiv\u003E";
;pug_debug_line = 13;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown-item\" ld=\"set-shortname\" data-value=\"團隊名稱\"\u003E";
;pug_debug_line = 13;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "團隊名稱\u003C\u002Fdiv\u003E";
;pug_debug_line = 14;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown-item px-2\"\u003E";
;pug_debug_line = 14;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cinput class=\"form-control\" ld=\"custom-shortname\" placeholder=\"自訂 ...\"\u002F\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 15;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cplug name=\"view\"\u003E\u003C\u002Fplug\u003E";
;pug_debug_line = 16;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"text-danger py-2 d-none\" ld=\"error-hint\"\u003E";
;pug_debug_line = 16;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "輸入的值不符規定.\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 17;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"border-top border-bottom\" ld=\"edit-only\"\u003E";
;pug_debug_line = 18;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"m-4\"\u003E";
;pug_debug_line = 19;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"d-flex mb-1 align-items-center justify-content-between\" ld-each=\"term\"\u003E";
;pug_debug_line = 20;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mr-2\"\u003E";
;pug_debug_line = 20;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"switch switch-lg\" ld=\"enabled\"\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 21;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mr-2\"\u003E";
;pug_debug_line = 22;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown\" ld=\"dropdown\"\u003E";
;pug_debug_line = 23;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"btn btn-light dropdown-toggle\" ld=\"opset\" data-toggle=\"dropdown\"\u003E";
;pug_debug_line = 23;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "...\u003C\u002Fdiv\u003E";
;pug_debug_line = 24;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown-menu\"\u003E";
;pug_debug_line = 25;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown-item\" ld-each=\"set-opset\"\u003E";
;pug_debug_line = 25;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "...\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 26;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mr-2\"\u003E";
;pug_debug_line = 26;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown\" ld=\"dropdown\"\u003E";
;pug_debug_line = 27;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"btn btn-light dropdown-toggle\" ld=\"op\" data-toggle=\"dropdown\"\u003E";
;pug_debug_line = 27;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "...\u003C\u002Fdiv\u003E";
;pug_debug_line = 28;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown-menu\"\u003E";
;pug_debug_line = 29;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"dropdown-item\" ld-each=\"set-op\"\u003E";
;pug_debug_line = 29;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "...\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 35;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mr-2\"\u003E";
;pug_debug_line = 35;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cinput class=\"form-control simple\" placeholder=\"值 1\"\u002F\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 36;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mr-2\"\u003E";
;pug_debug_line = 36;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cinput class=\"form-control simple\" placeholder=\"值 2\"\u002F\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 37;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mr-2 flex-grow-1\"\u003E";
;pug_debug_line = 38;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cinput class=\"form-control simple\" ld=\"t\" t=\"error message\" t-attr=\"placeholder\"\u002F\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 39;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Ci class=\"i-close text-danger clickable\" ld=\"delete\"\u003E\u003C\u002Fi\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 40;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mt-4\"\u003E";
;pug_debug_line = 40;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"btn btn-link p-0\" ld=\"add-term\"\u003E";
;pug_debug_line = 40;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "";
;pug_debug_line = 40;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cspan ld=\"t\" t=\"add criteria\"\u003E\u003C\u002Fspan\u003E";
;pug_debug_line = 40;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + " ...\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 41;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"p-4\" ld=\"edit-only\"\u003E";
;pug_debug_line = 42;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"d-flex align-items-center\"\u003E";
;pug_debug_line = 43;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mr-2\"\u003E";
;pug_debug_line = 43;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"btn btn-sm btn-outline-danger\" ld=\"delete\"\u003E";
;pug_debug_line = 43;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "";
;pug_debug_line = 43;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Ci class=\"i-close\"\u003E\u003C\u002Fi\u003E";
;pug_debug_line = 43;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + " ";
;pug_debug_line = 43;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cspan ld=\"t\" t=\"delete\"\u003E\u003C\u002Fspan\u003E";
;pug_debug_line = 43;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 44;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"mr-2\"\u003E";
;pug_debug_line = 44;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"btn btn-sm btn-outline-secondary\" ld=\"clone\"\u003E";
;pug_debug_line = 44;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "";
;pug_debug_line = 44;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Ci class=\"i-clone\"\u003E\u003C\u002Fi\u003E";
;pug_debug_line = 44;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + " ";
;pug_debug_line = 44;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cspan ld=\"t\" t=\"copy\"\u003E\u003C\u002Fspan\u003E";
;pug_debug_line = 44;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 45;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"flex-grow-1 justify-content-end d-flex\"\u003E";
;pug_debug_line = 46;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"ml-4 d-flex align-items-center line-height-1em\"\u003E";
;pug_debug_line = 47;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cspan ld=\"t\" t=\"public\"\u003E\u003C\u002Fspan\u003E";
;pug_debug_line = 48;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"switch ml-2\" ld=\"switch\" data-name=\"isPublic\"\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 49;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"ml-4 d-flex align-items-center line-height-1em\"\u003E";
;pug_debug_line = 50;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cspan ld=\"t\" t=\"required\"\u003E\u003C\u002Fspan\u003E";
;pug_debug_line = 51;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"switch ml-2 on\" ld=\"switch\" data-name=\"isRequired\"\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 52;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"ml-4 d-flex align-items-center line-height-1em\"\u003E";
;pug_debug_line = 53;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cspan ld=\"t\" t=\"show description\"\u003E\u003C\u002Fspan\u003E";
;pug_debug_line = 54;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cdiv class=\"switch ml-2\" ld=\"switch\" data-name=\"showDesc\"\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E\u003C\u002Fdiv\u003E";
;pug_debug_line = 56;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "\u003Cscript type=\"@plotdb\u002Fblock\"\u003E";
;pug_debug_line = 56;pug_debug_filename = "src\u002Fpug\u002Fblock\u002Fbase\u002F0.0.1\u002Findex.pug";
pug_html = pug_html + "({\n  pkg: {\n    name: \"base\",\n    version: \"0.0.1\",\n    dependencies: [\n      {\n        url: \"\u002Fassets\u002Flib\u002Fbootstrap.native\u002Fmain\u002Fbootstrap-native-v4.min.js\"\n      }, {\n        url: \"\u002Fassets\u002Flib\u002F@plotdb\u002Fsuuid\u002Fmain\u002Fsuuid.bundle.min.js\"\n      }, {\n        url: \"\u002Fassets\u002Flib\u002Fform\u002Fdev\u002Fop.js\"\n      }, {\n        url: \"\u002Fassets\u002Flib\u002Fldview\u002Fmain\u002Findex.min.js\"\n      }\n    ],\n    i18n: {\n      \"zh-TW\": {\n        string: \"文字\",\n        include: \"包含\",\n        exclude: \"排除\",\n        email: \"電子郵件\",\n        required: \"必填\",\n        \"show description\": \"顯示描述\",\n        'public': \"公開\",\n        \"add criteria\": \"增加條件\",\n        \"error message\": \"錯誤訊息\"\n      }\n    }\n  },\n  'interface': function(){\n    return this;\n  },\n  init: function(opt){\n    var ref$, BSN, ldview, suuid, form, t, data, opset, view, this$ = this;\n    opt == null && (opt = {});\n    ref$ = opt.context, BSN = ref$.BSN, ldview = ref$.ldview, suuid = ref$.suuid, form = ref$.form;\n    t = opt.t;\n    opt.pubsub.on('init', function(){});\n    this.data = data = {\n      config: {},\n      key: suuid()\n    };\n    this.mode = opt.data.mode;\n    this.node = function(){\n      return opt.root.querySelector('[ld-scope][plug=view]');\n    };\n    this.value = function(v, source){\n      source == null && (source = false);\n      if (v != null) {\n        this._value = v;\n        this.verify();\n      }\n      if (!source) {\n        opt.pubsub.fire('change', this._value);\n      }\n      return this._value;\n    };\n    this.verify = function(){\n      var this$ = this;\n      return Promise.all(this.data.term.map(function(it){\n        return it.verify(this$._value);\n      })).then(function(it){\n        return it.reduce(function(a, b){\n          return a && b;\n        }, true);\n      }).then(function(it){\n        this$.hasError = !it;\n        return view.render();\n      });\n    };\n    this.setMode = function(it){\n      this$.mode = it;\n      return this$.view.render();\n    };\n    this.serialize = function(){\n      var ref$, ret, ref1$;\n      ret = (ref1$ = {}, ref1$.key = (ref$ = this$.data).key, ref1$.title = ref$.title, ref1$.desc = ref$.desc, ref1$);\n      ret.config = JSON.parse(JSON.stringify(this$.data.config || {}));\n      ret.term = this$.data.term.map(function(it){\n        return it.serialize();\n      });\n      return ret;\n    };\n    opset = new form.opset({\n      id: 'string',\n      ops: {\n        include: function(v, c){\n          return ~(\"\" + (v || '')).indexOf('test');\n        },\n        exclude: function(v, c){\n          return !~(\"\" + (v || '')).indexOf('test');\n        },\n        email: function(v){\n          return \u002F^[^@]+@[^@]+$\u002F.exec(v);\n        }\n      }\n    });\n    return this.view = view = new ldview({\n      root: opt.root,\n      action: {\n        input: {\n          title: function(arg$){\n            var node, ctx;\n            node = arg$.node, ctx = arg$.ctx;\n            return data.title = node.value || '';\n          },\n          desc: function(arg$){\n            var node, ctx;\n            node = arg$.node, ctx = arg$.ctx;\n            return data.desc = node.value || '';\n          },\n          \"custom-shortname\": function(arg$){\n            var node, views;\n            node = arg$.node, views = arg$.views;\n            data.alias = node.value || '';\n            return views[0].render();\n          }\n        },\n        click: {\n          \"set-shortname\": function(arg$){\n            var node, views;\n            node = arg$.node, views = arg$.views;\n            data.alias = node.getAttribute('data-value') || '';\n            return views[0].render();\n          },\n          \"custom-shortname\": function(arg$){\n            var evt;\n            evt = arg$.evt;\n            return evt.stopPropagation();\n          },\n          \"add-term\": function(arg$){\n            var views;\n            views = arg$.views;\n            (data.term || (data.term = [])).push(new form.term({\n              opset: opset\n            }));\n            this$.verify();\n            return views[0].render('term');\n          },\n          'switch': function(arg$){\n            var node, n;\n            node = arg$.node;\n            n = node.getAttribute('data-name');\n            if (!(n === 'isPublic' || n === 'isRequired' || n === 'showDesc')) {\n              return;\n            }\n            (data.config || (data.config = {}))[n] = !data.config[n];\n            return view.render();\n          }\n        }\n      },\n      init: {\n        dropdown: function(arg$){\n          var node;\n          node = arg$.node;\n          return new BSN.Dropdown(node);\n        }\n      },\n      text: {\n        \"shortname\": function(){\n          return data.alias || '設定代稱..';\n        }\n      },\n      handler: {\n        \"error-hint\": function(arg$){\n          var node;\n          node = arg$.node;\n          return node.classList.toggle('d-none', this$.mode === 'edit' || !this$.hasError);\n        },\n        \"edit-only\": function(arg$){\n          var node;\n          node = arg$.node;\n          return node.classList.toggle('d-none', this$.mode !== 'edit');\n        },\n        \"set-shortname\": function(arg$){\n          var node;\n          node = arg$.node;\n          return node.classList.toggle('active', node.getAttribute('data-value') === data.alias);\n        },\n        \"custom-shortname\": function(arg$){\n          var node;\n          node = arg$.node;\n          return node.value = data.alias || '';\n        },\n        title: function(arg$){\n          var node;\n          node = arg$.node;\n          return node.value = data.title || '';\n        },\n        desc: function(arg$){\n          var node;\n          node = arg$.node;\n          return node.value = data.desc || '';\n        },\n        'switch': function(arg$){\n          var node, n;\n          node = arg$.node;\n          n = node.getAttribute('data-name');\n          if (!(n === 'isPublic' || n === 'isRequired' || n === 'showDesc')) {\n            return;\n          }\n          return node.classList.toggle('on', !!(data.config || (data.config = {}))[n]);\n        },\n        term: {\n          list: function(){\n            return data.term || (data.term = []);\n          },\n          view: {\n            action: {\n              click: {\n                enabled: function(arg$){\n                  var ctx, views;\n                  ctx = arg$.ctx, views = arg$.views;\n                  ctx.enabled = !ctx.enabled;\n                  return views[0].render();\n                },\n                'delete': function(arg$){\n                  var ctx, views;\n                  ctx = arg$.ctx, views = arg$.views;\n                  data.term.splice(data.term.indexOf(ctx), 1);\n                  return views[1].render('term');\n                }\n              },\n              change: {\n                attr: function(arg$){\n                  var node, ctx, views;\n                  node = arg$.node, ctx = arg$.ctx, views = arg$.views;\n                  ctx.opset = data.attr[node.value].opset;\n                  return views[0].render();\n                },\n                op: function(arg$){\n                  var node, views, ctx;\n                  node = arg$.node, views = arg$.views, ctx = arg$.ctx;\n                  ctx.op = form.opset.get(ctx.opset || 'number').getOp(node.value);\n                  return views[0].render();\n                }\n              }\n            },\n            init: {\n              dropdown: function(arg$){\n                var node;\n                node = arg$.node;\n                return new BSN.Dropdown(node);\n              }\n            },\n            text: {\n              opset: function(arg$){\n                var ctx;\n                ctx = arg$.ctx;\n                return t(!ctx.opset\n                  ? \"\"\n                  : ctx.opset.name || ctx.opset.id);\n              },\n              op: function(arg$){\n                var ctx;\n                ctx = arg$.ctx;\n                return t(!ctx.op\n                  ? \"\"\n                  : ctx.op.name || ctx.op.id);\n              }\n            },\n            handler: {\n              enabled: function(arg$){\n                var node, ctx;\n                node = arg$.node, ctx = arg$.ctx;\n                return node.classList.toggle('on', !!ctx.enabled);\n              },\n              \"set-op\": {\n                list: function(arg$){\n                  var ctx;\n                  ctx = arg$.ctx;\n                  return ctx.opset.getOps();\n                },\n                action: {\n                  click: function(arg$){\n                    var data, ctx, views;\n                    data = arg$.data, ctx = arg$.ctx, views = arg$.views;\n                    ctx.setOp(data.id);\n                    return views[0].render();\n                  }\n                },\n                handler: function(arg$){\n                  var node, data;\n                  node = arg$.node, data = arg$.data;\n                  node.textContent = t(data.name || data.id);\n                  return node.setAttribute('data-id', data.id);\n                }\n              },\n              \"set-opset\": {\n                list: function(){\n                  return [opset];\n                },\n                action: {\n                  click: function(arg$){\n                    var data, ctx, views;\n                    data = arg$.data, ctx = arg$.ctx, views = arg$.views;\n                    if (ctx.opset.id === data.id) {\n                      return;\n                    }\n                    ctx.setOpset(data);\n                    return views[0].render();\n                  }\n                },\n                handler: function(arg$){\n                  var node, data;\n                  node = arg$.node, data = arg$.data;\n                  node.textContent = t(data.name || data.id);\n                  return node.setAttribute('data-id', data.id);\n                }\n              }\n              \u002F*\n              \"op-option\":\n                list: ({ctx}) ~\u003E\n                  opset = form.opset.get(ctx.opset or 'number')\n                  [v for k,v of opset.ops]\n                handler: ({node, data}) -\u003E\n                  node.setAttribute \\value, data.id\n                  node.innerText = data.name\n              \"op-config\":\n                list: ({ctx}) -\u003E [{k,v} for k,v of ctx.{}op.config or {}]\n                key: -\u003E it.k\n                view:\n                  text:\n                    name: ({node, ctx}) -\u003E return ctx.k\n              *\u002F\n            }\n          }\n        }\n      }\n    });\n  }\n});\u003C\u002Fscript\u003E\u003C\u002Fdiv\u003E";} catch (err) {pug_rethrow(err, pug_debug_filename, pug_debug_line);};return pug_html;}; module.exports = template; })() 