
%macro create_outdataN(datain);
 /* Creates and appends `_outdata` for vars_map = N*/
 
 
    
 data _outdata;
   if 0 then set _template_longout;
    set &datain(keep= %keepvar_list);
  run;
 
 proc append base = _base_longout
             data= _outdata;
 run;
%mend create_outdataN;
