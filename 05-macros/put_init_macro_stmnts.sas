%macro put_init_macro_stmnts;
/*--- Label statements ---*/

data _null_;
  file map_file mod ;
  set _dictionary end = eof;
   if _n_=1 then do;
     /* Generate label statements*/
     put '%macro label_statements;';
     put "/* Table &tbl: Label statements for &n_vout variables */";
     put "/* Macro invoked by `create_template_longout` macro */";
   end;
    if mod(varnum, 10) = 0 then 
     put / @2 "/* --Variable " name ": # _" varnum "*/";  
    put @3  'label ' name ' = "' label +(-1) '";';
   if eof then put '%mend label_statements;';
run;


/* clength_statements */

data _null_;
  file map_file mod ;
     put /;
     put '%macro clength_statements;';
     put "/*  Table &tbl: Length statements for character and selected numeric vars */";
     put "/* Macro invoked by `create_template_longout` macro */";
run;


data _null_;
  file map_file mod ;
  set _dictionary;
   if clength ne "" then do;
     put @3 'length ' name clength +(-1) ";"  @45 "/* _" varnum "*/";
   end;
 run;

data _null_;
  file map_file mod ;
   put '%mend clength_statements;';
   put /;
run;


/*--- Format statements ---*/

data _fmts;
  set _dictionary(keep=name format varnum);
  if format ="" then delete;
run;

%let nfmts = %attrn_nlobs(_fmts);

data _null_;
  file map_file mod ;
     /* Generate format_statements macro*/
     put / '%macro format_statements;';
     put "/*  Table &tbl: format statements for &nfmts variables */";
     put "/* Macro invoked by `create_template_longout` macro */";
run;

data _null_;
  file map_file mod ;
  set _fmts  ;
    put @3  'format ' name  format +(-1) ';' @45 "/* _" varnum "*/" ;
run;

data _null_;
  file map_file mod ;
  put '%mend format_statements;';   
  put /;
run;

/* Readvar list */

data _null_;
  file map_file mod ;
  put / '%macro readvar_list;'; 
  put "/* List of variables to be read from input dataset */";
run;

data _null_;
  file map_file mod ;
  %if &vars_map = N %then put '%keep_varlist'; 
    %else put '_ALL_';;
run;


data _null_;
  file map_file mod ;
  put '%mend readvar_list;';   
run;


/*--- Keep_varlist ---*/

%let nkeep = %attrn_nlobs(_dictionary);
data _null_;
  file map_file mod ;
  set _dictionary  end = eof;
   if _n_=1 then do;
     /*   Generate list of vars to keep */
     put / '%macro keep_varlist;';
     put "/* Table &tbl: List of &nkeep variables to keep */";
   end;
   put @3  name;
   if eof then do; 
     put '%mend keep_varlist;';
   end;
run;



/*---  `template_long_data` --- */

data _null_;
  file map_file mod;
  put / '%macro create_template_longout;';
  put '/*  Table &tbl: Macro creates  `_template_longout` */;' ; 
  put 'data _template_longout;';
  put @3 'missing A B C D E F G H I J;';
  put @3 'missing K L M N O P Q R S T;';
  put @3 'missing U V X Y Z;';
  put @3 'missing _; /* _ reserved for variables not defined (blank cells) in map_info */'; 
  put @3 '%label_statements;';
  put @3 '%clength_statements;';
  put @3 '%format_statements;';
  put @3 'call missing(of _all_);';
  put @3 'stop;';
  put 'run;';
  put '%mend create_template_longout;';
run;

/*=== Create `process_data` macro  */

data _null_;
  file map_file mod;
  put / '%macro process_data;';
  put "/*--- This macro depends on table type (type = &vars_map) */";
%if (&vars_map = Y or &vars_map = E) %then %do; 
  put '   %preprocess_data; /* --- Before processing data waves */'; 
  put '   %process_waves;';
  put '   %postprocess_data;/* --- After processing data waves */';
%end;
  put  '%mend process_data;';
run;



/*=== Create `append_outtable` macro ==== */


data _null_;
  file map_file mod;
  put / '%macro append_outtable(datain);';
  put "/*  Table &tbl: Macro creates and appends `_outtable` data */;" ;
  put "/*  Depends on table type through `process_data` macro */";
  put ' data _outtable;';
  put '  if 0 then set _template_longout;';
  put '   set &datain(keep = %' 'readvar_list);';
  put '   %' 'process_data;';
  put ' run;';
  put /;
  put ' proc append base = _base_longout';
  put '             data= _outtable;';
  put ' run;';
  put '%mend append_outtable;';
run;

/* === Macro `process_waves` appended to `map_file` */
/* Uses info stored in `_waves_selected` SAS dataset */

%if (&vars_map = Y or &vars_map =E) %then %put_init_macro_stmnts2;

 
%mend put_init_macro_stmnts;

