%macro zzz_05main_execute;

%if &traceit =Y %then %do;
 ods listing close;
 ods html  path =     "&aux_outpath" (URL=NONE)
           file =     "05-traceit-body.html"
           contents = "05-traceit-contents.html"
           frame =    "05-traceit-frame.html"
 ;
%end;

%put Macro `zzz_05main_execute` starts here;
/*---  Create `dictionary_template` dataset ---*/
%dictionary_template;

%if &traceit = Y %then 
   %traceit_contents(dictionary_template);

/*--- Create 'vars_map_template` dataset and `waves_elist` macro variable */

%vars_map_template(_MAP2Long, &waves_list); /* & map_info */
%put expanded waves_list := &waves_elist;
 
%if &traceit = Y %then 
   %traceit(vars_map_template);


/* Dataset `_dictionary`: */

data _dictionary;
 if 0 then set dictionary_template; 
 set _MAP2Long(keep= name label clength format);
  length c1 $1;
   varnum = _n_;
   name_valid = nvalid(name, 'v7'); 
   if clength ne "" then c1 = substr(strip(clength),1);
   if c1 ="`" then clength = translate(clength,'$','`');
   drop c1;
 run;

%if &traceit = Y %then 
   %traceit(_dictionary);


/* Check for duplicate names in `_dictionary` dataset  */
/* Datasets: `_FREQ_DUPKEY_` `_MRGD_DUPKEY_` created */
/* They should have zero observations */
%checkdupkey(_dictionary, name);

/* Dataset `vars_map1` derived from a simple `map_info`*/
data vars_map1;
 if 0 then set vars_map_template; 
 set _MAP2Long(
     keep= name dispatch wave_pattern &waves_list
     );
 /* Create vout variable */
    length  c1 $1; /* First character in `dispatch` */
 vout = strip(name);
 if dispatch = "" then  c1 = "";
   else c1= substr(strip(dispatch),1,1);
 if c1 ="`" then dispatch = translate(dispatch,"","`");
 if dispatch = "" then  c1 = "";
    else c1= substr(strip(dispatch),1,1);

 if c1 eq "=" then eq ="Y"; else eq="N";
 * eq0 =eq;
 drop name c1 eq; 
run;
%if &traceit = Y %then 
   %traceit(vars_map1);


/* `vars_map` modified */
/* _Conditionally_ inserts _datain_ row using dataset name stored in `DATAIN_NAME` macro variable */
%insert_datain_row; 

%if &traceit = Y %then 
   %traceit(vars_map1);

/*--- `waves_allinfo` dataset  with one row per wave created  */
%create_waves_allinfo;

%if &traceit = Y %then %do;
   %traceit(_datain0_);
   %traceit(waves_allinfo);
%end;


/* DATA `vars_map2`: key: stmnt_no,  contains_DATAIN_ row */
%create_vars_map2; 


/*--- `waves_info` dataset  with one row per wave created `vars_map2`  */
%create_waves_info;

%if &traceit = Y %then 
   %traceit(waves_info);

/* Create `_dictionary2` dataset by adding `datain#` variables */
%create_dictionary2;
%if &traceit = Y %then 
   %traceit(_dictionary2);

%create_mrg2;
%if &traceit = Y %then 
   %traceit(mrg2);

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


/*--- Keep statement ---*/

%let nkeep = %attrn_nlobs(_dictionary);
data _null_;
  file map_file mod ;
  set _dictionary  end = eof;
   if _n_=1 then do;
     /* Generate keep statement*/
     put / '%macro keepvar_statement;';
     put "/* Keep statement for &nkeep variables */";
     put " keep";
   end;
   put @3  name;
   if eof then do; 
     put ";";
     put '%mend keepvar_statement;';
   end;
run;


/*-- Create macros with DATA step statements for processing a given wave --- */
data _null_;
  file map_file mod ;
  set mrg2  end = eof;
  by datain_name wave_no stmnt_no;
  if first.wave_no then do;
   put / '%macro _'  wave_name  +(-1) ';';
   put '/* Macro will be invoked from inside of the DATA step */ '; 
   put @3 "/* -- Notes: ------------";
   put @ 5 "N12. y = ? or y = x";
   put @ 5 "N3. Variable copied/taken from input data";
   put @ 5 "N4. f(?,y)";
   put @ 5 "N5. f(x,y) option not used";
   put @ 5 "N6. Datain name (commented out)";
   put @5  " -- Comments:";
   put @5  "C1: Blank cell";
   put @5  "C2: Skipped cell [-]";
   put @5  "----------------*/" /;
   put @3  '%preprocess_wave;';
  end;
  if mod(stmnt_no, 10)= 0 then put /; 
  select(varxin1);
    when ("_BLANK_CELL_MAP_") tt=1;
    when ("[-]")              tt=2;
    otherwise;
  end;

 if tt= 1 then do;
  put " /*-- " vout " (see C1) */"; 
  stmnt = "";
 end;
 
 if tt= 2 then do;
   put " /*-- " vout " (see C2)*/"; 
   stmnt = "";
 end; 
  
 if option = 4 then do;
      if varxin1 ne "_BLANK_CELL_MAP_" then put @2 stmnt +(-1) ";   /* N4 */ ";
      stmnt="";
 end;

  if varxin1 ne "_BLANK_CELL_MAP_" and stmnt ne "" then do;
  select(option);
   when (6) put @2 "/*-- DATAIN: " stmnt " N6 */"; 
   when (3) put @2 "/*-- " vout  " N3 */";   
   when (1,2) put @3 stmnt +(-1) ";  /* N12 */ ";
   otherwise;
  end; 
  end;
  
           
  if option = 4 and tt ne 1 then
    put @2 '/*-- ' vout ' (see C2)  */';  /* comment */
  
     
  if last.wave_no then do;
    put @3 '%postprocess_wave;'; /* output */
    put '%mend _'  wave_name  +(-1) ';';
   put / ;
  end;
run;

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
   stmnt1 = '%'|| 'put_init_vars(' ||  strip(datain_no) || "," || strip(datain_name) || ")";
   stmnt2 = '%'|| 'put_preprocess_datain(' ||  strip(datain_no) || "," || strip(datain_name) || ")";
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

%put Macro `zzz_05main_execute` ends here;

%mend zzz_05main_execute;