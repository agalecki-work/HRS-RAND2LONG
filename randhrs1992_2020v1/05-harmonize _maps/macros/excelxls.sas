%macro excelxls;
/* libname excelxls "xlsx path" */
/*  Keep clength and dispatch as character variables (not sure, if necessary)*/
/* Excel with multiple maps */
/* 
--- Template
data _temp_;
set excelxls.'RLONG_map$'n (DBSASTYPE=(dispatch ='CHAR(44)'));
run;
*/



libname excelxls Excel "../&xlsx_name..xlsx";

data stmnt;
 length init dbv $200;
 length stmnt $300;
 mapx =symget('mapx');
 init = "set excelxls.'"||strip(mapx)||"$'n;";
 dbv  = "clength='CHAR(4)' dispatch='CHAR(44)'";
 stmnt = strip(init); /* ||" (DBSASTYPE=("||strip(dbv)||"));" */
run;

proc print data=stmnt;
var stmnt;
run;


data _null_;
 set stmnt end =eof;
 if _n_ =1 then call execute("data _temp_;");
 call execute(stmnt);
 if eof then call execute ("run;");
run;
%mend excelxls;