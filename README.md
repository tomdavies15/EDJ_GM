# EDJ_GM
Geometric morphometric analysis of enamel-dentine junction morphology

Code provided requires R (v4.3.1 - https://www.r-project.org/), and the following packages: Morpho (v2.11), princurve (v2.1.6) and tripack (v1.3-9.1). No additional software installation necessary. The code has been tested using these versions.

Premolar_GM.R contains code to run sliding (2 sliding steps, with projection back to curve between each step) and Procrustes registration for premolars, as well as to run and output a Principal Component Analysis (PCA) of EDJ shape. 
	
Molar_GM.R contains code to run sliding (2 sliding steps, with projection back to curve between each step) and Procrustes registration for molars, as well as to run and output a Principal Component Analysis (PCA) of EDJ shape. 

Test data is available to download from the Human Fossil Record Archive (https://human-fossil-record.org/index.php?/category/14230)
