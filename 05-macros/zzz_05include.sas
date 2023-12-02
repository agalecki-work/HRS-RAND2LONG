%macro zzz_05include;

%put ===> Macro `zzz_05include` STARTS here ======;
%put Macros listed below will be loaded:; 

%let HRS_RAND2LONG_version=Nov2023-v0.1;

/*-- `zzz_main_05execute` */
%put  - macro `zzz_05main_execute`;
%include _macros(zzz_05main_execute);

/*-- `traceit_print` */
%put  - macro `traceit_print`;
%include _macros(traceit_print);

/*-- `traceit_contents` */
%put  - macro `traceit_contents`;
%include _macros(traceit_contents);

/*-- `traceit` */
%put  - macro `traceit`;
%include _macros(traceit);

/*-- `vars_map_template` */
%put  - macro `vars_map_template`;
%include _macros(vars_map_template);

/*-- `dictionary_template` */
%put  - macro `dictionary _template`;
%include _macros(dictionary_template);

/*-- `checkdupkey` */
%put  - macro `checkdupkey`;
%include _macros(checkdupkey);

/*-- `insert_datain_row` */
%put  - macro `insert_datain_row`;
%include _macros(insert_datain_row);

/*-- `contents_data` */
%put  - macro `contents_data`;
%include _macros(contents_data);

/*-- `attrn_nlobs` */
%put  - macro `attrn_nlobs`;
%include _macros(attrn_nlobs);

/*-- `create_waves_info` */
%put  - macro `create_waves_info`;
%include _macros(create_waves_info);

/*-- `create_waves_allinfo` */
%put  - macro `create_waves_allinfo`;
%include _macros(create_waves_allinfo);


/*-- `_wave_pattern` */
%put  - macro `_wave_pattern`;
%include _macros(_wave_pattern);


/*-- `_wave_pattern_init` */
%put  - macro `_wave_pattern_init`;
%include _macros(_wave_pattern_init);


/*-- `aug_dict` */
%put  - macro `aug_dict`;
%include _macros(aug_dict);



/*-- `create_dictionary2` */
%put  - macro `create_dictionary2`;
%include _macros(create_dictionary2);


/*-- `create_vars_map2` */
%put  - macro `create_vars_map2`;
%include _macros(create_vars_map2);

/*-- `create_mrg2` */
%put  - macro `create_mrg2`;
%include _macros(create_mrg2);

/*-- `save_aux_data` */
%put  - macro `save_aux_data`;
%include _macros(save_aux_data);

/*-- `contents_aux_data` */
%put  - macro `contents_aux_data`;
%include _macros(contents_aux_data);


/*-- `put_init_vars` */
%put  - macro `put_init_vars`;
%include _macros(put_init_vars);


/*-- `put_preprocess_datain` */
%put  - macro `put_preprocess_datain`;
%include _macros(put_preprocess_datain);

/*-- `put_postprocess_dataout` */
%put  - macro `put_postprocess_dataout`;
%include _macros(put_postprocess_dataout);



%put ===> Macro `zzz_05include` ENDS here ======;


%mend zzz_05include;

