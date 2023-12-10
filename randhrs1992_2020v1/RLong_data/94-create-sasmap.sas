/* Auxiliary  program */
libname lib ".";
%let data_map = randhrs1992_2020v1rl_map_923; /* .accdb */


/* Create SAS dataset */
PROC IMPORT DATATABLE="RLONG"
            out   =lib.&data_map.4
            DBMS=ACCESS 
	    REPLACE;
DATABASE = "&data_map..accdb";
DBDSOPTS='READBUFF=730';		
run;
