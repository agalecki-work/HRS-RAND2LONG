/* NOTE: autoexec.sas will beexecuted */
%put outloc :=&outloc;
options mprint;



/* Execute scripts in `05-update_maps` subdirectory*/ 
%let subdir_name =05-update_maps;
%let script_name = 05_update_maps.sas;
%let dir_path =&prj_path\&subdir_name;
filename fn_all "&dir_path\&script_name";
%include fn_all;
filename fn_all clear;


