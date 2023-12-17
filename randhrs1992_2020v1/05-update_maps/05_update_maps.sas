/* NOTE: autoexec.sas executed */
options mprint;

* Local macros loaded;
filename macros "&prj_path\&dir_name\_macros";
%include macros(zzz_xlsx_include);
%zzz_xlsx_include;


/* ===== Macros `_project_setup` executed  ===== */;
%_project_setup;

%_dir_setup();



/* Execute */
 ods listing close;
 ods html  path =     "&prj_path\&dir_name" (URL=NONE)
           file =     "05-updated_maps-body.html"
           contents = "05-updated_maps-contents.html"
           frame =    "05-updated_maps-frame.html"
 ;

%*_table_setup(HLong);
%zzz_xlsx_update;
endsas;
%_table_setup(RLong);
%zzz_xlsx_update;

%_table_setup(Rwide);
%zzz_xlsx_update;

%_table_setup(Rexit);
%zzz_xlsx_update;

ods html close;






