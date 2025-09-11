cd "C:\Users\pide1362\Dropbox\EcoGeog\replication\data"

import excel "UELFrates.xlsx", sheet("Sheet1") cellrange(B5:J28667) firstrow clear
rename Year year
rename State state
replace state= "District of Columbia" if state=="DC"

replace unemploymentrate=subinstr(unemploymentrate, "(P)", "", .)
replace laborforce=subinstr(laborforce, "(P)", "", .)
replace laborforcep=subinstr(laborforcep, "(P)", "", .)
replace employment=subinstr(employment, "(P)", "", .)
replace unemployment=subinstr(unemployment, "(P)", "", .)
replace employmentp=subinstr(employmentp, "(P)", "", .)

destring unemploymentrate laborforce employmentp unemployment employment laborforcep, replace
gen population = laborforce*100/laborforcep


replace Period="1" if Period=="Jan"
replace Period="2" if Period=="Feb"
replace Period="3" if Period=="Mar"
replace Period="4" if Period=="Apr"
replace Period="5" if Period=="May"
replace Period="6" if Period=="Jun"
replace Period="7" if Period=="Jul"
replace Period="8" if Period=="Aug"
replace Period="9" if Period=="Sep"
replace Period="10" if Period=="Oct"
replace Period="11" if Period=="Nov"
replace Period="12" if Period=="Dec"
destring Period, replace
sort state year Period

save database.dta, replace