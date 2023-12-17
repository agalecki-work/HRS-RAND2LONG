%macro _dir_setup(nick_nm =);

/* Macro depends on global macro vars `prj_path` and `dir_name` */ 
/* `nick_nm` is a nick name for `dir_name` */
/* ! Use `dir_name` when specifying output path */

%if (%length(&nick_nm) = 0) %then %let nick_nm=&dir_name;

libname _libout  "&prj_path\&dir_name\maps";
filename map_file "&prj_path\&dir_name\&nick_nm._map_file"; 

/* `aux_outpath` specifies path to a directory for auxiliary output */
%let aux_outpath =&prj_path\&dir_name\_aux;  
libname aux_out "&aux_outpath";


%mend _dir_setup;