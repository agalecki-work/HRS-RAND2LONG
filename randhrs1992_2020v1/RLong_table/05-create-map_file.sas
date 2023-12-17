options nocenter mprint nofmterr;
%_project_setup;

/* Select table:  Rwide, RLONG, HLONG, EXIT */
%_table_setup(Rlong);

/*----- Trace (optional) ----*/
%let traceit=Y;

/* Execute macros */
%zzz_05main_execute;


