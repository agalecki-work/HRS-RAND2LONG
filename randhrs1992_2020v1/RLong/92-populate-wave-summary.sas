/* Auaxiliary 
program */
libname lib ".";
%let data_map=randhrs1992_2020v1RL_map;

/* populates wave_summary variable */
data lib.&data_map._92; /* postfix _92 added */
 set lib.&data_map;
 array _waves {*} $ hrs_wave1-hrs_wave15;
 length ci $30; 
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
 drop i countx ci ctmp c2 done;
 
run;

