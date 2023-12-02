libname lib ".";

%let data = rand2long_test1_map;

%macro _2xlsx;
/* Create Excel file */
proc export data=lib.&data
  outfile="&data..xlsx"
  dbms=xlsx
  replace;
  sheet="test1";  
run;
%mend _2xlsx;


%macro _2sas;
/* Create SAS dataset */
PROC IMPORT OUT=lib.&data
		DATAFILE="&data..xlsx"
		DBMS=EXCEL REPLACE;
	RANGE="test1$";
	GETNAMES=YES;
	MIXED=YES;
	SCANTEXT=YES;
	USEDATE=YES;
	SCANTIME=YES;
run;
%mend _2sas;

%_2xlsx; 

