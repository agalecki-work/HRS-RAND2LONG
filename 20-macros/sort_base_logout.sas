%macro sort_base_logout;
%if (%length(&sortedby) > 0) %then %do;
proc sort data = _base_longout;
by &sortby;   *hhid pn wave_number;
run;
%end;
%mend sort_base_logout;