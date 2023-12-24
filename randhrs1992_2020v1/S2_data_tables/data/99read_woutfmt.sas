options nofmterr;
ods hml;
libname lib '.';
proc print data=lib.rssi_table(obs=100);
run;
ods html close;