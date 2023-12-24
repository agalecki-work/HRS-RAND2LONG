
%macro create_outdataY(datain);
 /* Creates and appends `_outdata` for vars_map =Y*/
 /* Macros 
    `preprocess_datain1`, 
    `process_selected_waves`, 
    `postprocess_dataout` 
    were created by `05-create-macros.sas` */
    
 data _outdata;
   if 0 then set _template_longout;
    set &datain;
    %preprocess_datain1; 
    %process_selected_waves;
    %postprocess_dataout;
 run;
 
 proc append base = _base_longout
             data= _outdata;
 run;
%mend create_outdataY;
