libname lib ".";

data tmp(drop =c1);
  retain name label clength format dispatch wave_summary;
  *length wave_summary $25;
  length c1 $1;
  set lib.randhrs1992_2020v1_map;*(drop=pattern_range);
  *wave_summary = "";
  if clength ne "" then clength= translate(clength,"$","`");
  if dispatch ne "" then do;
   c1 = substr(strip(dispatch),1,1);
   if c1= "`" then dispatch = substr(dispatch,2);
  
  end;
run;

data  lib.randhrs1992_2020v1_map;
 set tmp;
run;

