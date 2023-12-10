/* Auxiliary  program */
libname lib ".";
%let data_map=randhrs1992_2020v1rl_map_92;

/* Create accdb file */
proc export data= lib.&data_map
  outtable ="RLONG"
  dbms= access
  replace; 
  database="&data_map.3.accdb";

run;
