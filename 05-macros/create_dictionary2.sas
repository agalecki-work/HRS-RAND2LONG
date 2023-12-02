%macro create_dictionary2;

/* Create extract list of input datasets from `waves_info` */


proc sort data= waves_info out = _datain(keep = datain_name) nodupkey;
by datain_name;
run;

data _datain;
 set _datain;
 datain_no = _n_;
run;

proc sort data=waves_info;
by datain_name;
run;

proc sort data=_datain;
by datain_name;
run;

data  waves_info2;
  retain datain_no datain_name wave_no wave_name wave_mcall;
  merge waves_info _datain;
  by datain_name;
run;

proc sort data=waves_info2;
 by datain_no;
run;

/* One row per datain dataset */
data datain_info ;
  set waves_info2(keep = datain_no datain_name);
  by datain_no;
  if first.datain_no;
  length datain $42;
  datain = 'libin.'||datain_name; /* libin.datain_name */
  length aug_dict_exec $100;
  aug_dict_exec = '%aug_dict(' || strip(datain_no) || "," || strip(datain) || ")";
run;

/* Dataset `_dictionary2` _before_ adding datain variables */;
data _dictionary2;
  set _dictionary;
  name = lowcase(name);
run;


proc sort data = _dictionary2;
by name;
run;



data _null_;
 set datain_info;
 call execute(aug_dict_exec);
run;

%*aug_dict(1, libin.randhrs1992_2020v1);
proc sort data =  _dictionary2;
by varnum;
run;


%mend create_dictionary2;
