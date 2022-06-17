# ResponsibleSupervision!!!

This is the repository for the Responsible Supervision pilot project. We analysed a set of publications from PhD candidates and their respective primary supervisors (in pairs). We did so by screening the publications for particular Open Science/Responsible Research Practices. Here we describe how and which automated screening tools we used.

The data folder contains our pilot dataset that can be used to replicate our findings. Data have been gathered manually according to a standardised protocol that will be shared shortly. 

The scripts folder contains the code we used to extract Open Access status (using Unpaywall, see: https://github.com/NicoRiedel/unpaywallR) and whether the publication mentioned Open Data (using ODDpub, see: https://github.com/quest-bih/oddpub). This folder also contains the code we used to clean the dataset and to calculate Pearson's correlations and other descriptives.

Please note that for using the 01 script, you need to set up a configuration file to specify your email address for the Unpaywall query. Create a new file in a text editor with the following information:  

`[login]`  

`email=youremailaddress`

Save this file as `config.ini` in the `Pilot-responsible-supervision` directory.
