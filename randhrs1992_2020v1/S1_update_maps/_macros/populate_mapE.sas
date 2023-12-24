%macro populate_mapE;

/* Use `wave_pattern` variable to populate `wave_summary`and `waves_list` variables */
/* Macro variable `waves_list` is required  */

%put --- Macro populate_mapE.  waves_list := &waves_list;
data _temp_; 
 retain name label clength format dispatch wave_summary wave_pattern;
 set _temp_;
 array _waves {*} $15  &waves_list;
 length c2 $2;
 length ci $30; 
 countx = dim(_waves);
 wave_summary ="All episodes"; 
 
 if dispatch = "" then do;
  wave_summary = "N/A";
  wave_pattern = "RAND var";
 
 end;
 
 if dispatch = "=" then do;
   wave_summary = "All episodes";
   wave_pattern = tranwrd(upcase(name),"_E","[E]"); 
  end;
  
 
 if upcase(name) = "RSSI_EPISODE" then wave_pattern = "Num 1,2,3";
 
  if dispatch ne "" then do;
 do i=1 to countx;
    if i < 10 then c2 = strip(put(i, 1.));
    if i >= 10 then  c2 = put(i, 2.);
   ci = tranwrd(upcase(name),"_E", c2);  
   if upcase(name) = "RSSI_EPISODE" then ci = strip(put(i,3.));
   _waves[i] =ci;
 end;
 end;
 drop i countx ci c2;
 
run;
%mend populate_mapE;