## This script will take all the .xlsx files in a folder specified in
## `spreadsheet_folder` and combine them all into a single CSV file.

library(tidyverse)
library(readxl)

spreadsheet_folder <- "Pilot-responsible-supervision/data/spreadsheets/"

files <- list.files(
    spreadsheet_folder,
    "\\.xlsx$"
)

combined <- tibble()

for (spreadsheet in files) {
    newrows <- read_xlsx(
        paste0(
            spreadsheet_folder,
            spreadsheet
        )
    ) %>%
        select(
            pair,
            phd_candidate,
            supervisor,
            country,
            institute,
            subfield,
            doi,
            owner,
            position_author_supervisor,
            concern_methods_tools_devlpmnt_or_review,
            thesis_year,
            thesis_title,
            thesis_link
        )

    combined <- combined %>%
        bind_rows(newrows)
}

combined %>%
    write_csv(paste0("Pilot-responsible-supervision/data/", "output.csv"))
