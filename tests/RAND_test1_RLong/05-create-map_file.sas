
options nocenter mprint;

/*==== INPUT ===== */

* `LIBIN` libref for WIDE dataset(s);

libname libin "C:\temp";

/*--- WIDE data name ---- */
* Name of the input SAS dataset is defined in `DATAIN` macro variable;

%let DATAIN = randhrs1992_2020v1_test;

/*--- MAP_INFO: Wide to Long map stored as SAS dataset ---- */

libname lib_map  ".";
%let map_info = lib_map.rand2long_test1_map; /* SAS dataset with map info */

%let waves_list = hrs_wave1- hrs_wave15;     /* List of variables with _all_ wave names  */
%let waves_sel =  1 to 5, 15;                /* To select waves use `do loop` syntax for index value*/

/* Define fileref `_macros` to a folder with auxiliary macros  needed to execute this script*/

filename _macros "../../05-macros";

/* ==== OUTPUT files/datasets==== */

/*--- File with SAS macros referenced as  `map_file` will be generated ----*/
/* Note: Name of this file should correspond to the name stored in `map_info` macro variable */
%let map_file = 05-randhrs1992_2020v1_test1.inc;
filename map_file "&map_file";       


/* `aux_outpath` macro variable contains path to auxiliary output */
%let aux_outpath = ./05-aux_out;  
libname aux_out "&aux_outpath";

/* Trace */
%let traceit=Y;

/*=====>>>>  No changes needed below =====*/
options nofmterr;
%let vars_map =Y;


/*--- Includes macro definitions stored in  `_macros`  folder ---*/

%include _macros(zzz_05include);
%zzz_05include;


/* Execute macros */
%zzz_05main_execute;

%symdel HRS_RAND2LONG_version  map_info  aux_outpath waves_list waves_elist;
%symdel map_file waves_sel2 waves_sel;


