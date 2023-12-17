%macro _table_setup(table);
%put --- Maccro `_table_setup` STARTS here;

/* macro variables: `repo_path`, `prj_name` defined in _project_auto.inc file and loaded through autoexec.sas */
/* `dir_path` macro variable is also required */ 

/* Declare global macro variables */
%global tbl mapx aux_outpath map_info dir_path;

%global outdata outdata_formats;

/*==== Table Name ===== */
%let tbl = &table;
%put tbl = &tbl;

%let mapx = &tbl._map;    /* RAND map name */

%let outdata = _libout.&tbl._table;
%let map_info = _libout.&mapx; /* SAS dataset with map info */
%let outdata_formats = _libout.fmts_long;

**filename map_file "&map_file"; 

%put --- Macro vars defined in `table_setup.inc`;

%put tbl                := &tbl;
%put mapx               := &mapx;
%put map_file           := &map_file;
%put outdata            := &outdata;
%put map_info           := &map_info;
%put outdata_formats    := &outdata_formats;
%put aux_outpath        := &aux_outpath;
%put --- `table_setup.inc ENDS here`;
%mend _table_setup;


