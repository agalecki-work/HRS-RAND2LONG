/* Auxiliary  program */
libname lib ".";
%let data_map=randhrs1992_2020v1hl_map_92;

/* Create accdb file */
proc export data= lib.&data_map
  outtable ="RAND_MAP"
  dbms= access
  replace; 
  database="&data_map.3.accdb";

run;
