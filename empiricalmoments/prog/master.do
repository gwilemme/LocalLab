//Master do file
cd "C:\Users\pide1362\Dropbox\EcoGeog\replication\prog\"


//Import BLs data on unemployment, employment and laborforce participation.
//Population is inferred from multiplying LF by participation 
run "C:\Users\pide1362\Dropbox\EcoGeog\replication\prog\bls_data.do"

//Create the Bartik instrument 
run "C:\Users\pide1362\Dropbox\EcoGeog\replication\prog\bartik.do" 

//CReating the WRLURI Index
run "C:\Users\pide1362\Dropbox\EcoGeog\replication\prog\regulation.do"

//Merge the databases together
run "C:\Users\pide1362\Dropbox\EcoGeog\replication\prog\merge.do"

//Estimate the VAR.
do "C:\Users\pide1362\Dropbox\EcoGeog\replication\prog\var.do"