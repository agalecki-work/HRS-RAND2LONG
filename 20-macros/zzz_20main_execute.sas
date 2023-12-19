%macro zzz_20main_execute;
%global vars_map;
%put --- Macro `zzz_20main_execute` starts here;
%_usetup_mvars;

/* Create `work.formats` catalog from `&formats_cntlin` */
proc format lib = WORK cntlin = &formats_cntlin ;
run;


proc datasets lib =work memtype=cat;
run;
quit;

%put -- catalog work.formats created;


/*---- Include `map_file` macros ---*/
%include map_file;

%put --- File `map_file` included ---;

/*--- Create `_template_longout` SAS dataset template for long data (with 0 observations) ----*/
%create_template_longout;

data _base_longout(label = "Table %upcase(&tbl) created from &wide_datain (datestamp: &sysdate, Table Version:= &table_version)");
  set _template_longout;
run;

/* Macro `create_outdata` creates dataset `work._base_longout` dataset */

%put vars_map = &vars_map;

%if &vars_map =Y %then
  %create_outdata(&wide_datain);  
  
%if &vars_map ne Y %then
  %create_outdata_wide(&wide_datain);  


/* Move and rename  `_base_longout` from `work` to `libout` SAS library */
%rename_base_longout;

/* copy formats_cntlin from libin to libout */

%copy_formats_cntlin;

%put --- Macro `zzz_20main_execute` ends here;



%mend zzz_20main_execute;