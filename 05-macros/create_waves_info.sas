
%macro create_waves_info;
%let tmp = (&waves_sel2); /* Selected waves */
%put tmp := &tmp;
data waves_info;
 set waves_allinfo;
 if wave_no in &tmp;
run;
 
%traceit(waves_info);


%mend create_waves_info;
