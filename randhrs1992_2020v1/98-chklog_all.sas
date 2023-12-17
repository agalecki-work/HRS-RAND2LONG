%let skip= .\98-chklog.log; 
options nocenter;

ods listing close;
ods html file = "90-execute_all.html";
%checklog(&prj_path\90-execute_all.log,pm=N);
ods html close;





