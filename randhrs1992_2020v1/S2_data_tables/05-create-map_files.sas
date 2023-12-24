
options nocenter mprint nofmterr;
libname _libmap  "&prj_path\S1_update_maps\maps";

%macro _05map_file_create(tblx);
 %global tbl;
 %put tblx = &tblx;
 %let tbl = &tblx;
 filename map_file "&prj_path\&dir_name\map_files\&tbl._map_file.inc";
 %let aux_out = _05aux\&tbl; /* Subfolder name with html trace */
 libname aux_out  "&prj_path\&dir_name\&aux_out";

 %let mapx = &tbl._map;    /* SAS dataset name with map info */
 %let map_info = _libmap.&mapx; /* SAS dataset with map info */
 %zzz_05main_execute;
 %symdel tbl;
%mend _05map_file_create;

/* =====  Execution STARTS  ===== */;
%_project_setup;

%put table_version := &table_version;


%*macro skip;
%_05map_file_create(HLong);
%_05map_file_create(RLong);
%_05map_file_create(Rwide);
%_05map_file_create(Rexit);
%*mend skip;

%_05map_file_create(RSSI);

