
options nocenter mprint;
%_project_setup;

/* Select table:  Rwide, RLONG, HLONG, EXIT */
%_table_setup(RLong); /*---<<<--- */
%let key_vars = hhid  PN wave_number;

/*----- Trace (optional) ----*/
%let traceit=Y;

/* Execute macros */
%zzz_20main_execute;

