%macro html_aux_report;

data dictionary_init;
  set _MAP2Long(keep= varnum name label clength format);
run; 

proc sql noprint;
alter table dictionary_init
  modify clength char(5) format = $5.;
quit;


/* Dataset `vars_map_init`  created from _MAP2Long*/
%if &vars_map = Y %then %create_vars_map_init;


/*---  Create `dictionary_template` dataset ---*/
%dictionary_template;

%traceit_contents(dictionary_template);

/*--- Create 'vars_map_template` dataset and `waves_elist` macro variable */
%if &vars_map = Y %then %do;
 %create_waves_elist(vars_map_init, &waves_list); /* & map_info */
 %vars_map_template;
 %put expanded waves_list := &waves_elist;
 %traceit(vars_map_template);
%end; /* ifvars_map */


/* Dataset `_dictionary`: */


data _dictionary;
 if 0 then set dictionary_template; 
 set dictionary_init;
  length c1 $1;
   * varnum = _n_;
   name_valid = nvalid(name, 'v7'); 
   if clength ne "" then c1 = substr(strip(clength),1);
   if c1 =":" then clength = substr(clength,2);
   if clength ne "" then c1 = substr(strip(clength),1);
   if c1 ="`" then clength = substr(clength,2);

   drop c1;
 run;

   %traceit(_dictionary);


/* Check for duplicate names in `_dictionary` dataset  */
/* Datasets: `_FREQ_DUPKEY_` `_MRGD_DUPKEY_` created */
/* They should have zero observations */
%checkdupkey(_dictionary, name);

%if &vars_map = Y %then %do;
  %create_vars_map1;
 
 /*--- `waves_allinfo` dataset  with one row per wave created  */
 %create_waves_allinfo;
 
 /* DATA `vars_map2`: key: stmnt_no,  contains_DATAIN_ row */
 %create_vars_map2; 
 
 %traceit(vars_map2);

 /*--- `waves_info` dataset  with one row per wave created `vars_map2`  */
 %create_waves_info;

/* Create `_dictionary2` dataset by adding `datain#` variables */
%create_dictionary2;

%end; /* if vars_map */


%if &vars_map = Y %then %create_mrg2;
 
%if &vars_map = Y %then
     %save_aux_data;

%**contents_aux_data; 



%mend html_aux_report;
