# Install and load packages, For oddpub, see: https://github.com/quest-bih/oddpub 

library(tidyverse)
library(oddpub)

## Admin details. 1) Set up email address, 2) make folder for pdfs, 3) make
## folder for pdf to text (see example below)
email =  # put your email address in here in ''
pdf_folder =  # specify the folder in '' where the PDFs will be stored
pdf_txt_folder = # specify the folder in '' where the text files (converted from the PDFs) will be stored

## Download PDFs. Note that you might need to install pdfRetrieve. Also check
## the file name of the csv you read in.
dataset <- read_csv("...")

ddois <- dataset$doi
dois <- dois[dois != "" & !is.na(dois)] %>% unique()

pdfRetrieve::pdf_retrieve(dois, email,
                          save_folder = pdf_folder,
                          sleep = 10)

## Please check here whether all the DOIs now indeed have a matching PDF.
## If not, try to obtain the PDFs through colleagues or other ways.

## Converting the PDFs to text and screening the text with oddpub for Open Data
## statements
oddpub::pdf_convert(pdf_folder, pdf_txt_folder)
pdf_txt <- oddpub::pdf_load(pdf_txt_folder)
oddpub_results <- oddpub::open_data_search_parallel(pdf_txt)

oddpub_results %>% write_csv("..._oddpub_checks.csv")


#combine results with input table
oddpub_results <- oddpub_results %>%
  mutate(doi = article %>%
           str_remove(".txt") %>%
           str_replace_all(fixed("+"), "/")) %>%
  select(-article)


dataset_oddpub <- dataset %>%
  left_join(oddpub_results) %>%
  mutate(downloaded = !is.na(is_open_data))


dataset_oddpub %>% write_csv("..._oddpub_checks_combined.csv")


## The next step would be to import the dataset into Numbat and inspect the
## open data statements according to this protocol:
## https://www.protocols.io/view/semi-automated-extraction-of-information-on-open-d-q26g74p39gwz/v1
## the extraction form also appears in the Pilot-responsible-supervision folder. 
