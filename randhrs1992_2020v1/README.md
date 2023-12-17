* =============== PROGRAM: 20-wide2long.sas =================================== 
   RELEASE DATE: NOV 30 2023
   WRITTEN BY Jinkyung Ha, Mohammed Kabeto, and Andrzej Galecki 
* ================================================================================== ;


* This program reshapes and recodes WIDE dataset into long format.;
* Project has been supported by Pepper Center grant;
Unique identifiers
Based on Table 2 on page 27/48

https://hrs.isr.umich.edu/sites/default/files/biblio/OverviewofHRSPublicData.pdf

|Levels:

Respondent: HHID PN WAVE_NUMBER
Household:  HHID ?  WAVE_NUMBER
Helper: HHID PN OPN HLPTYPE WAVE_NUMBER


Notes;
 In table #2 ?SUBHH is used. We use 