cd "C:\Users\pide1362\Dropbox\EcoGeog\replication\data"

import excel "TableNAICS.xlsx", sheet("Table") cellrange(A6:AB5820) firstrow clear
destring LineCode, replace

egen id =group(GeoName LineCode)

//create state-employment in 2000

gen NAICSemp=Y2000
reshape long Y, i(id) j(year)
rename Y emp 
gen totemp2=emp
replace totemp2 ="." if LineCode!=20
destring totemp2, replace

//create state totalemployment
egen totemp=max(totemp2), by(GeoName year)
drop totemp2

gen totfarm2=emp
replace totfarm2 ="." if LineCode!=70
destring totfarm2, replace

//create state totalemployment
egen totfarm=max(totfarm2), by(GeoName year)
drop totfarm2

xtset id year

replace totemp=totemp-totfarm

//keep toplevel codes only
gen keeplev=0
local codes 100 200 300 400 510 530 600 700 800 900 1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000
foreach i of numlist `codes'  {
    replace keeplev=1 if LineCode== `i'
}

//Some missing info for pre2000 activities. Likely to not be important e.g. mining in DC. Fewer than 300 people the entire period
keep if keeplev==1
replace emp="0" if emp=="(T)"
replace NAICSemp="0" if NAICSemp=="(T)"


//Slightly more obs with (D). I replace them with the lagged value.
replace emp="99999999999" if emp=="(D)"

destring NAICSemp emp, replace
replace emp=L.emp if emp==99999999999

//theta represents the share of industry employment in tot state employment. 
gen theta=emp/totemp
drop if LineCode==20
drop if year<2001
saveold Bartikbase.dta, replace

import excel "TableSIC.xlsx", sheet("Table") cellrange(A6:AK4902) firstrow clear
destring LineCode, replace

egen id =group(GeoName LineCode)
reshape long Y, i(id) j(year)
rename Y emp 
gen totemp2=emp
replace totemp2 ="." if LineCode!=20
destring totemp2, replace
egen totemp=max(totemp2), by(GeoName year)
drop totemp2

gen totfarm2=emp
replace totfarm2 ="." if LineCode!=70
destring totfarm2, replace

egen totfarm=max(totfarm2), by(GeoName year)
drop totfarm2


gen keeplev=0
local codes 100 200 300 410 450 500 610 620 700 800 900
foreach i of numlist `codes'  {
    replace keeplev=1 if LineCode== `i'
}
keep if keeplev==1

replace totemp=totemp-totfarm
xtset id year
replace emp="0" if emp=="(T)"
replace emp="99999999999" if emp=="(D)"
replace emp="." if emp=="(NA)"

destring emp, replace
replace emp=L.emp if emp==99999999999
gen theta=emp/totemp
drop if LineCode==20
drop if year>2000
append using Bartikbase.dta
drop id
egen id =group(GeoName LineCode)
saveold Bartikbase.dta, replace

import excel "TableUSpre.xlsx", sheet("Table") cellrange(A6:AL100) firstrow clear
destring LineCode, replace
egen id =group(GeoName LineCode)
reshape long Y, i(id) j(year)
rename Y emp 
gen totemp2=emp
replace totemp2 ="." if LineCode!=20
destring totemp2, replace
egen totemp=max(totemp2), by(GeoName year)
drop totemp2
xtset id year

gen totfarm2=emp
replace totfarm2 ="." if LineCode!=70
destring totfarm2, replace

egen totfarm=max(totfarm2), by(GeoName year)
drop totfarm2

replace totemp=totemp-totfarm

gen keeplev=0
local codes 100 200 300 410 450 500 610 620 700 800 900
foreach i of numlist `codes'  {
    replace keeplev=1 if LineCode== `i'
}
keep if keeplev==1

replace emp="0" if emp=="(T)"
replace emp="99999999999" if emp=="(D)"
replace emp="." if emp=="(NA)"

destring emp, replace
replace emp=L.emp if emp==99999999999
drop if LineCode==20
drop if year>2000
saveold USempSIC.dta, replace

import excel TableUS.xlsx, sheet("Table") cellrange(A6:AC115) firstrow allstring clear
destring LineCode, replace
egen id =group(GeoName LineCode)
rename Y2000 NAICSchange
destring NAICSchange, replace
reshape long Y, i(id) j(year)
rename Y emp 
gen totemp2=emp
replace totemp2 ="." if LineCode!=20
destring totemp2, replace
egen totemp=max(totemp2), by(GeoName year)
drop totemp2

gen totfarm2=emp
replace totfarm2 ="." if LineCode!=70
destring totfarm2, replace

egen totfarm=max(totfarm2), by(GeoName year)
drop totfarm2

replace totemp=totemp-totfarm

xtset id year
gen keeplev=0
local codes 100 200 300 400 510 530 600 700 800 900 1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000
foreach i of numlist `codes'  {
    replace keeplev=1 if LineCode== `i'
}

keep if keeplev==1
replace emp="0" if emp=="(T)"
replace emp="99999999999" if emp=="(D)"
replace emp="." if emp=="(NA)"

destring emp, replace
replace emp=L.emp if emp==99999999999
drop if LineCode==20
drop if year<2001
append using USempSIC.dta
rename emp usemp
saveold USempNAICS.dta, replace

use Bartikbase.dta, clear
merge m:1 LineCode year using USempNAICS
drop AC keeplev
xtset id year
gen purgeemp=usemp-emp
gen purgenaics=NAICSchange-NAICSemp
//gen change in employment at industry level, purged of local emp. 
gen deltaemp=ln(purgeemp)-ln(l.purgeemp)
replace deltaemp=ln(purgeemp)-ln(purgenaics) if year==2001

gen bartik= l.theta*deltaemp 
egen imix=sum(bartik), by(year GeoName)
duplicates drop year GeoName, force

egen meanimix=mean(imix), by(year)
gen rimix=imix-meanimix

replace rimix=. if rimix==0
keep year GeoName rimix 
rename GeoName state
save Bartik.dta, replace

