%macro put_init_vars(dtin_no, dtin_nm);
/*---  Init vars statements ---*/

data _null_;
  file map_file mod ;
  set _dictionary2 end = eof;
  length mname $50;
  
  mname =  '_out_varsinit' || strip(put(&dtin_no, 3.)); /* _table_varsinit1, ... */
  length txt txtx txtc  $50;
  txt  = '/* ' || strip(name ) || ' variable already included  */';     /* _dtin_no=1          */
  txtc  =  strip(name) || " = '*';";                            /* _dtin_no=0 type = 2 */
  txtx  =  strip(name) || " = ._;";                             /* _dtin_no=0 type = 1 */
  if _n_=1 then do;
     put '%macro ' mname ';';
     put "/*  Initilize (if needed) output variables that are (already) not included in the input dataset */";
   end;
   _dtin_no = datain&dtin_no;   

     if _dtin_no = 1  then put @3 txt;
     if _dtin_no = 0  then do;
       if clength = "" then put @3 txtx;
        else put @3 txtc;
     end;
   if eof then put '%mend ' mname ';';
run;


%mend put_init_vars;