%macro _YE_block;
 %create_vars_map1;
 
 %if (&vars_map = Y or &vars_map = E ) %then %do;
 
 /*--- `waves_allinfo` dataset  with one row per wave created  */
 %create_waves_allinfo;
 
 /* DATA `vars_map2`: key: stmnt_no,  contains_DATAIN_ row */
 %create_vars_map2; 
 
 /*--- `waves_info` dataset  with one row per wave created `vars_map2`  */
 %create_waves_info;

/* Create `_dictionary2` dataset by adding `datain#` variables */
%create_dictionary2;

%end; /* if vars_map */


%if (&vars_map = Y or &vars_map = E) %then %create_mrg2;
 
%if (&vars_map = Y or &vars_map = E) %then
     %save_aux_data;

%**contents_aux_data; 



%mend _YE_block;