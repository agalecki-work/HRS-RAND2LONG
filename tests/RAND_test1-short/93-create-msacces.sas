/* Auxiliary  program */
libname lib ".";
%let data_map=rand2long_test1_map_92;

/* Create accdb file */
proc export data= lib.&data_map
  outtable ="MAP93"
  dbms= access
  replace; 
  database="&data_map.3.accdb";

run;
