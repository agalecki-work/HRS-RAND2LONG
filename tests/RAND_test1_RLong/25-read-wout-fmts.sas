libname lib "./20-out";

%let data = randhrs1992_2020v1_long;

/* --- Code works without using SAS formats */
options nofmterr nocenter;
Title "PROC CONTENTS for &data";
proc contents data=lib.&data out= contents(keep= memname varnum name type format label nobs) noprint;
run;

proc sort data=contents;
by varnum;
run;

Title2 "Contents Part 1/2";
proc print data=contents;
var name label;
run;

Title2 "Contents Part 2/2";
proc print data=contents;
var name type varnum nobs;;
run;

Title "Data: &data. Selected vars (n=50)";
proc print data = lib.&data(obs=50);
var  RAHHIDPN WAVE_NUMBER INW HACOHORT STUDYYR R_HECOV3 R_YR;
run;


Title "Number of rows per wave";
proc freq data = lib.&data;
table studyyr;
run;

Title "PROC FREQ without SAS formats";
Title2 "All missing data categories included";
proc freq data = lib.&data;
tables R_YR / missing; 

run;

Title2 "All missing data combined";
proc freq data = lib.&data;
tables R_YR; 

run;
