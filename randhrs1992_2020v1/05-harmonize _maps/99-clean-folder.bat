::: PREAMBLE starts
pushd %~dp0
:: Define `cdir`
set "cdir=%CD%"
cd %CDIR%
echo  ... xlsx,sas7bdat in this folder will be deleted
timeout /t 30
dir *.xlsx
del *.log 
del *.lst
del *.xlsx
del *.sas7bdat

