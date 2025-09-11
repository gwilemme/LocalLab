cd "C:\Users\pide1362\Dropbox\EcoGeog\replication\data"


use databasef.dta,clear

xtset statenum year 

//Define US level variables 
egen totuslaborforce=sum(laborforce), by(year)
egen totusunemployment=sum(unemployment), by(year)
egen meanemployment=mean(employmentp), by(year)
egen meanparticipation=mean(laborforcep), by(year)
egen meanunemployment=mean(unemploymentrate), by(year)
egen totusemployment=sum(employment), by(year)
egen totpopulation=sum(population), by(year)



gen emplab=employment/laborforce
gen unemplab=unemployment/laborforce

gen emp = log(employment)-log(totusemployment)
gen Delta_emp = emp-l.emp 

gen prate = log(laborforcep)-log(totuslaborforce/totpopulation)


gen t=year
//Panel var
gen emprate = log(emplab)-log(totusemployment/totuslaborforce)
gen unemprate = log(unemplab)-log(totusunemployment/totuslaborforce)
gen id=statenum

//emp has unit root, but not Delta_emp

xtunitroot ips emprate, lags(4)
xtunitroot ips prate, lags(4)
xtunitroot ips emp, lags(4)
xtunitroot ips Delta_emp, lags(4)

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


//RFIV - low housing elasticity



xtreg Delta_emp rimix l.rimix l.Delta_emp l2.Delta_emp l.emprate l2.emprate l.prate l2.prate if binreg==0, fe robust
matrix list e(b)
xtreg emprate rimix l.rimix l.Delta_emp l2.Delta_emp l.emprate l2.emprate l.prate l2.prate if binreg==0, fe robust
matrix list e(b)
xtreg prate rimix l.rimix l.Delta_emp l2.Delta_emp l.emprate l2.emprate l.prate l2.prate if binreg==0, fe robust
matrix list e(b)
xtreg rimix l.rimix if binreg==0, robust
matrix list e(b)

//RFIV - high housing elasticity

xtreg Delta_emp rimix l.rimix l.Delta_emp l2.Delta_emp l.emprate l2.emprate l.prate l2.prate if binreg==1, fe robust
matrix list e(b)
xtreg emprate rimix l.rimix l.Delta_emp l2.Delta_emp l.emprate l2.emprate l.prate l2.prate if binreg==1, fe robust
matrix list e(b)
xtreg prate rimix l.rimix l.Delta_emp l2.Delta_emp l.emprate l2.emprate l.prate l2.prate if binreg==1, fe robust
matrix list e(b)
xtreg rimix l.rimix if binreg==1, robust



