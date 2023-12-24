/* NOTE: autoexec.sas executed */
options mprint;

libname _libmap  "&prj_path\&dir_name\maps";

* Local macros loaded;
filename macros "&prj_path\&dir_name\_macros";
%include macros(zzz_xlsx_include);
%zzz_xlsx_include;

/* Auxiliary macro definition */
%macro map_update(tbl);
 %put tbl = &tbl;
 %let mapx = &tbl._map;    /* RAND map name */

 %let map_info = _libmap.&mapx; /* SAS dataset with map info */
 %zzz_xlsx_update;

%mend map_update;

/*=== Execute =====*/

%global table mapx aux_outpath map_info dir_path;

%global outdata outdata_formats;

/* ===== Macro `_project_setup` executed  ===== */;
%_project_setup;

%put table_version := &table_version;



 ods listing close;
 ods html  path =     "&prj_path\&dir_name" (URL=NONE)
           file =     "05-updated_maps-body.html"
           contents = "05-updated_maps-contents.html"
           frame =    "05-updated_maps-frame.html"
 ;

%map_update(RLong);
%map_update(Hlong);
%map_update(Rwide);
%map_update(Rexit);
%map_update(RSSI);
libname _libmap clear;
ods html close;






