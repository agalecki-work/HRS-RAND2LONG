%macro insert_datain_row;
/* Insert _datain_  row, if not included */

/* `_datain0_ may contain zero rows */
data _datain0_;
  set vars_map1 (keep=vout);
  if strip(upcase(vout)) = "_DATAIN_NAME_";
run;

data _NULL_;
if 0 then set _datain0_ nobs=n;
call symputx('nobs',n);
stop;
run;
%put no. of observations = &nobs;

%if &nobs = 0 %then %do; /* insert _DATAIN_  row */
data _temp_;
  array waves_list {*} $300 &waves_list;
  length tmpc $300;
  if 0 then set vars_map_template; 
    vout     = '_DATAIN_NAME_';
    **label    = 'Data input name';
    dispatch = strip(symget('DATAIN_NAME')); /* */
    *clength  = '$42';
    
    do i= 1 to dim(waves_list);
    tmpc = waves_list[i];
    if tmpc = "" then waves_list[i] = strip(dispatch);  **strip(symget('DATAIN_NAME'));
    end;
    output;
    drop tmpc i;
run;

data vars_map1;
  retain vout dispatch wave_pattern;
  set _temp_ vars_map1;
run;

%end;

%mend insert_datain_row;
