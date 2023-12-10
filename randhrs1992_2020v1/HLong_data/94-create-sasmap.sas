/* Auxiliary  program */
libname lib ".";
%let data_map=randhrs1992_2020v1HL_map_923; /* .accdb */
%put data_map=&data_map;

/* Create SAS dataset */
PROC IMPORT DATATABLE="RAND_MAP"
            out   =lib.&data_map.4
            DBMS=ACCESS 
	    REPLACE;
DATABASE = "&data_map..accdb";
DBDSOPTS='READBUFF=730';		
run;
