cd "C:\Users\pide1362\Dropbox\EcoGeog\replication\data"


use databasef.dta,clear

xtset statenum year  
egen totuslaborforce=sum(laborforce), by(year)
egen totusunemployment=sum(unemployment), by(year)
egen meanemployment=mean(employmentp), by(year)
egen meanparticipation=mean(laborforcep), by(year)
egen meanunemployment=mean(unemploymentrate), by(year)
egen totusemployment=sum(employment), by(year)
egen totpopulation=sum(population), by(year)

rename statenum statenumgr
merge 1:1 statenumgr year using "irsmig.dta"
drop stateirs statenum
rename statenumgr statenum
drop _merge
xtset statenum year  

gen emplab=employment/laborforce
gen unemplab=unemployment/laborforce

egen meanemplab=mean(emplab), by(year)

** 1) create variables of interest
gen emp = log(employment)-log(totusemployment)
gen unemp = log(unemployment)-log(totusunemployment)
gen Delta_emp = emp-l.emp 
gen neg_Delta_emp=-Delta_emp

gen erate = log(employmentp)-log(meanemployment)
gen urate = log(unemploymentr)-log(meanunemployment)
gen prate = log(laborforcep)-log(totuslaborforce/totpopulation)


gen irsnetmig=irsinflowrate-irsoutflowrate
gen t=year
//Panel var
gen emprate = log(emplab)-log(totusemployment/totuslaborforce)
gen unemprate = log(unemplab)-log(totusunemployment/totuslaborforce)
gen id=statenum

egen usirsmigrate=mean(irsnetmig), by(year)
egen usirsinmigrate=mean(irsinflowrate), by(year)
egen usirsoutmigrate=mean(irsoutflowrate), by(year)

egen ustotirsoutmigrate=total(outflow), by(year)
egen ustotirsinmigrate=total(inflow), by(year)


gen irsdemeanmig=irsnetmig-usirsmigrate
gen irsdemeaninmig=irsinflowrate-usirsinmigrate
gen irsdemeanoutmig=irsoutflowrate-usirsoutmigrate


xi:reg irsnetmig c.year##i.statenum
predict irsmigvar, resid


xi:reg irsinflowrate c.year##i.statenum
predict irsinmigvar, resid


xi:reg irsoutflowrate c.year##i.statenum
predict irsoutmigvar, resid


//emp has unit root, but not Delta_emp

xtunitroot ips emprate, lags(4)
xtunitroot ips unemprate, lags(4)
xtunitroot ips prate, lags(4)
xtunitroot ips erate, lags(4)
xtunitroot ips urate, lags(4)
xtunitroot ips emp, lags(4)
xtunitroot ips Delta_emp, lags(4)
xtunitroot ips irsdemeanmig, lags(4)
xtunitroot ips irsdemeaninmig, lags(4)
xtunitroot ips irsdemeanoutmig, lags(4)

//Drop covid years
keep if year<2020

//RFIV
xtreg Delta_emp rimix l.rimix l.Delta_emp l2.Delta_emp l.emprate l2.emprate l.prate l2.prate, fe robust
matrix list e(b)
xtreg emprate rimix l.rimix l.Delta_emp l2.Delta_emp l.emprate l2.emprate l.prate l2.prate, fe robust
matrix list e(b)
xtreg prate rimix l.rimix l.Delta_emp l2.Delta_emp l.emprate l2.emprate l.prate l2.prate, fe robust
matrix list e(b)
xtreg rimix l.rimix, robust


//RFIV
xtreg Delta_emp rimix l.rimix l.Delta_emp l2.Delta_emp l.emprate l2.emprate l.prate l2.prate, fe robust
matrix list e(b)
xtreg emprate rimix l.rimix l.Delta_emp l2.Delta_emp l.emprate l2.emprate l.prate l2.prate, fe robust
matrix list e(b)
xtreg prate rimix l.rimix l.Delta_emp l2.Delta_emp l.emprate l2.emprate l.prate l2.prate, fe robust
matrix list e(b)
xtreg rimix l.rimix, robust

//addingmigration - 


xtreg irsdemeaninmig rimix l.irsdemeaninmig, fe robust
matrix list e(b)

xtreg irsdemeanoutmig rimix  l.irsdemeanoutmig, fe robust
matrix list e(b)

xtreg irsdemeanmig rimix    l.irsdemeanmig,  fe robust
matrix list e(b)
