
options nocenter mprint;*  nofmterr;
%_project_setup;

/* Select table:  Rwide, RLONG, HLONG, EXIT */
%_table_setup(Hlong);

/*----- Trace (optional) ----*/
%let traceit=Y;

%let key_vars = hhid  wave_number H_HHiDC;


/* Execute macros */
%zzz_20main_execute;

