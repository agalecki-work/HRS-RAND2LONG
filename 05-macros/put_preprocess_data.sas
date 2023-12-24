%macro put_preprocess_data;
data _null_;
  file map_file mod;
  mname = 'preprocess_data';
  put / '%macro ' mname ';';
  put "/* Table &tbl: Code for preprocessing data */";
  put '%mend ' mname ';';
%mend put_preprocess_data;
