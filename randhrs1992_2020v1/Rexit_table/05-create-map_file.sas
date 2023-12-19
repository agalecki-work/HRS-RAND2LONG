options nocenter mprint;
**libname lib '.';

* Project setup (mandatory); 
filename prj_init "..\_project_setup.inc";
%include prj_init;

libname _libout  "&prj_path\&dir_name\data";
%global table mapx aux_outpath map_info dir_path;
 
%global outdata outdata_formats;

%let table =Rexit;
filename map_file "&prj_path\&dir_name\&table._map_file.inc"

%macro create_map_file(tbl);



%mend create_map_file;

/* Execute macros */
%zzz_05main_execute;



/* Select table:  Rwide, RLONG, HLONG, EXIT */
%***_table_setup(Rexit);
 


endsas;


/* === NO CHANGES BELOW */





