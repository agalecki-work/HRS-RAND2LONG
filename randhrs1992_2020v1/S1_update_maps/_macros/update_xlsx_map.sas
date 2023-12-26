%macro update_xlsx_map;
%put ===> Macro `update_xlsx_map` STARTS;

%put xlsx_path   := &xlsx_path;
%put xlsx_name   := &xlsx_name;
%put vars_map    := &vars_map;

%import_xlsx_map;


/*=== Increase length of selected variables ==== */
/* - clength variable */
proc sql noprint;
alter table _temp_
  modify clength char(5) format = $5.;
quit;

/* - wave_pattern variable */
%if (&vars_map = Y) or (&vars_map = E)  %then %do;
proc sql noprint;
alter table _temp_
  modify wave_pattern char(40) format = $40.;
quit;
%end;

%if (&vars_map = N) or (&vars_map =E) %then %do;
data _temp_;
  set _temp_;
  if upcase(strip(name)) = "INW" then delete;
%end;

%sanitize_clength;
%if (&vars_map =Y) or (&vars_map = E) %then %sanitize_dispatch;


data _temp_;
 retain varnum;
 set _temp_;
 varnum =_n_;
run;


%if (&vars_map =Y) %then %populate_mapY;
%if (&vars_map =E) %then %populate_mapE;



data _libmap.&mapx (label = "Map Table &mapx created from &xlsx_name..xlsx on &sysdate");
 set _temp_;
run;

%put --- Macro `update_xlsx_map` EXIT;
%put; 
%mend update_xlsx_map;
