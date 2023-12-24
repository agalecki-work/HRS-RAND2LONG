%macro put_init_macro_stmnts2;
data _null_;
 file map_file mod;
 set waves_info end= eof;
  if _n_ =1 then do;
    put / '%macro process_waves;';
    put "/*Table &tbl: Process waves */";
    put '/* All macro calls below invoke `preprocess_wave` and `postprocess_wave` macros */';
  end;
  put @3 wave_mcall +(-1) ";";
  if eof then put '%mend process_waves;' /; 
run;

/* ==== Macro `preprocess_wave` appended to `map_file` */

data _null_;
 file map_file mod;
    put '%macro preprocess_wave;';
    put "/* Table &tbl:  Preprocess data wave */";
    put "/* Macro invoked by all 'wave' macros */";
    put @3 '%' '_out_initvars;'; 
  put '%mend preprocess_wave;' /; 
run;



/* ==== Macro `postprocess_wave` appended to `map_file` */
%let stmnt0 =;
%if &vars_map = Y         %then %let stmnt0= if INW =1 then output;
%if %upcase(&tbl) = RSSI  %then %let stmnt0= if RADAPPY_E ne . then output;
data _null_;
 file map_file mod;
    put '%macro postprocess_wave;';
    put "/* Table &tbl: Post process data wave */";
    put "/* Macro invoked by all 'wave' macros */";
  put @3 "&stmnt0;"; 
  put '%mend postprocess_wave;' /; 
run;

%put_init_vars;

%put_preprocess_data;
%put_postprocess_data;
%mend put_init_macro_stmnts2;