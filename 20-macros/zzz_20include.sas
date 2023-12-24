%macro zzz_20include;

%put ===> Macro `zzz_20include` STARTS here ======;
%put Macros listed below will be loaded:; 

/*-- `zzz_20main_execute` */
%put  - macro `zzz_20main_execute`;
%include _macros(zzz_20main_execute);


/*-- `create_outdataY` */
%put  - macro `create_outdataY`;
%include _macros(create_outdataY);

/*-- `create_outdataN` */
%put  - macro `create_outdataN`;
%include _macros(create_outdataN);

/*-- `create_outdataE` */
%put  - macro `create_outdataE`;
%include _macros(create_outdataE);



/*-- `sort_base_logout` */
%put  - macro `sort_base_logout`;
%include _macros(sort_base_logout);


/*-- `rename_base_longout` */
%put  - macro `rename_base_longout`;
%include _macros(rename_base_longout);

/*-- `copy_formats_cntlin` */
%put  - macro `copy_formats_cntlin`;
%include _macros(copy_formats_cntlin);




%put ===> Macro `zzz_20include` ENDS here ======;


%mend zzz_20include;

