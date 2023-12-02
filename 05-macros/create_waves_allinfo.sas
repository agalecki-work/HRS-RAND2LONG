%macro create_waves_allinfo;

/* Use `vars_map2?` dataset to  create `waves_info` dataset  */

data _datain0_;
  set vars_map(keep= vout &waves_list);
  if strip(upcase(vout)) = "_DATAIN_NAME_";
run;

proc transpose data = _datain0_
   out =  waves_allinfo(drop=_label_ rename =(col1= datain_name))
   name = wave_name;
 var &waves_list;
run;

data waves_allinfo;

 length wave_no 8;
 label wave_no = "Wave number";
 /*--- length wave_name $ 32; ---*/
 label wave_name = "Wave name";
 /* length datain_name $ 42; */
 length wave_mcall $100;
 label datain_name = "Input data name";
 label wave_mcall =  "Call to process_wave macro";
 set waves_allinfo;
 length cx $5;
 wave_no = _n_;
 cx = put(_n_,3.);
 datain_name = translate(datain_name, "", "'");
 wave_mcall =  '%_' || strip(wave_name);
 drop cx;
run;


/*--- Number of all waves ---*/
%let wave_max_no = %attrn_nlobs(waves_allinfo);
%put wave_max_no := wave_max_no;

%mend create_waves_allinfo;
