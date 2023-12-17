libname lib "./outdata";

%let data = Rexit_table;



/*--- Using SAS formats */

/* Create `work.formats` catalog */
proc format lib = WORK cntlin = lib.fmts_long;
run;


Title "PROC FREQ with SAS formats";
Title2 "All missing data categories listed";
proc freq data = lib.&data;
 table hacohort /missing;
 table REBATHH /missing;
run;

Title "PROC FREQ";
Title2 "All missing data combined";
proc freq data = lib.&data;
table hacohort; * /nopercent norow nocol;
table REBATHH;
run;

