
%macro create_outdata_wide(datain);
 /* Creates and appends `_outdata` */
    
 data _outdata;
   if 0 then set _template_longout;
    set &datain(keep= %keepvar_list);
  run;
 
 proc append base = _base_longout
             data= _outdata;
 run;
%mend create_outdata_wide;
