%macro create_vars_map_init;
data vars_map_init;
 set _MAP2Long(
     keep= name dispatch wave_pattern &waves_list
     );
run;
%mend create_vars_map_init;

