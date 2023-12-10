* =============== PROGRAM: 20-wide2long.sas =================================== 
   RELEASE DATE: NOV 30 2023
   WRITTEN BY Jinkyung Ha, Mohammed Kabeto, and Andrzej Galecki 
* ================================================================================== ;


* This program reshapes and recodes WIDE dataset into long format.;
* Project has been supported by Pepper Center grant;

options mprint; 



/* ===== INPUT ====== */

/*--- `outdata`:  macro variable stores the name of the dataset created by 20.sas */
libname LIB "./20-out"; 

%let datain = lib.randhrs1992_2020v1_HLong_init;

%let data_formats = lib.fmts_long;

/* ===== OUTPUT ====== */

%let dataout = lib.randhrs1992_2020v1_HLong;

/*===>>>> No changes needed below ====*/
/*--- Using SAS formats */

/* Create `work.formats` catalog */
proc format lib = WORK cntlin = &data_formats;
run;


proc sort data=&datain
           out =_sorted;
by wave_number hhid H_HHiD;
run;

data  _filtered;
 set _sorted;
 by wave_number hhid h_HHID;
 if first.h_hhid;
run;

  

proc sort data= _filtered
           out =_filtered_sorted;
by hhid h_HHid wave_number;
run;

data hhid (keep= hhid h_hhid);
  set _filtered_sorted;
  by hhid h_hhid;
  if first.h_hhid;
run;

data  hhid_n(drop=h_hhid); 
 set  hhid;
 by hhid h_hhid;
 if first.hhid then h_hhid_count =0;
 h_hhid_count+1;
 if last.hhid then output;
run;

data lib.h_hhid;
 merge hhid hhid_n;
 by hhid;
run;

proc print data = lib.h_hhid(obs=100);
run;

data &dataout;
  set _filtered_sorted;
run;


