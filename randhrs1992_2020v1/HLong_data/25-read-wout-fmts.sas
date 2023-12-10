libname lib "./20-out";

%let data = randhrs1992_2020v1_hlong;

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

Title "Data: &data. Selected vars (n=100)";
proc print data = lib.&data(obs=100);
var  HHID h_hhid PN WAVE_NUMBER INW HACOHORT STUDYYR H_HHIDC  H_OHRSHH H_PICKHH H_ITOT2 H_ATOTB H_CHILD H_HHRESP;
run;


Title "Number of rows per wave";
proc freq data = lib.&data;
table wave_number /nopercent norow nocol;
table studyyr;
table wave_number*H_PICKHH /missing nopercent norow nocol;
run;

Title "PROC FREQ without SAS formats";
Title2 "All missing data categories listed";
proc freq data = lib.&data;
tables H_PICKHH / missing; 

run;

Title2 "All missing data combined";
proc freq data = lib.&data;
tables H_PICKHH; 

run;
