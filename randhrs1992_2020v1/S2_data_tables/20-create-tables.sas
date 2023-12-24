
options nocenter mprint;

libname _data  "&prj_path\&dir_name\data";


%macro _20create_table(tbl, key_vars);
 filename map_file "&prj_path\&dir_name\map_files\&tbl._map_file.inc";
 %let tbl_name= &tbl._table;
 %let outdata = _data.&tbl_name;
 %let outdata_formats =_data._RANDfmts_long;
 %zzz_20main_execute;

 /* Create `work.formats` catalog from cntlin dataset*/
 proc format lib = WORK cntlin = &outdata_formats;
 run;
  
 filename map_file clear; 
%mend _20create_table;


/* Execution starts */
%_project_setup;

%*macro skip;
%_20create_table(RLong, hhid  PN wave_number);
%_20create_table(HLong, hhid  wave_number H_HHiDC );
%_20create_table(Rwide, hhid  PN);
%_20create_table(Rexit, hhid  PN);
%*mend  skip;

%_20create_table(RSSI,  hhid  PN RSSI_EPISODE);
