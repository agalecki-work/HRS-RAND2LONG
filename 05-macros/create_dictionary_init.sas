%macro create_dictionary_init;

data dictionary_init;
  set _MAP2Long(keep= varnum name label clength format);
run; 

proc sql noprint;
alter table dictionary_init
  modify clength char(5) format = $5.;
quit;

%traceit(dictionary_init);

%mend create_dictionary_init;
