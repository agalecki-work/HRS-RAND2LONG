%macro sanitize_dispatch;
data _temp_;
 set _temp_;
 c1 = "*";
 if dispatch ne "" then do;
   c1 = substr(dispatch,1,1);
   if c1 = ":" then dispatch = substr(dispatch,2);
 end;

 if dispatch ne "" then do;
   c1 = substr(dispatch,1,1);
   if c1 = "`" then dispatch = substr(dispatch,2);
 end;
 drop c1;
run;
%mend sanitize_dispatch;
