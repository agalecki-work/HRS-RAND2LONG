options mprint;
libname lib ".";

%let mapx = HLONG_map; /* HLONG_map EXIT_map */
%let mtype = 2; /* 1- simple 2-long */

%let xlsx_name =randhrs1992_2020v1_maps;

filename macros "./macros";
%include macros(zzz_include);
%zzz_include;
%update_xlsx_map;