%macro _wave_pattern;
/*-- requires wave_pattern, tmpci and wavei variables */
/* Invoked by `create_vars_map2` macro  */
/* Based on pattern_range`, `wave_pattern` modifies tmpci */
put "--- Macro _wave_pattern starts";
length res $200;



/* if cell blank and wave scope are provided */ 
put tmpci= wavei= min_range= max_range= ;


if tmpci = "" and  min_range <= wavei <= max_range then do;
    /* Replace [w] with wavei */   
      res = strip(wave_pattern);    
      idx = indexc(res, '[w]');
      if idx then res = tranwrd(res, '[w]', strip(wavei)); 
  
   tmpci = strip(res);
end;

put "--- Macro _wave_pattern ends";


%mend _wave_pattern;

