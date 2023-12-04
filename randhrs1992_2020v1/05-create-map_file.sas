
options nocenter mprint;

/*==== INPUT ===== */

* `LIBIN` libref for `DATAIN` dataset;

libname libin "C:\temp";

/*--- WIDE data name ---- */
* Name of the input SAS dataset is defined in `DATAIN` macro variable;

%let DATAIN = randhrs1992_2020v1;


/*--- MAP_INFO: Wide to Long map ---- */

libname lib_map  ".";
%let map_info = lib_map.randhrs1992_2020v1RL_map; /* SAS dataset with map info */
                
%let waves_list = hrs_wave1- hrs_wave15;     /* List of variables with _all_ wave names  */
%let waves_sel =  1 to 15;                /* use `do loop` syntax for index value*/

/* Define fileref `_macros` to a folder with auxiliary macros  needed to execute this script*/

filename _macros "../05-macros";

/* ==== OUTPUT files/datasets==== */

/*--- File with SAS macros referenced as  `map_file` will be generated ----*/
/* Note: Name of this file should correspond to the name stored in `map_info` macro variable */
%let map_file = 05-randhrs1992_2020v1.inc;
filename map_file "&map_file";       


/* `aux_outpath` macro variable contains path to auxiliary output */
%let aux_outpath = ./05-aux_out;  
libname aux_out "&aux_outpath";


/* Trace */
%let traceit=Y;


/*=====>>>>  No changes needed below =====*/
options nofmterr;

%let DATAIN_NAME =&datain;
 
%global HRS_RAND2LONG_version traceit;
%global map_file waves_sel  waves_sel2;
%**global xlsx_fnm map_info;
%global aux_outpath;
%global waves_list waves_elist wave_max_no;
%let waves_sel = %upcase(&waves_sel);
%put wave_sel := &waves_sel;
%let  waves_sel2 = %sysfunc(tranwrd(%quote(&waves_sel) ,TO, :));
%put wave_sel2 := &waves_sel2;
/*--- Includes macro definitions stored in  `_macros`  folder ---*/
data _MAP2Long;
 set &map_info;
run;

%include _macros(zzz_05include);
%zzz_05include;


/* Execute macros */
%zzz_05main_execute;

%symdel HRS_RAND2LONG_version   aux_outpath waves_list waves_elist;

endsas;

