options mprint;
libname lib ".";

%*let mapx = RLONG_map; /* HLONG_map EXIT_map */
%*let mtype = 2; /*  2-long */

%let mapx = Rexit_map;  /* Rwide_map Rexit_map */
%let mtype = 1; /* 1- simple */

%let xlsx_path =C:\temp;
%let xlsx_name =randhrs1992_2020v1_maps;



filename macros "../_macros";
%include macros(zzz_include);
%zzz_include;
%update_xlsx_map;