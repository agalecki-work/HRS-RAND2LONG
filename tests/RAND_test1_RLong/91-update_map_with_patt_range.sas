/* Auaxiliary 
program assumes that map dataset contains deprecated `pattern_range` variable 
*/
libname lib ".";
%let data_map=rand2long_map_with_patt_range;

data tmp(drop =c1);
  retain name label clength format dispatch wave_summary;
  length wave_summary $25;
  length c1 $1;
  set lib.&data_map (drop=pattern_range);
  wave_summary = "";
  if clength ne "" then clength= translate(clength,"$","`");
  if dispatch ne "" then do;
   c1 = substr(strip(dispatch),1,1);
   if c1= "`" then dispatch = substr(dispatch,2); 
  end;
run;

data  lib.&data_map._91;
 set tmp;
run;

