%macro save_aux_data;

/* SAVE auxiliary datasets */

data aux_out.MAPX_02dictionary2;
   set _dictionary2;
run;

%if (&vars_map = Y or &vars_map = E) %then %do;
 data aux_out.MAPX_03vars_map1;
   set vars_map1;
 run;

 data aux_out.MAPX_01waves_info;
   set waves_info;
 run;

 data aux_out.MAPX_05mrg2;
   set mrg2;
 run;

 data aux_out.MAPX_04vars_map2;
   set vars_map2;
run;
%end;
%mend save_aux_data;
