# RAND HRS Longitudinal File 2020

In this document we describe step-by-step on how to convert **RAND HRS Longitudinal File 2020** from wide format to a long format.

# Preparatory steps

##  Download RAND HRS Longitudinal File 2020
 
* Download `randhrs1992_2020v1_SAS.zip` file available 
[here](https://hrsdata.isr.umich.edu/data-products/rand-hrs-longitudinal-file-2020). 
* Store `randhrs1992_2020v1.sas7bdat` and `sasfmts.sas7bdat` files in a folder of your preference.

Notes: 

* You will need to register with HRS website to access the data
* We will refer to `randhrs1992_2020v1.sas7bdat` and `sasfmts.sas7bdat` datasets
as **DATAIN** and **FORMATS_CNTLIN**, respectively.

## Prepare `MAP_INFO` dataset

* Prepare SAS dataset referred to as **MAP_INFO** that contains information about mapping of the **DATAIN** dataset from wide to long format.
* For user covenience this dataset named `randhrs1992_2020v1_map.sas7bdat` has been already prepared.

## Prepare FCMP functions

* Prepare SAS FCMP functions needed for data conversion.
* For user covenience the FCMP code  has been already prepared and was stored in  `./20-usource/FCMP_src.sas` file.

# Main programs

RAND data conversion is performed in two steps:

* Step 1: Generate file with auxiliary SAS macros.
* Step 2: Create **OUTDATA** dataset in long format.

## Step 1: Generate **MAP_FILE** file with auxiliary SAS macros

Run `05-create-macros.sas`

* Input: *MAP_INFO* and *DATAIN* datasets      
* Output: 
    - Text file referred to as **MAP_FILE** that contains SAS macros used in Step 2.
    - (Optional) auxiliary output in `./05-aux_out` subfolder 
      
## Step 2: Create **OUTDATA** dataset in long format.

Run `20-wide2long.sas`

* Input: **MAP_FILE** created in Step 1, **DATAIN** and **FORMATS_CNTLIN** datasets
         FCMP code (see above)
* Output: **OUTDATA** and  **OUTDATA_FORMATS** datasets stored in `./20-out` subfolder
    - 
# Auxiliary programs

* `25-read-wout-fmts.sas` Reads **OUTDATA** dataset without using SAS formats
* `26-read-with-fmts.sas` Reads **OUTDATA** dataset with SAS formats