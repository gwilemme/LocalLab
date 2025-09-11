cd "C:\Users\pide1362\Dropbox\EcoGeog\replication\data"

import excel "C:\Users\pide1362\Dropbox\EcoGeog\data\BLSData\Migration\bea_19902000.xlsx", sheet("Population") firstrow clear
rename A state
reshape long Y, i(state) j(year)
rename Y censuspop
save censuspop.dta, replace

import excel "C:\Users\pide1362\Dropbox\EcoGeog\data\BLSData\Migration\bea_19902000.xlsx", sheet("Births") firstrow clear
rename A state
reshape long Y, i(state) j(year)
rename Y births
save births.dta, replace

import excel "C:\Users\pide1362\Dropbox\EcoGeog\data\BLSData\Migration\bea_19902000.xlsx", sheet("Deaths") firstrow clear
rename A state
reshape long Y, i(state) j(year)
rename Y deaths
save deaths.dta, replace

import excel "C:\Users\pide1362\Dropbox\EcoGeog\data\BLSData\Migration\bea_19902000.xlsx", sheet("Net migration") firstrow clear
rename A state
reshape long Y, i(state) j(year)
rename Y intmig
save intmig.dta, replace

use censuspop.dta, clear
merge 1:1 year state using births.dta
drop _merge
merge 1:1 year state using deaths.dta
drop _merge
merge 1:1 year state using intmig.dta
drop _merge
merge 1:1 year state using inflow.dta
drop if _merge==2
drop _merge
merge 1:1 year state using outflow.dta

drop _merge
save censusdat.dta, replace