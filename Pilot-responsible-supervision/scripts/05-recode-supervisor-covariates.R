library(tidyverse)

# test dataset
dataset <- tribble(
  ~pair, ~owner, ~oa_status, ~is_open_data,
  1, "supervisor", TRUE, TRUE,
  1, "supervisor", TRUE, TRUE,
  1, "supervisor", FALSE, FALSE,
  1, "candidate", FALSE, FALSE,
  2, "supervisor", TRUE, TRUE,
  2, "supervisor", TRUE, TRUE,
  2, "candidate", FALSE, FALSE,
  3, "supervisor", FALSE, FALSE,
  4, "supervisor", TRUE, TRUE,
  4, "supervisor", FALSE, FALSE
)

dataset <- dataset %>%
  # account for when oa_status is NA otherwise this will return NA
  filter(
    owner == "supervisor",
    !is.na(oa_status)
    ) %>%
  group_by(pair) %>%
  mutate(
    denom = n(),
    num = sum(oa_status),
    perc = round(num/denom, 2)
  ) %>%
  slice(1) %>%
  ungroup() %>%
  # decide how to handle exact matches to threshold
  mutate(oa_category = case_when(
    perc < 0.76 ~ 1,
    perc >= 0.76 ~ 2
    )) %>%
  # what should the structure of the output dataframe be?
  select(!oa_status) %>%
  select(!owner)

## Below regards the most recent open data version, i.e., after using the protocol
## https://dx.doi.org/10.17504/protocols.io.q26g74p39gwz/v1 in the Numbat 
## https://numbat.bgcarlisle.com extraction tool. It can be adapted for the 
## other open data analyses that relied on ODDPub only. 

dataset <- read_csv("numbat_duplicated_removed_renamed.csv")

dataset_numbat <- dataset %>%
  filter(owner == "supervisor") %>%
  group_by(pair) %>%
  mutate(sum(numbat_open) > 0) %>%
  mutate(open_data_numbat_ever = ifelse(`sum(numbat_open) > 0`, 1, 0)) %>%
  slice_head() %>%
  select(pair, open_data_numbat_ever)

dataset_numbat %>% write_csv("data_numbat_supervisors.csv")

dataset_full <- read_csv("numbat_duplicated_removed_renamed.csv")

dataset_supervissors <- read_csv("data_numbat_supervisors.csv")

merged <- dataset_full %>% left_join (dataset_supervissors)

merged %>%
  write_csv("final_dataset_full_numbat_added.csv")

merged %>%
  filter(owner == "candidate") %>%
  write_csv("final_dataset_numbat_added_candidates_only.csv")
