cd "C:\Users\pide1362\Dropbox\EcoGeog\replication\data"

use database.dta, clear

//gen average of BLS variables by year


encode state, gen(statenum)

egen Employmentpop=mean(employmentpop), by(year statenum)
egen Participation=mean(laborforcep), by(year statenum)
egen Laborforce=mean(laborforce), by(year statenum)
egen Population=mean(population), by(year statenum)
egen Employment=mean(employment), by(year statenum)
egen Unemployment=mean(unemployment), by(year statenum)
egen Unemploymentrate=mean(unemploymentrate), by(year statenum)

drop employmentp laborforcep laborforce population employment unemployment unemploymentrate
rename Employment employment
rename Participation laborforcep
rename Employmentpop employmentpop
rename Laborforce laborforce
rename Population population
rename Unemployment unemployment
rename Unemploymentrate unemploymentrate

duplicates drop statenum year, force


merge 1:1 year state using "Bartik.dta"
drop if _merge==2
drop _merge

merge m:1 statenum using "regdatabase.dta"
drop _merge
xtset statenum year  

saveold databasef.dta, replace