library(tidyverse)


## Admin details. 1) Set up email address, 2) make folder for pdfs, 3) make folder for pdf to text (see example below)
email = '' # put your email address in here
pdf_folder = '' # specify the folder where the PDFs will be stored
pdf_txt_folder = '' # specify the folder where the text files (converted from the PDFs) will be stored

## Download PDFs. Note that you might need to install pdfRetrieve. Also check the file name of the csv you read in.
dataset <- read_csv("pilot-result.csv")

dois <- dataset$doi
dois <- dois[dois != "" & !is.na(dois)] %>% unique()

pdfRetrieve::pdf_retrieve(dois, email,
                          save_folder = pdf_folder,
                          sleep = 10)

## Converting the PDFs to text and screening the text with oddpub for Open Data statements
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

## NOTE TO STUDENT ASSISTANTS
## (please specify here how the data sanity checks will be done)