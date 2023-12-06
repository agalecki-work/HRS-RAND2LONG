* libin specifies the libref input dataset randhrs1992_2020v1_long.sas7bdat ;
libname libin "./out";  /*<===USER MUST modify*/

%let long_data = libin.randhrs1992_2020v1_long;

%let keys = RAHHIDPN studyyr;

%let time_invariant_vars= hacohort hhid pn hhidpn S_HHIDPN;


proc sort data = &long_data
          out  = long_sorted;
by &keys;
run;


data time_invariant_vars;
  set long_sorted (keep = RAHHIDPN studyyr &time_invariant_vars);
  by &keys;
  if first.RAHHIDPN;
  drop studyyr;
run;

data long0;
  /* drop time invariant vars */
 set  long_sorted (drop = &time_invariant_vars);
 if studyyr =. then delete;
run;

proc transpose data= long0 out= molten
          name  = _name_
          label =_label_;
 var _numeric_;
 by &keys;
run;

data molten2;
 set molten;
 missing _;
 length namex $32;
 length labelx $200;
 if lowcase(_name_) = "studyyr" then delete; /* redundant */ 
 namex =strip(_name_)||"_"||strip(studyyr);
 labelx=strip(_label_) || " (" || strip(studyyr) || ")";
 if col1 =._ then delete;
run;

*proc print data = molten2;
run;

/* https://communities.sas.com/t5/SAS-Programming/Converting-long-SAS-data-and-formats-and-label-info-into-wide/td-p/673705 */
proc transpose data = molten2 out=out_wide(drop =_name_) ;
var col1;
by RAHHIDPN;
id  namex;
idlabel labelx;
run;

data libin.out_wide;
  merge time_invariant_vars out_wide;
  by RAHHIDPN;
run;

ods listing exclude all;

ods html;
ods exclude all;
proc contents data = libin.out_wide position out= contents_wide;
run;

proc sort data = contents_wide;
by varnum;
run;

ods exclude none;

Title "PROC CONTENTS of `out_wide` data";
proc print data = contents_wide;
var name type length varnum label; 
run;
ods html close;
