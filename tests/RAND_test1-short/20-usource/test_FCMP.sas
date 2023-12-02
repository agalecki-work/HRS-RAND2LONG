options nocenter;

filename fcmp_src "./FCMP_src.sas";


proc fcmp outlib = work.RAND2LONG.all; /* 3 level name */
%**include fcmp_src;

function pattrn(wv_no , cx $) $;
 /* wv = 6 for year 2002 abc#def */ 
 clist = upcase("hjklmnopqrstuvwxyz");
 length tmpc $4; 
 tmpc = put(wv_no, 3.);
 res = tranwrd(strip(cx),'#', strip(tmpc));
 wv0 = wv_no -5;
 length c1 $1;
 if wv_no ge 6 then do;
  c1 = substr(clist,wv0,1);
  res = translate(res, c1, '@');
 end;
 return(res);
endsub;

run;
quit; /* FCMP */


options cmplib = work.RAND2LONG;


data dt;
 length wv cx $ 50;
 input wv cx;
 res = pattrn(wv,cx);
cards;
5 xyx#
5 @abc
5 @def#
6 xyx#
6 @abc
15 @def#
15 @abc
15 @def#
20 @def#
20 @abc
20 @def#

;
run:
proc print data =dt;
run;
endsas;

data test1;
wv = 1;
a_ = studyyr(wv, .);
a0 = studyyr(wv, 0);
a1 = studyyr(wv,1);
a3 = studyyr(wv,3);
output;

wv = 2;
a_ = studyyr(wv, .);

a0 = studyyr(wv,0);
a1 = studyyr(wv,1);
a3 = studyyr(wv,3);
output;

wv =3;
a_ = studyyr(wv, .);
a0 = studyyr(wv,0);
a1 = studyyr(wv,1);
a3 = studyyr(wv,3);
output;


wv = 4;
a_ = studyyr(wv, .);

a0 = studyyr(wv,0);
a1 = studyyr(wv,1);
a3 = studyyr(wv,3);
output;

wv =15;
a_ = studyyr(wv, .);
a0 = studyyr(wv,0);
a1 = studyyr(wv,1);
a3 = studyyr(wv,3);
output;

run;

proc print data=test1;
run;

data test2;
  height = 0.78;
  hx = height_m(height);
  output;
  
 height = 1.5;
 hx = height_m(height);
 output;
  
 height = 2.6;
 hx = height_m(height);
 output;

  ;

proc print data=test2;
run;



