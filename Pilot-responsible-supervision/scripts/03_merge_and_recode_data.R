library(tidyverse)

## You should have reconciled manually verified open data verdicts now.
## Numbat exports a .tsv file.


## ---- COMBINE DATASETS ----

## read in data

dat_source <- read_csv #read in dataset with oddpub & Unpaywall data
dat_ODMV <- read_tsv #read in reconciled (manually verified) open data verdicts

## merge the two datasets
dat <- left_join(dat_source, dat_OM, by = 'doi')


## ---- RECODE VARIABLES ----

## Open Access: create a binary vector that indicates whether a publication is Open Access or not
dat <- dat %>%
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
dat <- dat %>%
  mutate(
    is_open_data_2 = case_when( # I do not like the variable name, but 'is_open_data' already exists
      assessment == 'open_data' ~ TRUE,
      assessment == 'no_open_data' | is.na(assessment) ~ FALSE
    )
  )


## ---- SAVE FILE ----


## save the file
dat %>%
  write_csv("pilot_data_processed.csv")
