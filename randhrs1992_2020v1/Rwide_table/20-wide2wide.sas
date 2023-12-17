options mprint; 

/* Select table:  Rwide, RLONG, HLONG, EXIT */
%let tbl =Rwide;  /* */

%let key_vars = hhid  PN;

/*==== No changes below ===*/

/*===== SETUP =======*/
filename _setup "../table_setup.inc";
%include _setup;

/* Include file created by 05-create-macros.sas */
%include map_file;

%zzz_20main_execute;





