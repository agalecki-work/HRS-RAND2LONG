/* Auxiliary  program */
libname lib ".";
%let data_map=rand2long_test1_map_923; /* .accdb */


/* Create SAS dataset */
PROC IMPORT DATATABLE="MAP93"
            out   =lib.&data_map.4
            DBMS=ACCESS 
	    REPLACE;
DATABASE = "&data_map..accdb";
DBDSOPTS='READBUFF=730';		
run;
