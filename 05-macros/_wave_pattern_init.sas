%macro _wave_pattern_init;
/*-- requires pattern_range variables  */
/* Invoked by `create_vars_map2` macro  */
/* Based on `pattern_range` returns auxiliary vars */

length cmin_range cmax_range $3;
clist = upcase("hjklmnopqrstuvwxyz");

wave_max_no = input(symget('wave_max_no'), 3.);
cmin_range = scan(pattern_range,1,':');
min_range  = input(cmin_range, 3.); 

cmax_range = scan(pattern_range,2,':');
tmpc2 = cmax_range;
put "Macro _wave_pattern_init middle: " vout= tmpc2= cmax_range= wave_max_no=;
select(strip(tmpc2));
  when ("?") max_range = wave_max_no;
  when ("")  max_range = min_range;
  otherwise max_range = input(tmpc2, 3.);
end;
if max_range > wave_max_no then max_range = wave_max_no;
put "Macro _wave_pattern_init ends: " vout= pattern_range= wave_pattern=  min_range= max_range=; 
%mend _wave_pattern_init;
