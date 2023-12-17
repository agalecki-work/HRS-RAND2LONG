options nocenter mprint;

/* Select table:  Rwide, RLONG, HLONG, EXIT */
%let tbl =Rwide;  

/*----- Trace (optional) ----*/
%let traceit=Y;

/* === NO CHANGES BELOW */
filename _setup "../table_setup.inc";
%include _setup;

filename _macros "../../05-macros";
%include _macros(zzz_05include);
%zzz_05include;
filename _macros clear;

/* Execute macros */
%zzz_05main_execute;



