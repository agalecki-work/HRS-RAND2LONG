%macro create_waves_elist(vars_map, waves_list);

/* 
  vars_map: SAS dataset with map info 
  waves_list: list of variables  with wave names

*/

/* Expand `waves_list` macro variable */

data waves_list;
   set vars_map_init(keep = &waves_list);
   stop;
run;

proc transpose data=waves_list out = twaves_list
               name = name; /* label = label; */
var &waves_list;
run;

proc sql noprint;
   select name into :waves_elist separated by  " "  from  twaves_list;
quit;

%put waves_elist := &waves_elist;
%mend create_waves_elist;
