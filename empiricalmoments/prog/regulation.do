*cd "/Users/pierredeschamps/Dropbox/EcoGeog/data/BLSData/"
cd "C:\Users\pide1362\Dropbox\EcoGeog\replication\data"


use "WHARTON LAND REGULATION DATA_1_24_2008 2.dta", clear

egen mreg=mean(WRLURI), by(statename)
keep mreg statename stacode
duplicates drop statename, force
gen binreg = (mreg>-0.3)
rename stacode statenum
save "regdatabase.dta", replace
