# Sampling and Analysing Phase Transition Data for the Approximation of Nucleation Collective Variables Using Graph Neural Networks

The scripts collected here were used for the development of the results reported in the author's thesis, submitted as part of the curriculum for the degree of MEng Engineering (Chemical) at University College London (UCL). The data supporting the findings of this work is available from the corresponding author upon reasonable request.

In these scripts, we consider a colloidal system consisting of 421 atoms dispersed in a (continuum) medium where crystallisation from solution occurs in a two-step nucleation mechanism.

## Sampling Phase Transition Data

All the relevant scripts for the sampling of phase transition data along with the results obtained can be found in the `sampling` folder. As seen, to carry out all the procedures in an automated and efficient manner, appropriate Make, Bash and Python scripts were developed. In this case, access to `matteo-2.chemeng.ucl.ac.uk` through Socrates (used as a "jump box" for Research Computing services at UCL) is required. Despite this, examples and comments on their usage and functions are provided throughout the scripts. Note that SRC=dump.3Dcolloid.13.xyz refers to the initial crystallising trajectory (reference), which is available upon reasonable request.

## Analysing Phase Transition Data

All the relevant scripts to analyse the phase transition data sampled along with the results obtained can be found in the `analyses` folder. For their usage, the corresponding Python packages are required, as well as the correct specification of the loading path throughout the script (see `loading_path` instances in the script and modify appropriately). This indicates the path to the folder containing the data to be loaded in each analysis considered. For easiness of reproduction, in the examples provided, the data used in all the different analyses is grouped under a folder called `all_data` located in the same directory as the `sampling` and `analyses` folders. The `all_data` folder is available upon reasonable request. Comments are provided throughout the scripts for their usage.

## Approximating nucleation collective variables using graph neural networks

There is ongoing research by Dietrich et al. concerning this topic. This is to be publicly reported as it has been recently developed. Access to these scripts is to be released along with the publication of the findings from such research.
