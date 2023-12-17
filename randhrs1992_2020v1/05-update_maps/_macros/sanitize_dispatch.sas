%macro sanitize_dispatch;
%put --- sanitize_dispatch STARTS ---;
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
%put --- sanitize_dispatch ENDS ---;

%mend sanitize_dispatch;
