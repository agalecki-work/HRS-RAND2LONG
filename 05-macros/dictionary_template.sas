%macro dictionary_template;

%put --->> Macro `dictionary_template`: Dataset `dictionary_template` created;



data dictionary_template;
 label varnum = "Variable number";
 label name   = "Variable name";
 label label  = "Variable label";
 label clength= "Character variable length";
 label format = "Variable format";
 
 
 /* Length statements */
   length name $32;
   length label $256;
   length clength $5;
   length format $32;
 
 /* Informat statements */
   informat name $32.;
   informat label $256.;
   
  informat clength $5.;
   informat format $32.;
  
 
/* format statements */
    format name $32.;
    format label $256.;
    format clength $5.;
    format format $32.;  
 call missing(of _all_);
  stop;

run;
%put --- Dataset `dictionary_template` contains 0 obseravtions;
%mend dictionary_template;
