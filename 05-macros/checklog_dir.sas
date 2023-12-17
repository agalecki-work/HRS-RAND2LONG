
%macro checklog_dir(dir);
Title "Project &prj_name: Folder &dir_name (outloc= &outloc)";
%checklog(&dir, pm=N);
data log_issues;
  set log_issues;
  log = tranwrd(log,"&dir",".");
  if lowcase(log) = "&skip" then delete;
run;
proc print data=log_issues;
run; 

%mend checklog_dir;
