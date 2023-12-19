%macro zzz_xlsx_update;
/* One Table is processed by this macro */
%_usetup_mvars;
%update_xlsx_map;
%if &vars_map = N %then %do;
   %*dictionary_template;
   %*traceit_contents(dictionary_template);
%end;

%if &vars_map = Y %then %do;
  %**vars_map_template;
  %**traceit_contents(vars_map_template);
%end;
 %traceit_print(&mapx, libname=_libmap, obs=50);

%mend  zzz_xlsx_update;
