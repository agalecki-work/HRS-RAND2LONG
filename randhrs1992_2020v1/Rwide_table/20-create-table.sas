options mprint; 

options nocenter mprint;
libname lib '.';

%let table = Rwide;
%let key_vars = hhid PN;

/*=== No changes below ===*/

* Project setup (mandatory); 
filename prj_init "..\_project_setup.inc";
%include prj_init;

* Macro `_table_setup` loaded;
filename tblsetup "&repo_path\&prj_name\_table_setup.sas";
%include tblsetup;
%_table_setup(&table);
%include map_file;
%zzz_20main_execute;
%symdel table key_vars;


