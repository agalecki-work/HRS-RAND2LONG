
options nocenter mprint;

libname _data  "&prj_path\&dir_name\data";

%macro _20_create_table(tbl);
filename map_file "&prj_path\&dir_name\05-&tbl._map_file.inc";

%let key_vars = hhid  wave_number H_HHiDC;

%zzz_20main_execute;

%mend _20_create_table;

/* Execution starts */
%_project_setup;

/* Select table:  Rwide, RLONG, HLONG, EXIT */
%**_table_setup(Hlong);

/*----- Trace (optional) ----*/
%**let traceit=Y;

%_20_create_table(HLong);
