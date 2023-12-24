%macro _usetup_mvars;
%put --- Macro `_usetup_mvars` STARTS ;  
%global vars_map waves_list waves_sel waves_elist;

/* Table name `tbl` required */
%put --- Macro `_usetup_mvars` STARTS here;
%put Table := &tbl;


%let vars_map=N;
%if %upcase(&tbl) = RLONG %then %let vars_map=Y;
%if %upcase(&tbl) = HLONG %then %let vars_map=Y;
%if %upcase(&tbl) = RSSI  %then %let vars_map=E; /* SSI/SSDI Episodes */

%let waves_list =;
%let waves_sel =;

%if &vars_map =Y %then %do;
  %let waves_list = hrs_wave1- hrs_wave15;     /* List of variables with _all_ wave names  */
  %let waves_sel =  1 to 15;                   /* use `do loop` syntax for index value*/
  
%end;

%if &vars_map =E %then %do;
  %let waves_list = ssi_E1- ssi_E11;     /* List of variables in table map with SSI/SSDI episodes  */
  %let waves_sel =  1 to 11;                /* use `do loop` syntax for index value*/
%end;

%put --- Macro vars created in `_usetup_mvars` macro;
%put vars_map    := &vars_map;
%put waves_list  := &waves_list;
%put waves_sel   := &waves_sel;


%put --- Macro `_usetup_mvars` ENDS here;
%mend _usetup_mvars;


