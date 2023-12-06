function hrs_studyyr(wv, HA); 
/* Mapping HRS wave to study year

wv = 1                  -> 1992
wv = 2  and HA in (0,1) -> 1993
wv = 2  and HA =3       -> 1994
wv = 3  and HA in (0,1) -> 1995
wv = 3  and HA =3       -> 1996
wv = 4                  -> 1998
wv = 5                  -> 2000
...
wv = 15                 -> 2020
*/

yr = 1990 + 2*wv; /* Tentatively every two years */
 
if wv = 2 and HA in (0,1) then yr =1993;
if wv = 2 and HA = 3      then yr =1994;
if wv = 3 and HA in (0,1) then yr =1995;
if wv = 3 and HA = 3     then yr =1996;
 
 * if wv in (2,3,4,5) then put wv= HA= studyyr=;
 return (yr);
endsub;


function height_m(h);
 /* Included for illustration only*/
 /* h argument is height expressed in meters */
 /* Height outside of range set to missing */
 hx = h;
 if  not ( 0.9 < h < 2.5) then hx =.;
 return(hx);
endsub;

function bsa(h,w);
 /* Included for illustration only*/
 /* Body surface calculations using Du Bois and Du Bois formula */
 /* h argument is height in meters */
 /* w argument is weight in kg */
 hcm  = h*100;
 hx = hcm ** 0.725;
 wx = w ** 0.425;
 bsa = 0.007184* hx *wx;
 return(bsa);
endsub;

subroutine R_ACGTOT_SUB(vin, vout);
 outargs vout;
 vout = vin/10;
endsub;




