%macro create_vars_map1;
/* Dataset `vars_map1` derived from a simple `map_info`*/

data vars_map1;
 if 0 then set vars_map_template; 
 set vars_map_init;
 /* Create vout variable */
    length  c1 $1; /* First character in `dispatch` */
 vout = strip(name);
 if dispatch = "" then  c1 = "";
   else c1= substr(strip(dispatch),1,1);
 if c1 ="`" then dispatch = translate(dispatch,"","`");
 if dispatch = "" then  c1 = "";
    else c1= substr(strip(dispatch),1,1);

 if c1 eq "=" then eq ="Y"; else eq="N";
 * eq0 =eq;
 drop name c1 eq; 
run;

%if &traceit = Y %then 
    %traceit(vars_map1);
       
  /* `vars_map1` modified */

  /* _Conditionally_ inserts _datain_ row using dataset name stored in `DATAIN_NAME` macro variable */
   %insert_datain_row; 
 
   %if &traceit = Y %then 
     %traceit(vars_map1);

%mend create_vars_map1;
