# Script to obtain the OA status of a set of DOIs (adapted from Delwen Franzen)
# Queries Unpaywall via its API with UnpaywallR (Nico Riedel, https://github.com/NicoRiedel/unpaywallR)

library(readr)
library(dplyr)
library(readxl)
library(ConfigParser)
library(here)
# renv::install("NicoRiedel/unpaywallR")
library(unpaywallR)

# Set email for Unpaywall query
cfg <- ConfigParser$new()
cfg$read("config.ini")
email_api <- cfg$get("email", NA, "login")

data <- read_excel(
  here("data", "pilot-dataset.xlsx")
  )

# Get vector of unique DOIs
dois <- data %>%
  filter(
    !is.na(doi)
  ) %>%
  distinct(doi) %>%
  pull(doi)

print(paste("Number of DOIs:", length(dois)))

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

write_csv(result, here("data", "pilot-result.csv"))
