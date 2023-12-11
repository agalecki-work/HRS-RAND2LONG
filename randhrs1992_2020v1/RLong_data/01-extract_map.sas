options mprint;
libname lib ".";

%let mapx = RLONG_map; /* HLONG_map EXIT_map */
%*let mtype = 2; /*  2-long */


%let xlsx_path =C:\temp;
%let xlsx_name =randhrs1992_2020v1_maps;


filename macros "../_macros";
%include macros(zzz_include);
%zzz_include;
%import_xlsx_map;

/* Sanitize map */
%sanitize_clength;
%sanitize_dispatch;

 data lib.&mapx;
 set _temp_;
 run;



