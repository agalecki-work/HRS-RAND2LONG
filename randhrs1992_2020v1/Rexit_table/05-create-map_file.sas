options nocenter mprint;
libname lib '.';

* Project setup (mandatory); 
filename prj_init "..\_project_setup.inc";
%include prj_init;

* Macro `_table_setup` loaded;
filename tblsetup "&repo_path\&prj_name\_table_setup.sas";
%include tblsetup;


/* Select table:  Rwide, RLONG, HLONG, EXIT */
%_table_setup(Rexit);
 
%zzz_05main_execute;

endsas;

/*----- Trace (optional) ----*/
%let traceit=Y;

/* === NO CHANGES BELOW */


filename _setup "../table_setup.inc";
%include _setup;

/* Execute macros */
%zzz_05main_execute;


