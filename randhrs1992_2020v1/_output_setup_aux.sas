%macro _output_setup(nick_nm =);

/* Macro depends on global macro vars `prj_path` and `dir_name` */ 
/* `nick_nm` is a nick name for `dir_name` */
/* ! Use `dir_name` when specifying output path */

%if (%length(&nick_nm) = 0) %then %let nick_nm=&dir_name;

/*--- Output in 05-update_maps folder --- */
libname _libout  "&prj_path\&dir_name\maps";

/* `aux_outpath` specifies path to a directory for auxiliary output */
%let aux_outpath =&prj_path\&dir_name\_aux;  
libname aux_out "&aux_outpath";


/*--- File with SAS macros referred to as  `map_file`  ----*/

%let map_file = &prj_path\&dir_name\05-&nick_nm._file.inc;


%mend _output_setup