%macro zzz_20include;

%put ===> Macro `zzz_20include` STARTS here ======;
%put Macros listed below will be loaded:; 

/*-- `zzz_20main_execute` */
%put  - macro `zzz_20main_execute`;
%include _macros(zzz_20main_execute);


/*-- `create_outdata` */
%put  - macro `create_outdata`;
%include _macros(create_outdata);


/*-- `create_outdata_wide` */
%put  - macro `create_outdata_wide`;
%include _macros(create_outdata_wide);



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

