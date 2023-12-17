%macro zzz_05main_execute;


%global HRS_RAND2LONG_version traceit vars_map;
%global waves_list waves_elist waves_sel wave_max_no;

%_usetup_mvars;
%***sanitize_vars;
%let DATAIN_NAME =&datain;
%global map_file waves_sel  waves_sel2;
%**global xlsx_fnm map_info;
%global aux_outpath;

%let waves_sel = %upcase(&waves_sel);
%put wave_sel := &waves_sel;
%let  waves_sel2 = %sysfunc(tranwrd(%quote(&waves_sel) ,TO, :));
%put wave_sel2 := &waves_sel2;


/*--- Includes macro definitions stored in  `_macros`  folder ---*/
data _MAP2Long;
 set &map_info;
run;



%if &traceit =Y %then %do;
 ods listing close;
 ods html  path =     "&aux_outpath" (URL=NONE)
           file =     "05-traceit-body.html"
           contents = "05-traceit-contents.html"
           frame =    "05-traceit-frame.html"
 ;
%end;

%put Macro `zzz_05main_execute` starts here;


data dictionary_init;
  set _MAP2Long(keep= varnum name label clength format);
run; 

/* Dataset `vars_map_init`  created from _MAP2Long*/
%if &vars_map = Y %then %create_vars_map_init;


/*---  Create `dictionary_template` dataset ---*/
%dictionary_template;

%if &traceit = Y %then 
   %traceit_contents(dictionary_template);

/*--- Create 'vars_map_template` dataset and `waves_elist` macro variable */
%if &vars_map = Y %then %do;
 %create_waves_elist(vars_map_init, &waves_list); /* & map_info */
 %vars_map_template;
 %put expanded waves_list := &waves_elist;
 
 %if &traceit = Y %then 
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

%if &traceit = Y %then 
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

 /*--- `waves_info` dataset  with one row per wave created `vars_map2`  */
 %create_waves_info;

/* Create `_dictionary2` dataset by adding `datain#` variables */
%create_dictionary2;

%end; /* if vars_map */


%if &vars_map = Y %then %create_mrg2;
 
%if &vars_map = Y %then
     %save_aux_data;

%**contents_aux_data; 

%if &traceit = Y %then %do;
  ods html close;
  ods listing;
%end;

%put :::;
%let n_vout = %attrn_nlobs(_dictionary);

data _null_;
  file map_file;
  put "/* Table: &tbl (&sysdate)*/";
run;

%macro needs_work;
data _null_;
  file map_file;
  *length map_info $ 200;
  length waves_list $200;
  length map_file $200;
  *map_info = symget('map_info');
  waves_list = symget('waves_list');
  map_file = symget('map_file');
  
  put / "/*========================";
  put "File name: " map_file;
  put "   File was generated by script:";
  put "     `05-create-macros.sas`. Version: &HRS_RAND2LONG_version";
  put "      executed on &sysdate..";
   *put "   Excel spreadsheet with map info:"  @40 map_info;
  put "   Waves list: " waves_list;

  *** put / "MAP_INFO dataset(input): `&vars_map`";
  put / " List of macros defined in this file: ";
  put;
  put "  - clength_statements (invoked by `create_template_longout` macro)";
  put "  - label_statements   (invoked by `create_template_longout` macro)";
  put "  - format_statements  (invoked by `create_template_longout` macro)";
  put "  - create_template_longout (creates data template)";
  put;  
  put "  - _datain_varsinit1 (invoked by `preprocess_wave` macro)";
  put "  - preprocess_wave (invoked by _hrs_wave[#] macros)";
  put "  - postprocess_wave (invoked by _hrs_wave[#] macros.  if INW =1 then output)";
  put "  - _hrs_wave[#] macros (invoked by `process_selected_waves` macro)";
  put;  
  put "  - preprocess_datain1 (place holder, invoked by `create_outdata(datain)`)";
  put "  - process_selected_waves (invoked by `create_outdata`)";
  put "  - keepvar_statement (invoked by `postprocess_dataout` macro)"; 
  put "  - postprocess_dataout (invoked by `create_outdata`)";
  put "  - create_outdata macro defined elsewhere";
  put "===========================*/" /;
run;
%mend needs_work;



/* clength_statements */

data _null_;
  file map_file mod ;
  set _dictionary  end = eof;
  length clen1 $1;
  length clen2 $5;
   if _n_=1 then do;
     /*--- Length statements for character vars  ----*/
     put / '%macro clength_statements;';
     put "/* Length statements for character vars */";
   end;
   
     
   clen1 = "N"; /* By default numeric */
   clen2 = strip(clength);
   if clength ne "" then do;
     clen1  = substr(clength, 1, 1);
     if clen1 = "$" then clen1 = "Y";
     clen2  = translate(clength, "", "$");  /* $ suppressed */ 
     if clen1 ="Y" then put @3 'length ' name clength +(-1) ";"  @45 "/* _" varnum "*/"; 
   end;
 
   if eof then do; 
     put '%mend clength_statements;';
     put /;
   end;
run;



/*--- Label statements ---*/

data _null_;
  file map_file mod ;
  set _dictionary end = eof;
   if _n_=1 then do;
     /* Generate label statements*/
     put '%macro label_statements;';
     put "/* Label statements for &n_vout variables */";
   end;
    if mod(varnum, 10) = 0 then 
     put / @2 "/* --Variable " name ": # _" varnum "*/";  
    put @3  'label ' name ' = "' label +(-1) '";';
   if eof then put '%mend label_statements;';
run;


/*--- Format statements ---*/

data _fmts;
  set _dictionary(keep=name format varnum);
  if format ="" then delete;
run;

%let nfmts = %attrn_nlobs(_fmts);

data _null_;
  file map_file mod ;
  set _fmts  end = eof;
   if _n_=1 then do;
     /* Generate format statements*/
     put / '%macro format_statements;';
     put "/* format statements for &nfmts variables */";
   end;
   put @3  'format ' name  format +(-1) ';' @45 "/* _" varnum "*/" ;
   if eof then put '%mend format_statements;';
run;

/*---  `template_long_data` --- */

data _null_;
  file map_file mod;
  put / '%macro create_template_longout;';
  put '/* Macro creates  `_template_longout` */;' ; 
  put 'data _template_longout;';
  put @3 'missing A B C D E F G H I J;';
  put @3 'missing K L M N O P Q R S T;';
  put @3 'missing U V X Y Z;';
  put @3 'missing _; /* _ reserved for variables not defined in map_info */'; 
  put @3 '%label_statements;';
  put @3 '%clength_statements;';
  put @3 '%format_statements;';
  put @3 'call missing(of _all_);';
  put @3 'stop;';
  put 'run;';
  put '%mend create_template_longout;';
run;


/*--- Keepvar list ---*/

%let nkeep = %attrn_nlobs(_dictionary);
data _null_;
  file map_file mod ;
  set _dictionary  end = eof;
   if _n_=1 then do;
     /* Generate list of vars to keep */
     put / '%macro keepvar_list;';
     put "/* Keep statement for &nkeep variables */";
   end;
   put @3  name;
   if eof then do; 
     put '%mend keepvar_list;';
   end;
run;

%put --- vars_map := &vars_map;
%if &vars_map = Y %then %do;
  %put_mrg2_stmnts; /* set mrg2 */

/* Macro `process_selected_waves` */
/* Uses info stored in `_waves_selected` SAS dataset */

data _null_;
 file map_file mod;
 set waves_info end= eof;
  if _n_ =1 then do;
    put '%macro process_selected_waves;';
    put '/* Process selected waves */';
  end;
  put @3 wave_mcall +(-1) ";";
  if eof then put '%mend process_selected_waves;' /; 
run;

data _null_;
 file map_file mod;
    put '%macro postprocess_wave;';
    put '/* Post process wave */';
  put @3 'if INW =1 then output;'; 
  put '%mend postprocess_wave;' /; 
run;

data _null_;
 file map_file mod;
    put '%macro preprocess_wave;';
    put '/* Preprocess wave */';
  put @3 '%_datain_varsinit1;'; 
  put '%mend preprocess_wave;' /; 
run;

%*put_init_vars(1,  libin.randhrs1992_2020v1);

/* Macros `init_vars_datain` (One macro per dataset) will be generated */
/* Uses info stored in `_datain` SAS dataset */

data _datain;
 set _datain;
 length stmnt1 stmnt2  $200;
   stmnt1 = '%'|| 'put_init_vars(' ||  strip(put(datain_no, 3.)) || "," || strip(datain_name) || ")";
   stmnt2 = '%'|| 'put_preprocess_datain(' ||  strip(put(datain_no,3.)) || "," || strip(datain_name) || ")";
   put stmnt1 =;
   put stmnt2 =;
 *call execute(stmnt);
run;

data _null_;
 set _datain;
 call execute(stmnt1);
run;

data _null_;
 set _datain;
 call execute(stmnt2);
run;

%put_postprocess_dataout;
filename map_file clear;
%end; /*if */
%put Macro `zzz_05main_execute` ends here;

%mend zzz_05main_execute;