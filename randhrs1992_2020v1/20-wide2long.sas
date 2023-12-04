* =============== PROGRAM: 20-wide2long.sas =================================== 
   RELEASE DATE: NOV 30 2023
   WRITTEN BY Jinkyung Ha, Mohammed Kabeto, and Andrzej Galecki 
* ================================================================================== ;


* This program reshapes and recodes WIDE dataset into long format.;
* Project has been supported by Pepper Center grant;

options mprint; 

/*=====  INPUT ======== */;

* `LIBIN` libref for WIDE dataset(s);

libname libin "C:\temp";
%let DATAIN = randhrs1992_2020v1;

/* `formats_cntlin` macro variable refers to cntlin SAS dataset with format definitions */ 
%let formats_cntlin = libin.sasfmts;

/* Include file created by 05-create-macros.sas */
filename _mapfile "./05-randhrs1992_2020v1.inc"; 
%include _mapfile;

/* Define fileref `_macros` to a folder with auxiliary macros  needed to execute this script*/

filename _macros "../20-macros";

/* Define fileref `fcmp_src` with path to FCMP source */

filename fcmp_src "./20-usource/FCMP_src.sas";


/*--- Inlude FCMP source ----*/
proc fcmp outlib = work._WIDE2LONG.all; /* 3 level name */
%include fcmp_src;
run;
quit; /* FCMP */


/*---- Load FCMP functions ----*/
options cmplib = work._WIDE2LONG;


/* ===== OUTPUT ====== */

/*--- `outdata`:  macro variable stores the name of the output dataset in the long format */

libname LIBOUT "./20-out"; 

%let outdata = libout.randhrs1992_2020v1_long;

%let outdata_formats = libout.fmts_long;


/*===>>>> No changes needed below ====*/

/*--- Includes macro definitions stored in  `_macros`  folder ---*/

%let wide_datain = libin.&datain;

%include _macros(zzz_20include);
%zzz_20include;

%zzz_20main_execute;


ENDSAS;





