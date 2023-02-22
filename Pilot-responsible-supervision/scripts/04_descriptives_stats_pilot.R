library(tidyverse)


## ---- READ DATA ----

#read in full dataset on publication level.
dat <- read_csv("230215_automated_extractions_OA_OD_plus_manually_verified_anonymized.csv")


## ---- DO DESCRIPTIVE STATS ----

## count the number of publications for supervisors and candidates (denominator)
n_pubs_supervisors <- dat %>%
  filter(owner == 'supervisor') %>%
  nrow()
n_pubs_candidates <- dat %>%
  filter(owner == 'candidate') %>%
  nrow()

## descriptive stats - Open Access
summary(dat$oa_status)
dat %>%
  filter(owner == 'supervisor' & oa_status == TRUE) %>%
  nrow()
dat %>%
  filter(owner == 'candidate' & oa_status == TRUE) %>%
  nrow()

## descriptive stats - Open Data automated
summary(dat$is_open_data)
dat %>%
  filter(owner == 'supervisor' & is_open_data == TRUE) %>%
  nrow()
dat %>%
  filter(owner == 'candidate' & is_open_data == TRUE) %>%
  nrow()

## descriptive stats - Open Data manually verified 
summary(dat$is_open_data_manually_verified)
dat %>%
  filter(owner == 'supervisor' & is_open_data_manually_verified == TRUE) %>%
  nrow()
dat %>%
  filter(owner == 'candidate' & is_open_data_manually_verified == TRUE) %>%
  nrow()

## ---- CALCULATE CORRELATION COEFFICIENTS ----

## prepare correlations
dat_candidate <- dat %>%
  ungroup() %>%
  filter(owner == 'candidate') %>%
  group_by(pair) %>%
  mutate(n_pubs_candidate = n()) %>%
  mutate(n_pubs_open_access_candidate = sum(oa_status)) %>%
  mutate(n_pubs_open_data_candidate = sum(is_open_data)) %>%
  mutate(n_pubs_open_data_manually_verified_candidate = sum(is_open_data_manually_verified))

dat_supervisor <- dat %>%
  ungroup() %>%
  filter(owner == 'supervisor') %>%
  group_by(pair) %>%
  mutate(n_pubs_supervisor = n()) %>%
  mutate(n_pubs_open_access_supervisor = sum(oa_status)) %>%
  mutate(n_pubs_open_data_supervisor = sum(is_open_data)) %>%
  mutate(n_pubs_open_data_manually_verified_supervisor = sum(is_open_data_manually_verified))

dat <- bind_rows(dat_candidate, dat_supervisor)
rm(dat_candidate, dat_supervisor)

dat_aggregated <- dat %>%
  ungroup() %>%
  group_by(pair) %>%
  fill(
    n_pubs_candidate,
    n_pubs_open_access_candidate,
    n_pubs_open_data_candidate,
    n_pubs_open_data_manually_verified_candidate,
    n_pubs_supervisor,
    n_pubs_open_access_supervisor,
    n_pubs_open_data_supervisor,
    n_pubs_open_data_manually_verified_supervisor,
    .direction = 'downup'
  ) %>%
  slice_head() %>%
  mutate(
    open_access_candidate = n_pubs_open_access_candidate/n_pubs_candidate,
    open_access_supervisor = n_pubs_open_access_supervisor/n_pubs_supervisor,
    open_data_candidate = n_pubs_open_data_candidate/n_pubs_candidate,
    open_data_supervisor = n_pubs_open_data_supervisor/n_pubs_supervisor,
    open_data_MV_candidate = n_pubs_open_data_manually_verified_candidate,
    open_data_MV_supervisor = n_pubs_open_data_manually_verified_supervisor
  )

## create a new dataframe with just the relevant variables for correlations
## (this is an aggregated dataset with just one line per pair)
dat_cor <- dat_aggregated %>%
  select(
    c(
      pair,
      n_pubs_candidate,
      n_pubs_open_access_candidate,
      n_pubs_open_data_candidate,
      n_pubs_open_data_manually_verified_candidate,
      n_pubs_supervisor,
      n_pubs_open_access_supervisor,
      n_pubs_open_data_supervisor,
      n_pubs_open_data_manually_verified_supervisor,
      open_access_candidate,
      open_access_supervisor,
      open_data_candidate,
      open_data_supervisor,
      open_data_MV_candidate,
      open_data_MV_supervisor
    )
  ) %>%
  rename(
    frac_open_access_candidate = open_access_candidate,
    frac_open_access_supervisor = open_access_supervisor,
    frac_open_data_candidate = open_data_candidate,
    frac_open_data_supervisor = open_data_supervisor,
    frac_open_data_MV_candidate = open_data_MV_candidate,
    frac_open_data_MV_supervisor = open_data_MV_supervisor
  )

## (Pearson) correlation - Open Access
cor_OA_Pearson <- cor(
  dat_cor$frac_open_access_candidate,
  dat_cor$frac_open_access_supervisor,
  method = 'pearson',
  use = 'pairwise.complete.obs' # account for missing data
)
#cor_OA_Pearson
## (Spearman) correlation - Open Access
cor_OA_Spearman <- cor(
  dat_cor$frac_open_access_candidate,
  dat_cor$frac_open_access_supervisor,
  method = 'spearman',
  use = 'pairwise.complete.obs' # account for missing data
)
cor_OA_Spearman
## visual inspect
plot(dat_cor$frac_open_access_candidate, dat_cor$frac_open_access_supervisor)

## (Pearson) correlation - Open Data automated
cor_OD_Pearson <- cor(
  dat_cor$frac_open_data_candidate,
  dat_cor$frac_open_data_supervisor,
  method = 'pearson',
  use = 'pairwise.complete.obs' # account for missing data
)
cor_OD_Pearson
## (Spearman) correlation - Open Data automated
cor_OD_Spearman <- cor(
  dat_cor$frac_open_data_candidate,
  dat_cor$frac_open_data_supervisor,
  method = 'spearman',
  use = 'pairwise.complete.obs' # account for missing data
)
cor_OD_Spearman

## (Pearson) correlation - Open Data manually verified
cor_ODMV_Pearson <- cor(
  dat_cor$frac_open_data_MV_candidate,
  dat_cor$frac_open_data_MV_supervisor,
  method = 'pearson',
  use = 'pairwise.complete.obs' # account for missing data
)
cor_ODMV_Pearson
## (Spearman) correlation - Open Data manually verified
cor_ODMV_Spearman <- cor(
  dat_cor$frac_open_data_MV_candidate,
  dat_cor$frac_open_data_MV_supervisor,
  method = 'spearman',
  use = 'pairwise.complete.obs' # account for missing data
)
cor_ODMV_Spearman

## visual inspect
plot(dat_cor$frac_open_data_candidate, dat_cor$frac_open_data_supervisor)

## plot the correlations in one dataframe
table_correlations <- tribble(
  ~rating, ~spearman_correlation, ~pearson_correlation,
  'Open Access', cor_OA_Spearman, cor_OA_Pearson,
  'Open Data automated', cor_OD_Spearman, cor_OD_Pearson,
  'Open Data manually verified',cor_ODMV_Spearman, cor_ODMV_Pearson
)
View(table_correlations)


## --- SAVE FILES ----

dat_cor %>%
  write_csv('correlation.csv')

table_correlations %>%
  write_csv('table_correlations.csv')
