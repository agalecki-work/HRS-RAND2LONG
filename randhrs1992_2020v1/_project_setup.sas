%macro _project_setup;
/* Macro vars `repo_name`, `repo_path`, `prj_name`, `dir_name` defined in `_project_auto.inc` */
%put --- `_project_setup` macro STARTS here;

/* Declare global macro variables */
%global repo_path repo_name prj_name dir_name;
%global xlsx_path xlsx_name dir_path table_version;
%global datain wide_datain formats_cntlin map_file;
%global fcmp_src_path;

%let prj_path = &repo_path\&prj_name;

/*------ Excel file multiple maps (required)------*/
%let xlsx_nickname = randhrs1992_2020v1_maps;   /* test_maps  */
%let xlsx_date =13DEC2023;
%let xlsx_path = C:\temp;
%let xlsx_name =&xlsx_nickname&xlsx_date;   
%let table_version = &repo_version-&xlsx_date;



/*--------- RAND and cntlin datasets in `LIBIN` libref    -----------*/

libname LIBIN "C:\temp" access=readonly;
%let DATAIN = randhrs1992_2020v1;
%let wide_datain = libin.&datain;
%let formats_cntlin = libin.sasfmts;


%put --- Global macro vars defined in `project_setup.inc`;
%put repo_version    := &repo_version;
%put repo_path       := &repo_path;
%put prj_name        := &prj_name;

%put xlsx_nickname   := &xlsx_nickname;
%put xlsx_date       := &xlsx_date;
%put xlsx_name       := &xlsx_name;


%put xlsx_path       := &xlsx_path;
%put xlsx_name       := &xlsx_name;
%put table_version   := &table_version;

%put DATAIN          := &datain;
%put formats_cntlin  := formats_cntlin;
%put fcmp_src_path   := &fcmp_src_path;
%put --- `project_setup` macro ENDS here`;
%mend _project_setup;






