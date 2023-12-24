%macro create_vars_map_init;
%put === Macro `create_vars_map_init` STARTS;
data vars_map_init;
 set _MAP2Long(
     keep= name dispatch wave_pattern &waves_list
     );
run;

%traceit(vars_map_init);
%put === Macro `create_vars_map_init` ENDS;
%mend create_vars_map_init;

