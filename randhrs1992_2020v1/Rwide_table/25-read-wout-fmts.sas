libname lib "./outdata";

%let data = Rwide_table;

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
var varnum name label;
run;

Title2 "Contents Part 2/2";
proc print data=contents;
var varnum name type format nobs;;
run;

proc means data=lib.&data n nmiss mean stddev min max maxdec=2 nolabels;
var _numeric_;
run;


Title "Data: &data. Selected vars (n=50)";
proc print data = lib.&data(obs=50);
var  HHID PN HHIDPN WAVE_NUMBER INW HACOHORT STUDYYR R_HECOV3 R_YR;
run;


Title "Number of rows per wave";
proc freq data = lib.&data;
table wave_number /nopercent norow nocol;
table studyyr;
table wave_number*r_yr /missing nopercent norow nocol;
run;

Title "PROC FREQ without SAS formats";
Title2 "All missing data categories listed";
proc freq data = lib.&data;
tables R_YR / missing; 
tables r_mstat/missing;
tables R_NHMLIV/missing; 

run;

Title2 "All missing data combined";
proc freq data = lib.&data;
tables R_YR r_mstat R_NHMLIV; 

run;
