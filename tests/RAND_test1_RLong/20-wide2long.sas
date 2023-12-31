* =============== PROGRAM: 20-wide2long.sas =================================== 
   RELEASE DATE: NOV 30 2023
   WRITTEN BY Jinkyung Ha, Mohammed Kabeto, and Andrzej Galecki 
* ================================================================================== ;


* This program will reshape and recode WIDE RAND dataset into long format.;
* Project has been supported by Pepper Center grant;

options mprint; 

/*=====  INPUT (Part 1/2) ======== */;

* `LIBIN` libref for WIDE dataset(s);

libname libin "C:\temp";

* `datain` name of input SAS dataset;
%let datain = randhrs1992_2020v1_test;

/* `formats_cntlin` macro variable refers to a cntlin SAS dataset with format definitions */ 
%let formats_cntlin = libin.sasfmts; ;

filename _mapfile "./05-randhrs1992_2020v1_test1.inc"; 

/* Define fileref `_macros` to a folder with auxiliary macros  needed to execute this script*/

filename _macros "../../20-macros";

/*------ INPUT (Part 2/2)  load compiled FCMP  ---- */

/* Define fileref `fcmp_src` with path to FCMP source */

filename fcmp_src "./20-usource/FCMP_src.sas";

/*--- Include and compile FCMP source ----*/
proc fcmp outlib = work._WIDE2LONG.all; /* 3 level name */
%include fcmp_src;
run;
quit; /* FCMP */


/*---- Load compiled FCMP functions  ----*/
options cmplib = work._WIDE2LONG; /* 2 level name */


/* ===== OUTPUT ====== */

/*--- `outdata`:  macro variable stores the name of the output dataset in long format */

libname LIBOUT "./20-out"; 

%let outdata = libout.randhrs1992_2020v1_long;

/* `cntlin` data for long data */
%let outdata_formats = libout.fmts_long;


/*===>>>> No changes needed below ====*/

%let wide_datain = libin.&datain;

/*--- Includes macro definitions stored in  `_macros`  folder ---*/

%include _macros(zzz_20include);
%zzz_20include;

%zzz_20main_execute







