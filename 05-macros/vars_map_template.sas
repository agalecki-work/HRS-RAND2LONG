%macro vars_map_template(vars_map, waves_list);

/* 
  vars_map: SAS dataset with map info 
  waves_list: list of variables  with wave names

*/

/* Expand `waves_list` macro variable */

data waves_list;
   set vars_map_init(keep = &waves_list);
   stop;
run;

proc transpose data=waves_list out = twaves_list
               name = name; /* label = label; */
var &waves_list;
run;

proc sql noprint;
   select name into :waves_elist separated by  " "  from  twaves_list;
quit;

%put waves_elist := &waves_elist;


/* Create data template for `vars_map` dataset */
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
%mend vars_map_template;
