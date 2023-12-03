libname lib ".";

data tmp;
  retain name label clength format dispatch wave_summary;
  length wave_summary $25;
  set lib.randhrs1992_2020v1_map (drop=pattern_range);
  wave_summary = "";
run;

data  lib.randhrs1992_2020v1_map;
 set tmp;
run;

