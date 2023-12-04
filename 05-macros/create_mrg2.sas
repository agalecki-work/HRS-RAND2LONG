%macro create_mrg2;
proc transpose data = vars_map2
                out = tvars(drop =_label_) name = wave_name
                prefix = varxin;

var &waves_list;
by stmnt_no;
run;

/* Variable varxin1 contains values of variables, symbolic formulae (with ?
  or _BLANK_CELL_ */
data tvars2;
 set tvars;
 **if varxin1 in ("", "'_BLANK_CELL_'")   then delete;
run;

/* Merge */

proc sort data=waves_info;
by wave_name;
run;

proc sort data = tvars2;
by wave_name;
run;

data mrg1;
 merge tvars2 waves_info (keep= wave_no wave_name datain_name);
 by wave_name;
run;

proc sort data=mrg1;
by stmnt_no;
run;

data mrg2;
 retain stmnt_no wave_no wave_name wave_pattern pattern_range  varxin1 op dispatch_type option stmnt; 
 merge mrg1(in=in1) 
       vars_map2(keep = stmnt_no vout dispatch dispatch_type op eq  sym_expression option wave_pattern pattern_range 
         in=in2);
 by stmnt_no;
 /* eq =Y if equals sign */
 length stmnt $200;
 keepit =0;
 if wave_no ne . then keepit=1;
 ***ATG?? if dispatch ne "" then keepit=1;
 if keepit;
 if eq ="Y" and option ne 6 then stmnt = strip(vout)||' = '||strip(varxin1);
 if eq ="N" and option in (1,2,3,4) then stmnt = strip(varxin1);
 if option =6 then stmnt = strip(varxin1);
 drop keepit;
 
run;

proc sort data=mrg2;
by /* datain_name*/ wave_no stmnt_no;
run;

proc sort data=waves_info;
by wave_no;
run;

%if &traceit = Y %then 
   %traceit(mrg2);


%mend create_mrg2;
