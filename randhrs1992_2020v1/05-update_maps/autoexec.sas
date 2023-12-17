%put :=== autoexec.sas STARTS;
filename prj_auto "..\_project_auto.inc";
%include prj_auto;
filename prj_auto clear;

filename dir_set ".";
%include dir_set(_dir_setup);
filename dir_set clear;

/* Path to current directory */
%let dir_name = 05-update_maps;    /* !!! */
%let dir_path= &prj_path\&dir_name;

%put :=== autoexec.sas in subdir `&dir_name` ENDS;




