%macro import_xlsx_map;

%let tmp = &xlsx_path/&xlsx_name..xlsx;
proc import 
    out=_temp_ 
    datafile="&tmp" 
    dbms=xlsx
    replace;
    sheet = "&mapx";   
    getnames=YES;
    *mixed =YES;
run;

%mend import_xlsx_map;