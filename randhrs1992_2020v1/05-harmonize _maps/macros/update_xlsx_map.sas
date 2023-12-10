%macro update_xlsx_map;

%*excelxls;
%import_xlsx_map;

proc sql noprint;
alter table _temp_
  modify clength char(6) format = $6.;
quit;

%if (&mtype =2) %then %do;
proc sql noprint;
alter table _temp_
  modify wave_pattern char(40) format = $40.;
quit;
%end;



/* Dataset _temp_ was created */
data _temp_;
    set _temp_;
 c1 = "*";
 if clength ne "" then c1=substr(clength,1,1);
 if c1 in ("=","$") then clength = "`"||strip(clength); 

 drop c1;
run;

%if (&mtype =1) %then %do;
data _temp_;
  set _temp_;
  if upcase(strip(name)) = "INW" then delete;
%end;

data _temp_;
 retain varnum;
 set _temp_;
 varnum =_n_;
run;


%if (&mtype =2) %then %do;
%populate_mtype2;


data _temp_;
    set _temp_;
 c1 = "*";
 if dispatch ne "" then c1= substr(dispatch,1,1);
 if c1 in ("=","$") then dispatch = ":"||strip(dispatch); 
 drop c1;
run;

data lib.&mapx;
 set _temp_;
run;

ods excel file ="&mapx..xlsx";
proc print data = lib.&mapx;
run;
ods excel close;

%end;


%mend update_xlsx_map;
