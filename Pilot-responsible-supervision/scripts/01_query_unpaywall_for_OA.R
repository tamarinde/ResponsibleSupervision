# Script to obtain the OA status of a set of DOIs (adapted from Delwen Franzen)
# Queries Unpaywall via its API with UnpaywallR (Nico Riedel, https://github.com/NicoRiedel/unpaywallR)

library(readr)
library(dplyr)
library(readxl)
library(ConfigParser)
library(here)
library(devtools)
install_github("NicoRiedel/unpaywallR")
library(unpaywallR)

# Set email for Unpaywall query (see README.md)
cfg <- ConfigParser$new()
cfg$read("Pilot-responsible-supervision/config.ini")
email_api <- cfg$get("email", NA, "login")

##please double the appropriate working directory

data <- read_csv(
  "data/output.csv"
  )

# Get vector of unique DOIs (TO DO: add assert statement)
dois <- data %>%
  filter(
    !is.na(doi)
  ) %>%
  distinct(doi) %>%
  pull(doi)

print(paste("Number of unique DOIs:", length(dois)))

# Define OA hierarchy of interest in case of multiple OA statuses
hierarchy <-
  c("gold",
    "hybrid",
    "green",
    "bronze",
    "closed")

# Query Unpaywall with input DOIs
unpaywall_results <-
  unpaywallR::dois_OA_colors(
    dois,
    email_api,
    clusters = 2,
    color_hierarchy = hierarchy
  ) %>%
  rename(oa_status = OA_color, publication_date_unpaywall = date)

# Join initial data and Unpaywall results
result <-
  left_join(data, unpaywall_results, by = "doi") %>%
  mutate(across(everything(), ~na_if(., "")))

# Joining data without the 22 duplicated doi with unpaywall results
data$dup <- duplicated(data$doi)
data %>% filter(! dup)
data2 <- data %>% filter(! dup) %>% select(! dup)

final_result <-
  left_join(data2, unpaywall_results, by = "doi") %>%
  mutate(across(everything(), ~na_if(., "")))


write_csv(final_result, "data/01-script-output.csv")
