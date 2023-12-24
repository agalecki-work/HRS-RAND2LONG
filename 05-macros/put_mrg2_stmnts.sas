%macro put_mrg2_stmnts;
%if (&vars_map =Y or &vars_map =E) %then %do;
/*-- Create macros with DATA step statements for processing a given wave --- */
data _null_;
  file map_file mod ;
  set mrg2  end = eof;
  by datain_name wave_no stmnt_no;
  if first.wave_no then do;
   put / '%macro _'  wave_name  +(-1) ';';
   put '/* Macro will be invoked from inside of the DATA step */ '; 
   put @3 "/* -- Notes: ------------";
   put @ 5 "N12. y = ? or y = x";
   put @ 5 "N3. Variable copied/taken from input data";
   put @ 5 "N4. f(?,y)";
   put @ 5 "N5. f(x,y) option not used";
   put @ 5 "N6. Datain name (commented out)";
   put @5  " -- Comments:";
   put @5  "C1: Blank cell";
   put @5  "C2: Skipped cell [-]";
   put @5  "----------------*/" /;
   put @3  '%preprocess_wave;';
  end;
  if mod(stmnt_no, 10)= 0 then put /; 
  select(varxin1);
    when ("_BLANK_CELL_MAP_") tt=1;
    when ("[-]")              tt=2;
    otherwise;
  end;

 if tt= 1 then do;
  put " /*-- " vout " (see C1) */"; 
  stmnt = "";
 end;
 
 if tt= 2 then do;
   put " /*-- " vout " (see C2)*/"; 
   stmnt = "";
 end; 
  
 if option = 4 then do;
      if varxin1 ne "_BLANK_CELL_MAP_" then put @2 stmnt +(-1) ";   /* N4 */ ";
      stmnt="";
 end;

  if varxin1 ne "_BLANK_CELL_MAP_" and stmnt ne "" then do;
  select(option);
   when (6) put @2 "/*-- DATAIN: " stmnt " N6 */"; 
   when (3) put @2 "/*-- " vout  " N3 */";   
   when (1,2) put @3 stmnt +(-1) ";  /* N12 */ ";
   otherwise;
  end; 
  end;
  
           
  if option = 4 and tt ne 1 then
    put @2 '/*-- ' vout ' (see C2)  */';  /* comment */
  
     
  if last.wave_no then do;
    put @3 '%postprocess_wave;'; /* output */
    put '%mend _'  wave_name  +(-1) ';';
   put / ;
  end;
run;
%end;

%mend put_mrg2_stmnts;
