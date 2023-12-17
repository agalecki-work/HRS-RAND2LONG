%put :=== autoexec.sas STARTS;
%*let outloc = _lcl;
filename prj_auto "..\_project_auto.inc";
%include prj_auto;
filename prj_auto clear;

/* Path to current directory */
%let dir_name = HLong_table;    /* !!! */
%*let dir_path= &prj_path\&dir_name;

%put :=== autoexec.sas outloc := &outloc ENDS;




