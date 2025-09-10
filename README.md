# LocalLab
Replication package of the project
'Local Labor Market Dynamics and Agglomeration Effects'
by [Pierre Deschamps](https://sites.google.com/site/pierredeschampsecon/) (SOFI) and [Guillaume Wilemme](https://gwilemme.github.io/) (Univ. of Leicester).



### Structure of the repository
This repository contains the Julia code used in the project and the data gathered from the four cases. The code is written with Jupyter notebooks and runs with Julia 1.9. GitHub can directly display these notebooks. When GitHub does not manage to display a notebook, we suggest using the url on GitHub with the viewer https://nbviewer.jupyter.org/.

The folder `data` contains the four datasets.
The folder `code/interpretationbias` contains a code that computes the parameters for Figure 1.
The folder `code/simulation` contains the codes that calibrate and simulate the models in the four cases.

### Data
The four datasets are extracted from the following graphs: Figure 3 in Lemieux and Milligan (2008) for Canada; Figure 4, left panel, in Bargain and Doorley (2011) for France; Figure 2 in Lalive (2008) for Austria; Figure 3 in Schmieder et al. (2012) for Germany.

### Calibration and simulation
In the folder `simulation`, the routines are defined in the folder `src`.
For each country C=CAN, FRA, AUS, GER, there are three files:
- `startup_C.ipynb` loads the package AgeDisc in `src`. It sets the country-specific parameters and loads the empirical moments.
- `calib_C.ipynb` determines the calibrated parameters in the benchmark model and alternative versions. 
The code for Canada and France can run on a personal computer.
The code for Austria and Germany takes a longer time (approximatively 3 days and 1 day on a high-performance computer).
- `simu_C.ipynb` simulate the model with calibrated parameters. 
Everything can run on a personal computer, except the 3D graphs for Austria and Germany. These graphs take several hours on a high-performance computer.

The versions with the extension `GER_UI` calibrate and simulate the model with the extended calibration (see online appendix).

The outputs of `simu_C.ipynb` are exported in html files in the folder `html`. These files show all the graphs and tables (except the 3D graphs for Austria and Germany). 


