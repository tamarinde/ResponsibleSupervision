library(tidyverse)


## ---- COMBINE DATASETS ----

## read in data

## this is the last file sent by Tamarinde (2022-02-23), with manual changes in the 'manual_check_code_mh'
## variable (which is Martin's manual Open Code checks)
dat_source <- read_delim('data/merged_data-Ungefair-maia_MH.csv', delim = ';')

## this is the latest file for the Open Methods ratings, which are now completed 
## (downloaded 2022-03-21)
dat_OM <- read_tsv('https://numbat.bgcarlisle.com/open-methods/export/2022-03-21_032013-form_1-refset_1-final.tsv') %>%
  # delete the lines that refer to Laurent Thomas, as there seems to be an error in the dataset
  # said errors are also the reason why we have to filter for id, not name
  filter(
    !c(
      referenceid == 64 |
        referenceid == 68 |
        referenceid == 70 |
        referenceid == 73 |
        referenceid == 74 |
        referenceid == 77 |
        referenceid == 78
    )
  ) %>%
  # select just the relevant variables from that dataset
  select(
    c(
      doi,
      open_methods_yn,
      unsure_explanation,
      type_of_open_methods_trial_registration_number,
      type_of_open_methods_preregistration,
      type_of_open_methods_protocol,
      type_of_open_methods_open_notebook,
      type_of_open_methods_open_code,
      type_of_open_methods_Other,
      link_open_methods,
      public_link_open_methods,
      additional_remarks
    )
  )

## merge the two datasets
dat <- left_join(dat_source, dat_OM, by = 'doi')


## ---- RECODE VARIABLES ----

## Open Access: create a binary vector that indicates whether a publication is Open Access or not
dat_source <- dat_source %>%
  mutate(
    is_open_access = case_when(
      oa_status == 'gold' | oa_status == 'green' | oa_status == 'hybrid' | oa_status == 'open' ~ TRUE,
      oa_status == 'bronze' | oa_status == 'closed' | oa_status == 'closed_' ~ FALSE,
      is.na(oa_status) ~ NA
    )
  )

## Open Data: create a binary vector that indicates whether a publication has open data or not
## (some items are NA, which indicates that ODDPub did not find an open data statement - thus,
## we count them as having no open data)
dat_source <- dat_source %>%
  mutate(
    is_open_data_2 = case_when( # I do not like the variable name, but 'is_open_data' already exists
      assessment == 'open_data' ~ TRUE,
      assessment == 'no_open_data' | is.na(assessment) ~ FALSE
    )
  )

## Open Code: create a binary vector that indicates whether a publication has open code or not
## (some items are NA, which indicates that ODDPub did not find an open code statement - thus,
## we count them as having no open data - also, I am using the 'manual_check_code_th' variable,
## as my assessments, as stored in the 'manual_check_code_mh' variable, were exactly the same)
dat_source <- dat_source %>%
  mutate(
    is_open_code_2 = case_when( # I do not like the variable name, but 'is_open_code' already exists
      manual_check_code_th == 'yes' ~ TRUE,
      manual_check_code_th == 'code_reuse' | manual_check_code_th == 'no' | is.na(manual_check_code_th) ~ FALSE
    )
  )

## Trial Registration Numbers: create a binary vector that indicates whether a publication has a TRN or not
dat_source <- dat_source %>%
  mutate(
    is_TRN = if_else(
      has_trn_secondary_id == TRUE | has_trn_abstract == TRUE | has_trn_ft == TRUE,
      TRUE,
      FALSE,
      missing = FALSE
    )
  )

## Open Methods: create a binary vector that indicates whether a publication has open methods or not
dat <- dat %>%
  mutate(
    is_open_methods = if_else(
      open_methods_yn == 'Yes',
      TRUE,
      FALSE
    )
  ) %>%
  relocate(is_open_methods, .before = open_methods_yn)


## ---- SAVE FILE ----


## save the file
dat %>%
  write_csv('data/pilot_data_processed.csv')
