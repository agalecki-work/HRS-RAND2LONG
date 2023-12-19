
options nocenter mprint nofmterr;
libname _libmap  "&prj_path\_update_maps\maps";
libname aux_out  "&prj_path\&dir_name\_aux";

%macro _05map_file_create(tbl);
 %put tbl = &tbl;
 filename map_file "&prj_path\&dir_name\05-&tbl._map_file.inc";

 %let mapx = &tbl._map;    /* RAND map name */
 %let map_info = _libmap.&mapx; /* SAS dataset with map info */
 %zzz_05main_execute;
%mend _05map_file_create;

/* =====  Execution STARTS  ===== */;
%_project_setup;

/* Select table:  Rwide, RLONG, HLONG, EXIT */



/*----- Trace (optional) ----*/
%let traceit=Y;

%_05map_file_create(HLong);





