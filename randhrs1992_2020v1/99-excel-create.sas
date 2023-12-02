libname lib ".";

%let data = randhrs1992_2020v1_map;

proc export data=lib.&data
  outfile="&data..xlsx"
  dbms=xlsx
  replace;
  sheet="My Sheet";  
run;

 


