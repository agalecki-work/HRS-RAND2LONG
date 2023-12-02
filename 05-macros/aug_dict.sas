%macro aug_dict(dtin_no, dtin);
/* Augment _dictionary */

proc contents data = &dtin out = dtin_contents(keep=name) noprint;
run;

%*contents_data(&dtin, print =N, out= dtin_contents);

data dtin_contents;
  set dtin_contents;
  name = lowcase(name);
run;

proc sort data = dtin_contents;
by name;
run;
 

data _dictionary2;
 merge _dictionary2 (in=in1) dtin_contents (in= in2);
 by name;
 if in1;
 label datain&dtin_no = "&dtin";
 datain&dtin_no = in2;
run;



%mend aug_dict;