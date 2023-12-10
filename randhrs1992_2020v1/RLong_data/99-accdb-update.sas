libname lib ".";
options mprint;
%let data = randhrs1992_2020v1_map;

%macro sas_map2dbf;
proc contents data=lib.&data position;
run;

/* update wave_summary variable */
data _temp;
 set lib.&data;
 array _waves {*} $ hrs_wave1-hrs_wave15;
 length ci  $30; 
 * length c2 $2;
 countx =0;
 do i=1 to dim(_waves);
  ci = _waves[i];
  if ci ne "" then countx+1;
 end;
 if countx >0 then do;
 done =0;
  wave_summary ="ooooOooooOooooO";
 do i=1 to dim(_waves);
   ci = _waves[i];
   if ci ne "" then substr(wave_summary,i,1)="x";
   if ci ne "" and i in (5,10,15) then substr(wave_summary,i,1)="X";
  
  if ci ne "" and i <10 and wave_pattern = "" and done =0 then do;
    done =1;
    substr(ci,2,1) = "?";
    wave_pattern =tranwrd(ci,"?","[w]"); 
   end;  /* if ci ..., i < 10*/
  if ci ne "" and i >=10 and wave_pattern = "" and done =0 then do;
      done =1;
      substr(ci,2,2) = "?";
      wave_pattern =tranwrd(ci,"?","[w]"); 
     end;  /* if ci ...,i>=10 */
 
  
  end; /* do i */
 end; /* if countx >0 */
 drop i countx ci done;
 
run;

proc print data = _temp;
var name  wave_summary wave_pattern;
run;

proc freq data=_temp;
tables wave_summary ;
run;

/* Create accdb file */
proc export data= _temp
  outtable ="RAND_MAP"
  dbms= access
  replace; 
  database="&data..accdb";

run;
quit;

%mend sas_map2dbf;


%macro dbf_map2sas;
/* Create SAS dataset */
PROC IMPORT DATATABLE="RAND_MAP"
            out   =lib.&data._updated
            DBMS=ACCESS 
	    REPLACE;
DATABASE = "&data..accdb";
DBDSOPTS='READBUFF=730';		
run;
%mend dbf_map2sas;

%*sas_map2dbf; /* From SAS to DBF. Use MSACCESS to edit */
%dbf_map2sas; /* From updated DBF_MAP to SAS_MAP with _updated postfix */

