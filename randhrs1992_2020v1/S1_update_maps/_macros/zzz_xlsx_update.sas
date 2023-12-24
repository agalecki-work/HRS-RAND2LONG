%macro zzz_xlsx_update;
/* One Table/map is processed by this macro */
%_usetup_mvars;
%update_xlsx_map;
%traceit_print(&mapx, libname=_libmap, obs=50);

%mend  zzz_xlsx_update;
