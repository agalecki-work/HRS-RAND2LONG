libname lib "./20-out";

%let data = randhrs1992_2020v1_long;



/*--- Using SAS formats */

/* Create `work.formats` catalog from cntlin data */
proc format lib = WORK cntlin = lib.fmts_long;
run;



Title "Data: &data. Selected vars (n=50)";
proc print data = lib.&data(obs=50);
var  RAHHIDPN WAVE_NUMBER INW HACOHORT STUDYYR R_HECOV3 R_YR;
run;


Title "Number of rows per wave";
proc freq data = lib.&data;
table studyyr;
run;

Title "PROC FREQ with SAS formats";
Title2 "All missing data categories included";
proc freq data = lib.&data;
tables R_YR / missing; 
run;

Title2 "All missing data combined";
proc freq data = lib.&data;
tables R_YR; 

run;






