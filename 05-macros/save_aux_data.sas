%macro save_aux_data;

/* SAVE auxiliary datasets */

data aux_out.MAPX_02dictionary2;
   set _dictionary2;
run;

data aux_out.MAPX_03vars_map;
   set vars_map;
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

%mend save_aux_data;
