# LocalLab
Replication package of the project
'Local Labor Market Dynamics and Agglomeration Effects'
by [Pierre Deschamps](https://sites.google.com/site/pierredeschampsecon/) (SOFI) and [Guillaume Wilemme](https://gwilemme.github.io/) (Univ. of Leicester).



### Structure of the repository
This repository contains the Julia code used in the project and the data gathered from the four cases. The code is written with Jupyter notebooks and runs with Julia 1.10. GitHub can directly display these notebooks. When GitHub does not manage to display a notebook, we suggest using the url on GitHub with the viewer https://nbviewer.jupyter.org/.

The folder `data` contains XXX.
The folder `code` contains the codes to calibrate the different versions of the model and to run counterfactual simulations.

### Data
The four datasets are extracted from the following graphs: Figure 3 in Lemieux and Milligan (2008) for Canada; Figure 4, left panel, in Bargain and Doorley (2011) for France; Figure 2 in Lalive (2008) for Austria; Figure 3 in Schmieder et al. (2012) for Germany.

### Code
In the folder `code`, the routines are defined in the folder `src`.
All codes calls `startup.ipynb`, which loads the packahe Agglo in ` src`.

The files `calibrate_XX.ipynb` calibrate the model of the following versions: the baseline (`base`), the baseline without agglomeration effects (`noagglo`), the baseline with free entry (`nofirm`), the version with no agglomeration effects and free entry (`DMPwithMig`), the three-state DMP model (`DMP`), the version with rigid rents (`rigidrent`) and the version with rigid wages (`rigidwage`).

The file `empiricalmoments.ipynb` plots the impulse response functions of Figure 9 in the text.

the files `simulationXX.ipynb` runs the simulations and plots the graphs. Results from Section 3.1 derive from `simulation1_baseline.ipynb`. Results from Section C.1 derive from `simulation2_comparefit.ipynb`. Results from Section 3.2 derive from `simulation3_agglomeration.ipynb`. Results from Section 3.3 derive from `simulation4_migration.ipynb`. Results from Section 3.4 derive from `simulation5_policy.ipynb`. Results from Section 3.5 derive from `simulation6_rigirent.ipynb` and `simulation6_rigidwage.ipynb`.
Empirical results from Footnote 3 derive from `simulationX_check_m.ipynb`.

The outputs of the simulation files are exported in html files in the folder `html`. These files show all the graphs reported in the article. 


