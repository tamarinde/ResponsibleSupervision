# ResponsibleSupervision

This is the repository for the Responsible Supervision project. We analysed a set of publications from PhD candidates and their respective primary supervisors (in pairs). We did so by screening the publications for particular Open Science/Responsible Research Practices. Here we describe how and which automated screening tools we used.

The data folder contains our dataset that can be used to replicate our findings. The underlying data have been gathered manually according to a standardised protocol that is available via OSF: <https://osf.io/4fzx8>. We also include datasets with data added based on the scripts.

The scripts folder contains the code we used to extract Open Access status (using Unpaywall, see: <https://github.com/NicoRiedel/unpaywallR>) and whether the publication included an Open Data statement (using ODDpub, see: <https://github.com/quest-bih/oddpub>). We further screened extracted Open Data statements using this protocol: https://www.protocols.io/view/semi-automated-extraction-of-information-on-open-d-q26g74p39gwz/v1. 

Please note that for using the 01 script, you need to set up a configuration file to specify your email address for the Unpaywall query. Create a new file in a text editor with the following information:

`[login]`

`email=youremailaddress`

Save this file as `config.ini` in the `Pilot-responsible-supervision` directory.

Also note that the final analyses were done using SPSS. We will convert this syntax to R in due time, but until then we copy-pasted it into a readme file. 
