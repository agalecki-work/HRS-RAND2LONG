
%macro sanitize_vars;
%put --- Macro `sanitize_vars` STARTS here;
%put vars_map := &vars_map;
  %sanitize_clength;
  %if  &vars_map =Y %then %sanitize_dispatch;;

  /* `map_info` resolves to libout.&mapx ( ) */
  data &map_info;
   set _temp_;
  run;
%put --- Macro `sanitize_vars` EXITS here;

%mend sanitize_vars;

