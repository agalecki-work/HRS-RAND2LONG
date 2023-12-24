%macro create_dictionary;
data _dictionary;
 if 0 then set dictionary_template; 
   set dictionary_init;
   * varnum = _n_;
   name_valid = nvalid(name, 'v7'); 
 run;

 %traceit(_dictionary);


/* Check for duplicate names in `_dictionary` dataset  */
/* Datasets: `_FREQ_DUPKEY_` `_MRGD_DUPKEY_` created */
/* They should have zero observations */
%checkdupkey(_dictionary, name);


%mend create_dictionary;
