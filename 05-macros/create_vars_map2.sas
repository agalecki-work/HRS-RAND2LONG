%macro create_vars_map2;
/* Create vars_map2 with expanded rows in `vars_map` */;
data vars_map2;
  retain stmnt_no vout dispatch dispatch2 
         eq  q dispatch_type sym_expression option op wave_pattern;
   length sym_expression $200;
  length tmpci $300;
  * length tmpc $200;
  length op $2;
  array waves_list {*} $300 &waves_list;

  set vars_map1;
  stmnt_no = _n_;
  
  * put "====>>>" vout = " STARTS ===========";
  
  /*-- dispatch2 ----*/
  length dispatch2 $200;
  label dispatch2= "Dispatch: `=` replaced with `=?`";
  length tmpc2 $2;
  tmpc2 = compress(dispatch);

  dispatch2 = strip(dispatch);
  if strip(tmpc2) in ("=",  "=?") then dispatch2 = "=?";
  
  /* Define dispatch_type variable */
  
  if dispatch2 ne "" then c1= substr(strip(dispatch2),1,1);
           else c1=""; * First character in dispatch;
  label eq = "Indicator, whether the first character in `dispatch2` is `=`";
  
  label op = "Operator: `=` or blank";
  if c1 ="`" then dispatch2 = substr(dispatch2, 2); /* Leading left apostroph  removed */
  if c1 eq "=" then eq ="Y"; else eq="N";
  if c1 eq "=" then op ="= "; else op =" ";
 
  label q = "Indicator, whether  `?` is present in `dispatch2` ";
 
  qidx = index(dispatch2, "?");     * Index for question mark;
  if qidx>0 then q= "Y"; else q = "N";
  
  
  
  label dispatch_type ="CP:`cp, wave_inv`, YY:`eq_sign and qmark-yes`, YN:`eq_sign and no qmark`";
  dispatch_type = eq||strip(q);
  if dispatch2 = ""  then dispatch_type = "CP";
  if vout = '_DATAIN_NAME_' then dispatch_type = "DT";
  /*  */
  sym_expression = dispatch2;
  label sym_expression = "Drop leading equal sign from dispatch2, if present";
  if eq= "Y" and length(dispatch2) > 1 then 
       sym_expression = substr(dispatch2, 2); /* Skip first character */
   
  
  drop  qidx c1;

   label option = "Populate empty cells in `vars_map1`: 1. pad cells _BLANK_ string, 2. all cells with sym_expression";
  /* Select option on how to populate empty cells in `waves list` array */
   select(dispatch_type);
    when ("YY") option =1; /*  `= ?` Conditionally with _BLANK_ string */ 
    when ("NY") option =4; /*  `  ?` Replace `?` with cell contents */ 
    when ("YN") option =2; /* 2. replace all cells with sym_expression*/
    when ("NN") option =5;
    when ("DT") option =6;
    when ("CP") option =3;
    otherwise option = 9; /* waves list array not changed*/
   end;
  
   put  "   =>>> " stmnt_no = vout =  option= ;
   %_wave_pattern_init;
   
   %let tmpi = wavei = &waves_sel;
   %put tmpi := &tmpi;
  
   do &tmpi; ** to dim(waves_list); /* do over selected `wavei` */
     tmpci = strip(waves_list[wavei]);
       *put wavei=  tmpci = ;
       
       /*-- (skip [-] cells, do not over-write non-empty cells --*/ 
       %_wave_pattern; /* use ` wave_pattern` vars to populate empty cells */
       *put tmpci =;    
       /*-- if cell is blank  */
        if tmpci = "" then do;
          /*--- populate empty cells with simple `sym_expression` ---*/
          if option in (2,5,6)   then tmpci = strip(sym_expression);
         end;
    
       if tmpci ne "" then do;
        /* Non blank cells modified: question mark in `sym_expression` resolved */
        select(option);
          when(1) tmpci = tranwrd(sym_expression, "?", strip(tmpci));  /* YY: `= ?` */
          *when(2) tmpci = strip(sym_expression);                       /* YN: `=  ` */  
          when(3) tmpci = "";                                          /* CP: `   ` */
          when(4) tmpci = tranwrd(sym_expression, "?", strip(tmpci));
          *when(5) tmpci = strip(sym_expression);
          otherwise;
        end; /* end select */
       
      * put "--" tmpci=;
       end;  /* endif tmpci ne blank */
       
       *put tmpci =;
       if q="Y" and tmpci="" then tmpci ="_BLANK_CELL_MAP_"; 
       waves_list{wavei} = strip(tmpci);
   end;  /* do wavei */
  * put "--- loop iterations ended"; 
  
  drop wavei tmpci tmpc2 clist res idx;
run;
%mend create_vars_map2;
