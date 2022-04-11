library(tidyverse)


## Admin details. 1) Set up email address, 2) make folder for pdfs, 3) make
## folder for pdf to text (see example below)
email = '' # put your email address in here
pdf_folder = '' # specify the folder where the PDFs will be stored
pdf_txt_folder = '' # specify the folder where the text files (converted from the PDFs) will be stored

## Download PDFs. Note that you might need to install pdfRetrieve. Also check
## the file name of the csv you read in.
dataset <- read_csv("pilot-result.csv")

dois <- dataset$doi
dois <- dois[dois != "" & !is.na(dois)] %>% unique()

pdfRetrieve::pdf_retrieve(dois, email,
                          save_folder = pdf_folder,
                          sleep = 10)

## Converting the PDFs to text and screening the text with oddpub for Open Data
## statements
oddpub::pdf_convert(pdf_folder, pdf_txt_folder)
pdf_txt <- oddpub::pdf_load(pdf_txt_folder)
oddpub_results <- oddpub::open_data_search_parallel(pdf_txt)

oddpub_results %>% write_csv("oddpub_results.csv")


#combine results with input table
oddpub_results <- oddpub_results %>%
  mutate(doi = article %>%
           str_remove(".txt") %>%
           str_replace_all(fixed("+"), "/")) %>%
  select(-article)


dataset_oddpub <- dataset %>%
  left_join(oddpub_results) %>%
  mutate(downloaded = !is.na(is_open_data))


dataset_oddpub %>% write_csv("pilot-result_oddpub.csv")


## The next step would be to import the dataset into Numbat and inspect the
## open data statements using the openness_data_check_(en)_2021.md. See the
## Pilot-responsible-supervision folder. Please inspect the extracted open
## open code statements manually by creating two extra columns, e.g.,
## open_code_checkR1 (Rater 1) and open_code_checkR2 (Rater 2) to verify they 
## are find able and openly accessible.
## In parallel, import the same dataset into Numbat and inspect all the publications
## for open methods statements using the open_methods_extraction_form.md. See
## the Pilot-responsible-supervision folder.
## Please have two raters independently scrutinise the statements using this
## extraction form.
