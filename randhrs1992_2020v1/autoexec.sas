%put :=== autoexec.sas STARTS;
%*let outloc =_glb;
filename prj_auto "_project_auto.inc";
%include prj_auto;
filename prj_auto clear;
%let dir_name =;
%put :=== autoexec.sas for outloc:=&outloc ENDS;




