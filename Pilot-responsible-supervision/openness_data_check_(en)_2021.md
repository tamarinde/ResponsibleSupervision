---
title: "Openness (en) 2021"
author:
- name: ""
  affiliation: ""
date: "13-08-2021 (last changes)"
---

# Extraction form details

Openness (en) 2021 version 1.0



[ungeFAIR]()

# Extraction form elements

## Extraction timer

Numbat automatically times all extractions starting from the first time a user opens the extraction, until the first time they click 'Complete'. This element displays a timer to the user when the extraction is on-going, and allows the user to re-start the timer.

## What are the requirements for Open Data (click (?) for more information)

Extractor prompt: 
```
(i)	The datasets are explicitly referred to in the publication; a reference e.g. to Supplementary Materials without further explanation is not sufficient.  

(ii)	The data are shared in a machine-readable format; for tables e. g. Excel format, for text e. g. Word format; PDFs are conditionally machine-readable - they are suitable for texts (with sufficient tagging or structuring), but not for tables because they are not being recognized as such.  

(iii)	The data allow the analytical replication of at least one part of the study results and/or new analyses; to mention the statistical numerical values (average, standard deviation, p-value, etc.) is not sufficient.   
For further criteria see the individual steps of the Numbat checking workflow. 

```

## Please, answer the following questions to assess the openness of data:

Extractor prompt: 
```
(i) Some repositories are more likely to contain Open Data than others, and some repositories only contain restricted-access datasets. If datasets have been deposited in several repositories, and if there is prior knowledge on which of these most probably contains Open Data, evaluation is to be started with this repository. Otherwise, go through the list of repositories in order. (Please note that differing prior knowledge can thus lead to different choices of datasets examined for different raters.) 

(ii) For each repository in which data has been shared, the first-mentioned dataset (and only this one!) has to be evaluated. This has to be repeated for each repository, until an open dataset has been found or all eligible repositories have been evaluated.

(iii) If the first dataset extracted is not open, and datasets in other databases are indicated in the publication, the entry for the first dataset has to be deleted, and extraction for these other dataset(s) has to be started again in the same form. Please, state in the comment box which dataset was found not to be open.    
```

### Is there a clear reference to data in the publication?

Variable type: Categorical (single selection only)

Database column name: `reference_to_data`

Extractors were prompted to select one of the following mutually exclusive options.

| Displayed option name | Database value |
|:----------------------|---------------:|
| Yes | yes |
| No | no |
| Inapplicable (e.g. if the article type is 'review', 'opinion' or 'aditional') | n_a |
| Unsure | unsure |

Extractor prompt: 
```
(i) Check the article type first, because article types such as 'review', 'opinion' or 'additional' are excluded from the examination as they do not represent primary research and no new datasets were generated as their basis.  

(ii) There must be a clear statement in the publication that raw data have been shared. A general statement that the supplement contains "additional information" is not sufficient.  
```

### Comment 1

Variable type: Open text field

Database column name: `comment_1_reference_to_data`

### Please state the identifier (preferably a link or DOI) of the data that was used in this extraction.

Variable type: Open text field

Database column name: `identifier`

Extractor prompt: 
```
(i) If the dataset does not have a DOI (digital object identifier), enter the link to the dataset. Thus, for datasets which are referenced by database/repository name and accession code, enter the full link which will typically contain both the database name and the accession code. Only if a link cannot be given, enter database and accession code separately.  

(ii) An independent digital object is present if the data record can be retrieved online independently of the article. Tables embedded in articles do not count as open data unless they can be accessed as independent digital objects.  

(iii) A persistent identifier (PID) such as a DOI, a link (URL), or an accession number (always with the database name in which the data is stored) is required for findability.  
i.	Findability via accession numbers and database names using search engines such as Google to find the database link is still compatible with Open Data.    
ii.	Reference to a repository or a database without an accession number or PID is not compatible with Open Data.  
iii.	Accordingly, a link to the own website of the author/researcher or institution is not sufficient, unless it is immediately and without further searching evident where on the website the dataset is located.    
```

When the extraction form is loaded, this element was hidden. It would be shown if any of the following conditions were met:

* "Is there a clear reference to data in the publication?" is: "Unsure"
* "Is there a clear reference to data in the publication?" is: "Yes"

In the case that this element was hidden again by a conditional display event after a response was entered, the response would be cleared.

### Has the shared data been generated by the authors of the corresponding article („Own Data“) or is it re-used data generated by others („Data Reuse”)?

Variable type: Categorical (single selection only)

Database column name: `own_or_reuse_data`

Extractors were prompted to select one of the following mutually exclusive options.

| Displayed option name | Database value |
|:----------------------|---------------:|
| Own Data | own_open_data |
| Data Reuse | open_data_reuse |
| Unsure | unsure |

Extractor prompt: 
```
(i) We classify as "data reuse" all cases where the detected statement indicates that data were collected by others than the authors and were made available through a repository; this and other parameters of openness are then not checked, however. If at least one author of the publication is also a contributor to the dataset, it is considered to be Own Data. 

(ii) In case that no contributors are indicated in the dataset metadata, an explicit reference about Own Data sharing in the publication is sufficient to assume that the data are newly generated data. There is no restriction applied as to whether the own dataset has already been the basis of other publications, and how much time passed between the publication of dataset and article, respectively. [For OD-LOM assessment note as a comment whether the dataset might be the basis of earlier publications (to avoid multiple rewards for the same dataset) or is older than three years]

(iii) Indicating both Own Data and Data Reuse for the same article is NOT possible. In this case, give preference to the classification as Own Data. 
```

When the extraction form is loaded, this element was hidden. It would be shown if any of the following conditions were met:

* "Is there a clear reference to data in the publication?" is: "Yes"
* "Is there a clear reference to data in the publication?" is: "Unsure"

In the case that this element was hidden again by a conditional display event after a response was entered, the response would be cleared.

### Comment 2

Variable type: Open text field

Database column name: `comment_2_own_data`

When the extraction form is loaded, this element was hidden. It would be shown if any of the following conditions were met:

* "Is there a clear reference to data in the publication?" is: "Yes"
* "Is there a clear reference to data in the publication?" is: "Unsure"

In the case that this element was hidden again by a conditional display event after a response was entered, the response would be cleared.

### Has the data been shared in a repository?

Variable type: Categorical (single selection only)

Database column name: `data_in_supplement`

Extractors were prompted to select one of the following mutually exclusive options.

| Displayed option name | Database value |
|:----------------------|---------------:|
| Yes | yes |
| No | no |
| Unsure | unsure |

Extractor prompt: 
```
(i) Data in the supplement meet the FAIR criteria to a particularly low degree and are difficult to find and reuse. Thus, they are not considered as “Open Data” here.  

(ii) It may be a case that supplementary data have been deposited in a repository- Such data are considered compatible with Open Data requirements, and the assessment of the Open Data status continues. This is due to such datasets being better as well as independently findable. A repository is here defined as any platform which allows to access data online, assigns identifiers or minimally a weblink to a dataset landing page, and offers metadata annotation to increase data findability.  

(iii) If, in contrast, data have been deposited with the article on the website of the journal or publisher, this is not considered compatible with Open Data requirements, and no further assessment takes place.” 
```

When the extraction form is loaded, this element was hidden. It would be shown if any of the following conditions were met:

* "Has the shared data been generated by the authors of the corresponding article („Own Data“) or is it re-used data generated by others („Data Reuse”)?" is: "Own Data"
* "Has the shared data been generated by the authors of the corresponding article („Own Data“) or is it re-used data generated by others („Data Reuse”)?" is: "Unsure"

In the case that this element was hidden again by a conditional display event after a response was entered, the response would be cleared.

### Comment 3

Variable type: Open text field

Database column name: `comment_3_data_in_supplement`

When the extraction form is loaded, this element was hidden. It would be shown if any of the following conditions were met:

* "Has the shared data been generated by the authors of the corresponding article („Own Data“) or is it re-used data generated by others („Data Reuse”)?" is: "Own Data"
* "Has the shared data been generated by the authors of the corresponding article („Own Data“) or is it re-used data generated by others („Data Reuse”)?" is: "Unsure"

In the case that this element was hidden again by a conditional display event after a response was entered, the response would be cleared.

### Can the data be found? 

Variable type: Categorical (single selection only)

Database column name: `findability`

Extractors were prompted to select one of the following mutually exclusive options.

| Displayed option name | Database value |
|:----------------------|---------------:|
| Yes | yes |
| No | no |
| Unsure | unsure |

Extractor prompt: 
```
Mentioning the repository/database without indicating the accession number or how else the data are to be found in the database is not sufficient to consider the dataset findable.
```

When the extraction form is loaded, this element was hidden. It would be shown if any of the following conditions were met:

* "Has the data been shared in a repository?" is: "Yes"
* "Has the data been shared in a repository?" is: "Unsure"

In the case that this element was hidden again by a conditional display event after a response was entered, the response would be cleared.

### Comment 4

Variable type: Open text field

Database column name: `comment_4_findability`

When the extraction form is loaded, this element was hidden. It would be shown if any of the following conditions were met:

* "Has the data been shared in a repository?" is: "Yes"
* "Has the data been shared in a repository?" is: "Unsure"

In the case that this element was hidden again by a conditional display event after a response was entered, the response would be cleared.

### Can the data be accessed? 

Variable type: Categorical (single selection only)

Database column name: `data_access`

Extractors were prompted to select one of the following mutually exclusive options.

| Displayed option name | Database value |
|:----------------------|---------------:|
| Yes | yes |
| No, not uploaded or stored | no |
| No, access restricted | restricted |
| Unsure | unsure |

Extractor prompt: 
```
(i) Access to the data is possible, i.e. the data can actually be downloaded.. This can typically be confirmed by opening the download window. If this is possible, it is to be assumed that data could be downloaded, and an actual download is not necessary. However, in case of doubt, download data to confirm that the downloadable files are actually data and not merely the corresponding metadata. 

(ii) If the data are available under access restrictions (including any type of registration or confirmation of terms of use), they are not to be considered as Open Data. [Restricted-access data are, however, considered in the OD-LOM, and are to be checked independently to confirm whether LOM is justified.] 

(iii) If the data are unavailable due to server downtime or a server error assumed to be temporary, data accessibility is to be checked again on a later day. Unavailability on two different dates is not compatible with Open Data status. 
```

When the extraction form is loaded, this element was hidden. It would be shown if any of the following conditions were met:

* "Can the data be found? " is: "Yes"
* "Can the data be found? " is: "Unsure"

In the case that this element was hidden again by a conditional display event after a response was entered, the response would be cleared.

### Comment 5

Variable type: Open text field

Database column name: `comment_5_data_access`

When the extraction form is loaded, this element was hidden. It would be shown if any of the following conditions were met:

* "Can the data be found? " is: "Yes"
* "Can the data be found? " is: "Unsure"

In the case that this element was hidden again by a conditional display event after a response was entered, the response would be cleared.

### Has the data been shared in a machine-readable format?

Variable type: Categorical (single selection only)

Database column name: `is_machine_readable_format`

Extractors were prompted to select one of the following mutually exclusive options.

| Displayed option name | Database value |
|:----------------------|---------------:|
| Yes | yes |
| No | no |
| Unsure | unsure |
| Format was not determined | format_unknown |

Extractor prompt: 
```
(i) The data was shared in a machine-readable format. For tables these are e.g. CSV or Excel files, for texts – TXT, DOC, unformatted text, XML; PDF and PDF/A are conditionally machine-readable, but because there is no adequate structuring in this format type and it is resource-intensive to check the exact format of a PDF file, PDFs are not considered machine-readable here. Other types of files are always entered as machine-readable. The format might be undetermined e.g. when data are packed in zip files. If these are >200 MB large and a download would be required to check the file type, the format is indicated as undetermined. File formats are typically undetermined for rare data types or very large data, and thus it is assumed that the files are in line with Open Data criteria, and the extraction is continued. 

(ii) Lists from ETH Zurich and Publisso can provide support in case of doubt regarding machine-readability of file formats, but it should be noted that machine readability is not the same as suitability for digital long-term archiving.  
```

When the extraction form is loaded, this element was hidden. It would be shown if any of the following conditions were met:

* "Can the data be accessed? " is: "Yes"
* "Can the data be accessed? " is: "Unsure"

In the case that this element was hidden again by a conditional display event after a response was entered, the response would be cleared.

### Comment 6

Variable type: Open text field

Database column name: `comment_6_format`

When the extraction form is loaded, this element was hidden. It would be shown if any of the following conditions were met:

* "Can the data be accessed? " is: "Yes"
* "Can the data be accessed? " is: "Unsure"

In the case that this element was hidden again by a conditional display event after a response was entered, the response would be cleared.

### In what format is the data presented? (multiple entries possible)

Variable type: Categorical (multiple selection allowed)

Extractors were prompted to select one or more of the following options.

The options selected by extractors would be exported with a 1 in the corresponding database column.

| Displayed option name | Database column |
|:----------------------|----------------:|
| Excel | machine_readable_format_excel |
| CSV | machine_readable_format_csv |
| TXT | machine_readable_format_txt |
| SPSS | machine_readable_format_spss |
| Other text or table formats | machine_readable_format_other_text_formats |
| Video | machine_readable_format_video |
| Audio | machine_readable_format_audio |
| Image | machine_readable_format_picture |
| FASTA/FASTQ | machine_readable_format_fasta_fastq |
| RAW | machine_readable_format_raw |
| Other genetic sequences | machine_readable_format_genetic_sequences |
| Other subject specific format | machine_readable_format_subject_specific_format |
| Unsure | machine_readable_format_unsure |

When the extraction form is loaded, this element was hidden. It would be shown if any of the following conditions were met:

* "Has the data been shared in a machine-readable format?" is: "Yes"
* "Has the data been shared in a machine-readable format?" is: "Unsure"

In the case that this element was hidden again by a conditional display event after a response was entered, the response would be cleared.

### Comment 7

Variable type: Open text field

Database column name: `comment_7_machine_readable_format`

When the extraction form is loaded, this element was hidden. It would be shown if any of the following conditions were met:

* "Has the data been shared in a machine-readable format?" is: "Yes"
* "Has the data been shared in a machine-readable format?" is: "Unsure"

In the case that this element was hidden again by a conditional display event after a response was entered, the response would be cleared.

### If the data is image or audiovisual data: does the data have more than just illustrative character?

Variable type: Categorical (single selection only)

Database column name: `illustrative_files`

Extractors were prompted to select one of the following mutually exclusive options.

| Displayed option name | Database value |
|:----------------------|---------------:|
| Yes | yes |
| No | no |
| Inapplicable | inapplicable |
| Unsure | unsure |

Extractor prompt: 
```
Data are purely illustrative if they serve as examples and do not form the full basis for at least a part of the analysis presented in the publication (e.g. for one figure). However, in individual cases, it can be difficult to evaluate whether this is the case. If image or audiovisual data stored in repositories are not explicitly described as examples and if there are at least three files, in case of doubt it can be assumed that they are not purely illustrative.  
```

When the extraction form is loaded, this element was hidden. It would be shown if any of the following conditions were met:

* "In what format is the data presented? (multiple entries possible)" is: "Audio"
* "In what format is the data presented? (multiple entries possible)" is: "Video"
* "In what format is the data presented? (multiple entries possible)" is: "Image"
* "In what format is the data presented? (multiple entries possible)" is: "RAW"
* "In what format is the data presented? (multiple entries possible)" is: "Unsure"

In the case that this element was hidden again by a conditional display event after a response was entered, the response would be cleared.

### Comment 8

Variable type: Open text field

Database column name: `comment_8_illustrative_files`

When the extraction form is loaded, this element was hidden. It would be shown if any of the following conditions were met:

* "In what format is the data presented? (multiple entries possible)" is: "Image"

In the case that this element was hidden again by a conditional display event after a response was entered, the response would be cleared.

### Does the data allow the analytical replication of at least some results?

Variable type: Categorical (single selection only)

Database column name: `analytical_replication`

Extractors were prompted to select one of the following mutually exclusive options.

| Displayed option name | Database value |
|:----------------------|---------------:|
| Yes (always for OMICS data) | yes |
| No | no |
| Tends to be more positive | replication |
| Tends to be more negative | no_replication |

Extractor prompt: 
```
(i) Data must be primary, unprocessed, or "raw" to the extent that they can be the basis for analyses presented in the publication. The data may already be corrected or otherwise processed, but they must be substantially more detailed than summary statistics. Lists of genes, proteins, or similar units with associated individual p-values are not sufficient. The pure amount of data is not decisive. Even very small tables can contain raw data if the sample size is small. If several measured values are listed for a unit of observation, sufficiently unprocessed data can be assumed in case of doubt.  

(ii) OMICS data – given they fulfilled all criteria so far - are always to be considered as allowing analytical replication. 
```

When the extraction form is loaded, this element was hidden. It would be shown if any of the following conditions were met:

* "Has the data been shared in a machine-readable format?" is: "Yes"
* "Has the data been shared in a machine-readable format?" is: "Format was not determined"
* "Has the data been shared in a machine-readable format?" is: "Unsure"
* "If the data is image or audiovisual data: does the data have more than just illustrative character?" has a response

In the case that this element was hidden again by a conditional display event after a response was entered, the response would be cleared.

### Comment 9

Variable type: Open text field

Database column name: `comment_9_analytical_replication`

When the extraction form is loaded, this element was hidden. It would be shown if any of the following conditions were met:

* "Has the data been shared in a machine-readable format?" is: "Format was not determined"
* "If the data is image or audiovisual data: does the data have more than just illustrative character?" has a response
* "Has the data been shared in a machine-readable format?" is: "Yes"
* "Has the data been shared in a machine-readable format?" is: "Unsure"

In the case that this element was hidden again by a conditional display event after a response was entered, the response would be cleared.

## Data Reuse Statement as well as the article types like 'opinion paper', 'review' or aditional' will not be pursued. Please click on completed.

When the extraction form is loaded, this element was hidden. It would be shown if any of the following conditions were met:

* "Has the shared data been generated by the authors of the corresponding article („Own Data“) or is it re-used data generated by others („Data Reuse”)?" is: "Data Reuse"
* "Can the data be accessed? " is: "No, access restricted"
* "Is there a clear reference to data in the publication?" is: "Inapplicable (e.g. if the article type is 'review', 'opinion' or 'aditional')"

In the case that this element was hidden again by a conditional display event after a response was entered, the response would be cleared.

## Conclusion:

When the extraction form is loaded, this element was hidden. It would be shown if any of the following conditions were met:

* "Is there a clear reference to data in the publication?" is: "No"
* "Has the data been shared in a repository?" is: "No"
* "Can the data be found? " is: "No"
* "Can the data be accessed? " is: "No, not uploaded or stored"
* "Has the data been shared in a machine-readable format?" is: "No"
* "Does the data allow the analytical replication of at least some results?" has a response

In the case that this element was hidden again by a conditional display event after a response was entered, the response would be cleared.

### Have the Open Data requirements been met? Is a discussion necessary?

Variable type: Categorical (single selection only)

Database column name: `assessment`

Extractors were prompted to select one of the following mutually exclusive options.

| Displayed option name | Database value |
|:----------------------|---------------:|
| Open Data, no discussion needed | open_data |
| Unsure, discussion needed | unsure_open_data |
| No Open Data, no discussion needed  | no_open_data |

When the extraction form is loaded, this element was hidden. It would be shown if any of the following conditions were met:

* "Is there a clear reference to data in the publication?" is: "No"
* "Has the data been shared in a repository?" is: "No"
* "Can the data be found? " is: "No"
* "Can the data be accessed? " is: "No, not uploaded or stored"
* "Has the data been shared in a machine-readable format?" is: "No"
* "Does the data allow the analytical replication of at least some results?" has a response

In the case that this element was hidden again by a conditional display event after a response was entered, the response would be cleared.

### Comment 10

Variable type: Open text field

Database column name: `comment_10_open_data_discussion`

When the extraction form is loaded, this element was hidden. It would be shown if any of the following conditions were met:

* "Is there a clear reference to data in the publication?" is: "No"
* "Has the data been shared in a repository?" is: "No"
* "Can the data be found? " is: "No"
* "Can the data be accessed? " is: "No, not uploaded or stored"
* "Has the data been shared in a machine-readable format?" is: "No"
* "Does the data allow the analytical replication of at least some results?" has a response

In the case that this element was hidden again by a conditional display event after a response was entered, the response would be cleared.

### Assign to

Extractors were prompted to assign this reference to another extractor.

When the extraction form is loaded, this element was hidden. It would be shown if any of the following conditions were met:

* "Have the Open Data requirements been met? Is a discussion necessary?" is: "Unsure, discussion needed"

In the case that this element was hidden again by a conditional display event after a response was entered, the response would be cleared.

## Please click on completed to finish the extraction.

When the extraction form is loaded, this element was hidden. It would be shown if any of the following conditions were met:

* "Is there a clear reference to data in the publication?" is: "No"
* "Has the data been shared in a repository?" is: "No"
* "Can the data be found? " is: "No"
* "Can the data be accessed? " is: "No, not uploaded or stored"
* "Can the data be accessed? " is: "No, access restricted"
* "Has the data been shared in a machine-readable format?" is: "No"
* "Does the data allow the analytical replication of at least some results?" has a response
* "Have the Open Data requirements been met? Is a discussion necessary?" has a response

In the case that this element was hidden again by a conditional display event after a response was entered, the response would be cleared.

# Acknowledgements

This codebook was automatically generated by Numbat Systematic Review Mananger.(1)

# References

1. Carlisle, B. G. Numbat Systematic Review Manager [Software]. Retrieved from https://numbat.bgcarlisle.com: *The Grey Literature*; 2020. Available from: https://numbat.bgcarlisle.com