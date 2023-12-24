
%macro vars_map_template;
/* Create data template for `vars_map` dataset */

%create_waves_elist(vars_map_init, &waves_list); /* & map_info */


%let nwords = %sysfunc(countw(&waves_elist, ' '));
data vars_map_template;
 label vout           = "Output variable name. For multiple vars. description only. ";
 label dispatch       = "Dispatch expression";
 ***label pattern_range     = "Wave range. Ex. 6:? "; 
 label wave_pattern   = "Wave_template";

   %do i =1 %to &nwords;
     %let wordi = %scan(&waves_elist, &i, ' ');
     label &wordi = "%upcase(&wordi)"; 
   %end;
 
 
 /* Length statements */
   length vout $100;
   length dispatch wave_pattern  $200;

   %do i =1 %to &nwords;
       %let wordi = %scan(&waves_elist, &i, ' ');
       length  &wordi $32;
   %end;
   
  /* Informat statements */
   informat vout $100.;
   informat dispatch  wave_pattern  $200.;
   %do i =1 %to &nwords;
     %let wordi = %scan(&waves_elist, &i, ' ');
     informat &wordi $300.;
   %end;
 
 
/* format statements */
    format vout $100.;
    format dispatch  wave_pattern $200.;
    %do i =1 %to &nwords;
         %let wordi = %scan(&waves_elist, &i, ' ');
         format &wordi $300.;
    %end;
  
 call missing(of _all_);
  stop;

run;

%put expanded waves_list := &waves_elist;
%traceit(vars_map_template);

%mend vars_map_template;
