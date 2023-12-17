%put :=== autoexec.sas STARTS;

filename prj_auto "..\_project_auto.inc";
%include prj_auto;
filename prj_auto clear;

/* Path to current directory */
%let dir_name = Rexit_table;    /* !!! */
%let dir_path= &prj_path\&dir_name;

%put dir_name := &dir_name;
%put dir_path := &dir_path;

%put :=== autoexec.sas in `&dir_name` subfolder ENDS;




