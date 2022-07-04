library(tidyverse)


## ---- READ DATA ----

#dat <- read_csv(here('data', 'pilot_data_processed.csv'))
dat <- read_csv("data/open_access_added.csv")


## ---- DO DESCRIPTIVE STATS ----

## count the number of publications for supervisors and candidates (denominator)
n_pubs_supervisors <- dat %>%
  filter(owner == 'supervisor') %>%
  nrow()
n_pubs_candidates <- dat %>%
  filter(owner == 'candidate') %>%
  nrow()

## descriptive stats - Open Access
summary(dat$is_open_access)
dat %>%
  filter(owner == 'supervisor' & is_open_access == TRUE) %>%
  nrow()
dat %>%
  filter(owner == 'candidate' & is_open_access == TRUE) %>%
  nrow()

## descriptive stats - open data
summary(dat$is_open_data)
dat %>%
  filter(owner == 'supervisor' & is_open_data == TRUE) %>%
  nrow()
dat %>%
  filter(owner == 'candidate' & is_open_data == TRUE) %>%
  nrow()


## ---- CALCULATE CORRELATION COEFFICIENTS ----

## prepare correlations
dat_candidate <- dat %>%
  ungroup() %>%
  filter(owner == 'candidate') %>%
  group_by(pair) %>%
  mutate(n_pubs_candidate = n()) %>%
  mutate(n_pubs_open_access_candidate = sum(is_open_access)) %>%
  mutate(n_pubs_open_data_candidate = sum(is_open_data))

dat_supervisor <- dat %>%
  ungroup() %>%
  filter(owner == 'supervisor') %>%
  group_by(pair) %>%
  mutate(n_pubs_supervisor = n()) %>%
  mutate(n_pubs_open_access_supervisor = sum(is_open_access)) %>%
  mutate(n_pubs_open_data_supervisor = sum(is_open_data)) 

dat <- bind_rows(dat_candidate, dat_supervisor)
rm(dat_candidate, dat_supervisor)

dat_aggregated <- dat %>%
  ungroup() %>%
  group_by(pair) %>%
  fill(
    n_pubs_candidate,
    n_pubs_open_access_candidate,
    n_pubs_open_data_candidate,
    n_pubs_supervisor,
    n_pubs_open_access_supervisor,
    n_pubs_open_data_supervisor,
    .direction = 'downup'
  ) %>%
  slice_head() %>%
  mutate(
    open_access_candidate = n_pubs_open_access_candidate/n_pubs_candidate,
    open_access_supervisor = n_pubs_open_access_supervisor/n_pubs_supervisor,
    open_data_candidate = n_pubs_open_data_candidate/n_pubs_candidate,
    open_data_supervisor = n_pubs_open_data_supervisor/n_pubs_supervisor
  )

## create a new dataframe with just the relevant variables for correlations
## (this is an aggregated dataset with just one line per pair)
dat_cor <- dat_aggregated %>%
  select(
    c(
      pair,
      phd_candidate,
      supervisor,
      n_pubs_candidate,
      n_pubs_open_access_candidate,
      n_pubs_open_data_candidate,
      n_pubs_supervisor,
      n_pubs_open_access_supervisor,
      n_pubs_open_data_supervisor,
      open_access_candidate,
      open_access_supervisor,
      open_data_candidate,
      open_data_supervisor
    )
  ) %>%
  rename(
    frac_open_access_candidate = open_access_candidate,
    frac_open_access_supervisor = open_access_supervisor,
    frac_open_data_candidate = open_data_candidate,
    frac_open_data_supervisor = open_data_supervisor
  )

##New correlation code added by NH because other codes below did not work 
cor.test(
  dat_cor$frac_open_access_candidate,
  dat_cor$frac_open_access_supervisor,
  method = "spearman"
)
cor.test(
  dat_cor$frac_open_data_candidate,
  dat_cor$frac_open_data_supervisor,
  method = "spearman"
)

## (Pearson) correlaton - Open Access
cor_OA_Pearson <- cor(
  dat_cor$frac_open_access_candidate,
  dat_cor$frac_open_access_supervisor,
  method = 'pearson',
  use = 'pairwise.complete.obs' # account for missing data
)
cor_OA_Pearson
## (Spearman) correlaton - Open Access
cor_OA_Spearman <- cor(
  dat_cor$frac_open_access_candidate,
  dat_cor$frac_open_access_supervisor,
  method = 'spearman',
  use = 'pairwise.complete.obs' # account for missing data
)
cor_OA_Spearman
## visual inspect
plot(dat_cor$frac_open_access_candidate, dat_cor$frac_open_access_supervisor)

## (Pearson) correlaton - open data
cor_OD_Pearson <- cor(
  dat_cor$frac_open_data_candidate,
  dat_cor$frac_open_data_supervisor,
  method = 'pearson',
  use = 'pairwise.complete.obs' # account for missing data
)
cor_OD_Pearson
## (Spearman) correlaton - open data
cor_OD_Spearman <- cor(
  dat_cor$frac_open_data_candidate,
  dat_cor$frac_open_data_supervisor,
  method = 'spearman',
  use = 'pairwise.complete.obs' # account for missing data
)
cor_OD_Spearman
## visual inspect
plot(dat_cor$frac_open_data_candidate, dat_cor$frac_open_data_supervisor)

## plot the correlations in one dataframe
table_correlations <- tribble(
  ~rating, ~spearman_correlation, ~pearson_correlation,
  'Open Access', cor_OA_Spearman, cor_OA_Pearson,
  'Open Data', cor_OD_Spearman, cor_OD_Pearson
)
View(table_correlations)


## --- SAVE FILES ----

dat_cor %>%
  write_csv(here('data', 'pilot_data_correlations.csv'))

table_correlations %>%
  write_csv(here('data', 'pilot_table_correlations.csv'))
