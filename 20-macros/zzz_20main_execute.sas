%macro zzz_20main_execute;

%put --- Macro `zzz_20main_execute` starts here;

/* Create `work.formats` catalog from `&formats_cntlin` */
proc format lib = WORK cntlin = &formats_cntlin ;
run;


proc datasets lib =work memtype=cat;
run;
quit;



/*---- Include `_mapfile` macros ---*/
%include _mapfile; 

/*--- Create `_template_longout` SAS dataset template for long data (with 0 observations) ----*/
%create_template_longout;

data _base_longout(label = "Dataset created from &wide_datain (&sysdate)");
  set _template_longout;
run;

/* Macro `create_outdata` creates dataset `work._base_longout` dataset */
%create_outdata(&wide_datain);  

/* Move and rename  `_base_longout` from `work` to `libout` SAS library */
%rename_base_longout;

/* copy formats_cntlin from libin to libout */

%copy_formats_cntlin;

%put --- Macro `zzz_20main_execute` ends here;



%mend zzz_20main_execute;