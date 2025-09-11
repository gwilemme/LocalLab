# LocalLab
Replication package of the project
'Local Labor Market Dynamics and Agglomeration Effects'
by [Pierre Deschamps](https://sites.google.com/site/pierredeschampsecon/) (SOFI) and [Guillaume Wilemme](https://gwilemme.github.io/) (Univ. of Leicester).


### Structure of the repository
This repository contains the code and data used in the project. The code to obtain the empirical moments is written for Stata, while the code to simulate the model is written with Jupyter notebooks and runs with Julia 1.10. GitHub can directly display the Jupyter notebooks. When GitHub does not manage to display a notebook, we suggest using the url on GitHub with the viewer https://nbviewer.jupyter.org/.

The folder `empiricalmoments` contains the code and data to obtain the impulse response functions (IRFs) as explained in Section 2.1 of the article.
The folder `model` contains the codes to calibrate the different versions of the model and to run counterfactual simulations.

### Empirical Moments
#### Data
Employment, unemployment, and labor force participation data are taken from the LAUS statistics, available here: [https://www.bls.gov/lau/](https://www.bls.gov/lau/).

The employment by industry and state series are taken from the BEA, and available here: [https://www.bea.gov/data](https://www.bea.gov/data).

We take the 2008 WRLURI from Joseph Gyourko’s website here: [https://real-faculty.wharton.upenn.edu/gyourko/land-use-survey/](https://real-faculty.wharton.upenn.edu/gyourko/land-use-survey/).


#### Executing the code
Run the master do-file to compile the STATA database and VAR.
The VAR is estimated through STATA. The IRFs can then be computed manually in Excel.

We include 4 Excel files in the folder `results` to define the relevant IRFs: `HandIRF_RFIV_persistent_no_covid.xslx` defines the main estimates from the paper. `HandIRF_RFIV_persistent_no_covid_high_regulation.xslx` and `HandIRF_RFIV_persistent_no_covid_low_regulation.xslx` define the IRFs with high and low housing elasticities (Figure 9).
`HandIRF_RFIV_migration.xslx` defines the IRFs with migration flows (Figure 8).

### Model
In the folder `model`, the routines are defined in the folder `src`.
All the simulation codes call `startup.ipynb`, which loads the package Agglo in ` src`.

The files `calibrate_XX.ipynb` calibrate the model of the following versions: the baseline (`base`), the baseline without agglomeration effects (`noagglo`), the baseline with free entry (`nofirm`), the version with no agglomeration effects and free entry (`DMPwithMig`), the three-state DMP model (`DMP`), the version with rigid rents (`rigidrent`) and the version with rigid wages (`rigidwage`).

The file `empiricalmoments.ipynb` plots the impulse response functions of Figure 9 in the text.

The files `simulationXX.ipynb` run the simulations and plot the graphs. Results from Section 3.1 derive from `simulation1_baseline.ipynb`. Results from Section C.1 derive from `simulation2_comparefit.ipynb`. Results from Section 3.2 derive from `simulation3_agglomeration.ipynb`. Results from Section 3.3 derive from `simulation4_migration.ipynb`. Results from Section 3.4 derive from `simulation5_policy.ipynb`. Results from Section 3.5 derive from `simulation6_rigirent.ipynb` and `simulation6_rigidwage.ipynb`.
Empirical results from Footnote 3 derive from `simulationX_check_m.ipynb`.

The outputs of the calibration and simulation files are exported in html files in the folder `html`. These files show all the graphs reported in the article.
