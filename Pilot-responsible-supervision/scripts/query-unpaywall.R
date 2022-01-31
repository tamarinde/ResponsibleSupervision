# Convert PMIDs to DOIs and query Unpaywall

library(readr)
library(dplyr)
library(readxl)
library(ConfigParser)
source(here::here("scripts", "convert_id_single_type.R"))
# renv::install("NicoRiedel/unpaywallR")
library(unpaywallR)

# Set email for Unpaywall query
cfg <- ConfigParser$new()
cfg$read("config.ini")
email_api <- cfg$get("email", NA, "login")

# Convert PMIDs to DOIs ---------------------------------------------------

data <- read_excel(
  "data/pilot-dataset.xlsx"
  )

# Convert PMIDs to character vector
data$pmid <- as.character(data$pmid)

dois_from_pmids <-
  data %>%
  select(pmid) %>%
  rowwise() %>%
  mutate(
    doi =
      convert_id_single_type(pmid, from = "pmid", to = "doi", quiet = FALSE)
  ) %>%
  ungroup() %>%
  filter(!is.na(doi)) %>%
  distinct()


# Query Unpaywall ------------------------------------------------
# Using UnpaywallR (https://github.com/NicoRiedel/unpaywallR)

# Extract DOIs to query
pilot_dois <- dois_from_pmids %>%
  pull(doi)

print(paste("Number of DOIs:", length(pilot_dois)))

# Define hierarchy of interest in case of multiple OA statuses
hierarchy <-
  c("gold",
    "hybrid",
    "green",
    "bronze",
    "closed")

# Query Unpaywall with input DOIs
oa_data <-
  unpaywallR::dois_OA_colors(
    pilot_dois,
    email_api,
    clusters = 2,
    color_hierarchy = hierarchy
  ) %>%
  rename(oa_status = OA_color, publication_date_unpaywall = date)

temp <- full_join(dois_from_pmids, oa_data, by = "doi")

result <-
  left_join(data, temp, by = "pmid") %>%
  mutate(across(everything(), ~na_if(., "")))
write_csv(result, "data/pilot-result.csv")
