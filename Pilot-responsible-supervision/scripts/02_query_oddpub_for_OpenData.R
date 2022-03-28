library(tidyverse)

email = "nico.riedel@bih-charite.de"
pdf_folder = "F:/Datenablage/sonstiges/Anfrage Tamarinde oddpub/pdfs/"
pdf_txt_folder = "F:/Datenablage/sonstiges/Anfrage Tamarinde oddpub/pdf_to_txt/"

#download PDFs
dataset <- read_csv("pilot-result.csv")

dois <- dataset$doi
dois <- dois[dois != "" & !is.na(dois)] %>% unique()

pdfRetrieve::pdf_retrieve(dois, email,
                          save_folder = pdf_folder,
                          sleep = 10)

#screen with oddpub
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
