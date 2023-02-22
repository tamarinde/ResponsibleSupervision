library(tidyverse)

## Import relevant data set (Unpaywall, Oddpub and Numbat data added)
dataset <- read_csv("230215_automated_extractions_OA_OD_plus_manually_verified_anonymized.csv")

## ----  RECODE SUPERVISOR BEHAVIOUR ---

## Re-coding Open Access. We transform open access publishing into:
## above (=2) the national average (76%) of 2021 vs. below (=1)
## source: https://www.rathenau.nl/en/science-figures/output/publications/open-access-research-publications )

dataset_supervisor_oa <- dataset %>% 
  filter(
    owner == "supervisor",
    !is.na(oa_status)
    ) %>%
    group_by(pair) %>%
    mutate(denominator = n()) %>%
    mutate(sum(oa_status)) %>%
    mutate(fraction = `sum(oa_status)`/denominator) %>%
    rename(numerator = `sum(oa_status)`) %>%
    slice_head() %>%
    mutate(category = ifelse(fraction > 0.76, 2, 1)) %>%
    select(! oa_status) %>%
    select(! owner)

dataset_supervisor_oa %>% write.csv("dataset_supervisor_oa.csv")

## Taking out the relevant columns
dataset_supervisor_oa_sliced <- dataset_supervisor_oa %>% 
  select(c('pair','category'))

dataset_supervisor_oa_sliced %>% write_csv("dataset_supervisor_oa_sliced.csv")

## Recoding open data automated (based on OddPub screening)
## ever open data (=1), no open data (=0)

dataset <- read_csv("230215_automated_extractions_OA_OD_plus_manually_verified_anonymized.csv")

dataset_oddpub <- dataset %>%
  # account for when is_open_data is NA otherwise this will return NA
  filter(
    owner == "supervisor",
    !is.na(is_open_data)
    ) %>%
    group_by(pair) %>%
    mutate(sum(is_open_data) > 0) %>%
    mutate(open_data_ever = ifelse(`sum(is_open_data) > 0`, 1, 0)) %>%
    slice_head() %>%
    select(pair, open_data_ever)

dataset_oddpub %>% write.csv("data_oddpub_supervisors.csv")

## Recoding open data manually verified (based on Numbat extractions)
## after using the protocol: https://dx.doi.org/10.17504/protocols.io.q26g74p39gwz/v1 
## with the Numbat extraction tool: https://numbat.bgcarlisle.com
## ever open data (=1), no open data (=0)

dataset_numbat <- dataset %>%
  # account for when is_open_data_manually verified is NA otherwise this will return NA
  filter(
    owner == "supervisor",
    !is.na(is_open_data_manually_verified)
     ) %>%
    group_by(pair) %>%
    mutate(sum(is_open_data_manually_verified) > 0) %>%
    mutate(open_data_numbat_ever = ifelse(`sum(is_open_data_manually_verified) > 0`, 1, 0)) %>%
    slice_head() %>%
    select(pair, open_data_numbat_ever)

dataset_numbat %>% write.csv("data_numbat_supervisors.csv")

## ----  TRANSFORMING DATASET TO LEVEL OF THE CANDIDATE ---
dataset %>%
  filter(owner == "candidate") %>%
  write_csv("dataset_candidates_only.csv")

## ---- MERGING THE DATASETS 

dataset_candidates <- read_csv("dataset_candidates_only.csv")

merged_oa <- 
  left_join(dataset_candidates, dataset_supervisor_oa_sliced, by = "pair")

merged_od <-
  left_join(merged_oa, dataset_oddpub, by = "pair")

merged_od_mv <-
  left_join(merged_od, dataset_numbat, by = "pair")

merged_od_mv %>% write.csv("gee_logistic_regression.csv")
