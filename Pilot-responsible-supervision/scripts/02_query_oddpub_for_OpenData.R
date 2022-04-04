library(tidyverse)

#Admin set-up, add your email address and set up a folder structure. 
email = "tamarinde.haven@bih-charite.de"
pdf_folder = "~tamarinde1/projects/responsiblesupervision/pilot-responsible-supervision/pdfs/"
pdf_txt_folder = "~tamarinde1/projects/responsiblesupervision/pilot-responsible-supervision/pdf_to_txt/"

#download PDFs, read in the dataset; please check/revise the file name as needed. 
dataset <- read_csv("pilot-result.csv")

dois <- dataset$doi
dois <- dois[dois != "" & !is.na(dois)] %>% unique()

pdfRetrieve::pdf_retrieve(dois, email,
                          save_folder = pdf_folder,
                          sleep = 10)

#convert PDFs to text and screen with oddpub
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
