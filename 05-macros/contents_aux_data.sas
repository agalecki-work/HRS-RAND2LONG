%macro contents_aux_data;

/* Print contents of auxiliary datasets */

/*--- mapx_waves_info ---*/


Title "01.Contents of `mapx_waves_info` dataset ";
%contents_data(waves_info, print=N);
ods proclabel = "01.Data: mapx_waves_info(&sysdate)";
proc print data =contents contents = "contents"; 
var memname name  type length label format nobs;
run;

Title "01.Data `mapx_waves_info`(obs=20)";
ods proclabel = "01.Data: mapx_waves_info";
proc print data = waves_info(obs =20) contents = "obs=20"; 
run;

/* --- mapx_dictionary ---*/


Title "02.Data `mapx_dictionary2` (obs=20)";
ods proclabel = "02.Data: mapx_dictionary2";
proc print data = _dictionary2 (obs = 20) contents = "obs=20"; 
run;


/* --- mapx_vars_map ---*/

Title "03. Contents of `mapx_vars_map` dataset";
%contents_data(vars_map, print=N);
ods proclabel = "03.Data: mapx_vars_map";
proc print data =contents contents = "contents"; 
var memname name  type length label format nobs;
run;

Title "03. Data `mapx_vars_map` with _DATAIN_ row inserted (obs=20)";
ods proclabel = "03. Data: mapx_vars_map";
proc print data = vars_map(obs =20) contents = "obs=20"; 
run;

/* --- mapx_vars_map2 ---*/

Title "04.Contents of `mapx_vars_map2` dataset";
%contents_data(vars_map2, print=N);
ods proclabel = "04.Data: mapx_vars_map2";
proc print data =contents contents = "contents"; 
var memname name  type length label format nobs;
run;

Title "04.Data `mapx_vars_map2` with wave columns populated (obs=20)";
ods proclabel = "04.Data: mapx_vars_map2";
proc print data = vars_map2(obs =20) contents = "obs=20"; 
run;

/* --- mapx_mrg2 ---*/

Title "05.Contents of `mapx_mrg2` dataset";
%contents_data(mrg2, print=N);
ods proclabel = "05.Data: mapx_mrg2";
proc print data = contents contents = "contents"; 
var memname name  type length label format nobs;
run;

Title "05.Data `mapx_mrg2` with wave columns populated (obs=50)";
ods proclabel = "05.Data: mapx_mrg2";
proc print data = mrg2(obs =50) contents = "obs=50"; 
run;

%mend contents_aux_data;
