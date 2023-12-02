%macro rename_base_longout;
/* Move and rename  `_base_longout` from `work` to `libout` SAS library */
%put outdata= &outdata;
%let res = %sysfunc(tranwrd(&outdata, libout., %str()));
%put outdata_name := &res;

proc datasets library = work nolist;
   change _base_longout = &res;
run; 
   copy in=work out=libout memtype=data move;
   select &res;
run;
quit;
%mend rename_base_longout;