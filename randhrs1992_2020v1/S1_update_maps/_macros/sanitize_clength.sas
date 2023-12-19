%macro sanitize_clength;
%put --- sanitize_clength STARTS ---;
data _temp_;
 set _temp_;
 c1 = "*";
 if clength ne "" then do;
   c1 = substr(clength,1,1);
   put clength =  c1=;
   if c1 = ":" then clength = substr(clength,2);
 end;

 if clength ne "" then do;
   c1 = substr(clength,1,1);
   put clength =  c1=;
   if c1 = "`" then clength = substr(clength,2);
 end;
 drop c1;
run;
%put --- sanitize_clength ENDS ---;

%mend sanitize_clength;
