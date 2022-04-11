library(tidyverse)


## ---- READ DATA ----

dat <- read_csv('data/pilot_data_processed.csv')


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
summary(dat$is_open_data_2)
dat %>%
  filter(owner == 'supervisor' & is_open_data_2 == TRUE) %>%
  nrow()
dat %>%
  filter(owner == 'candidate' & is_open_data_2 == TRUE) %>%
  nrow()

## descriptive stats - open methods
summary(dat$is_open_methods)
dat %>%
  filter(owner == 'supervisor' & is_open_methods == TRUE) %>%
  nrow()
dat %>%
  filter(owner == 'candidate' & is_open_methods == TRUE) %>%
  nrow()


## descriptive stats - trial registration
dat %>%
  filter(owner == 'supervisor' & type_of_open_methods_trial_registration_number == '1') %>%
  nrow()
dat %>%
  filter(owner == 'candidate' & type_of_open_methods_trial_registration_number == '1') %>%
  nrow()

## descriptive stats - preregistration
dat %>%
  filter(owner == 'supervisor' & type_of_open_methods_preregistration == '1') %>%
  nrow()
dat %>%
  filter(owner == 'candidate' & type_of_open_methods_preregistration == '1') %>%
  nrow()

## descriptive stats - protocol
dat %>%
  filter(owner == 'supervisor' & type_of_open_methods_protocol == '1') %>%
  nrow()
dat %>%
  filter(owner == 'candidate' & type_of_open_methods_protocol == '1') %>%
  nrow()

## descriptive stats - open notebook
dat %>%
  filter(owner == 'supervisor' & type_of_open_methods_open_notebook == '1') %>%
  nrow()
dat %>%
  filter(owner == 'candidate' & type_of_open_methods_open_notebook == '1') %>%
  nrow()

## descriptive stats - open code
summary(dat$is_open_code_3)
dat %>%
  filter(owner == 'supervisor' & is_open_code_3 == TRUE) %>%
  nrow()
dat %>%
  filter(owner == 'candidate' & is_open_code_3 == TRUE) %>%
  nrow()


## ---- CALCULATE CORRELATION COEFFICIENTS ----

## prepare correlations
dat_candidate <- dat %>%
  ungroup() %>%
  filter(owner == 'candidate') %>%
  group_by(pair) %>%
  mutate(n_pubs_candidate = n()) %>%
  mutate(n_pubs_open_access_candidate = sum(is_open_access)) %>%
  mutate(n_pubs_open_data_candidate = sum(is_open_data_2)) %>%
  mutate(n_pubs_open_methods_candidate = sum(is_open_methods))

dat_supervisor <- dat %>%
  ungroup() %>%
  filter(owner == 'supervisor') %>%
  group_by(pair) %>%
  mutate(n_pubs_supervisor = n()) %>%
  mutate(n_pubs_open_access_supervisor = sum(is_open_access)) %>%
  mutate(n_pubs_open_data_supervisor = sum(is_open_data_2)) %>%
  mutate(n_pubs_open_methods_supervisor = sum(is_open_methods))

dat <- bind_rows(dat_candidate, dat_supervisor)

dat <- dat %>%
  ungroup() %>%
  group_by(pair) %>%
  fill(
    n_pubs_candidate,
    n_pubs_open_access_candidate,
    n_pubs_open_data_candidate,
    n_pubs_open_methods_candidate,
    n_pubs_supervisor,
    n_pubs_open_access_supervisor,
    n_pubs_open_data_supervisor,
    n_pubs_open_methods_supervisor,
    .direction = 'downup'
  ) %>%
  slice_head() %>%
  mutate(
    open_access_candidate = n_pubs_open_access_candidate/n_pubs_candidate,
    open_access_supervisor = n_pubs_open_access_supervisor/n_pubs_supervisor,
    open_data_candidate = n_pubs_open_data_candidate/n_pubs_candidate,
    open_data_supervisor = n_pubs_open_data_supervisor/n_pubs_supervisor,
    open_methods_candidate = n_pubs_open_methods_candidate/n_pubs_candidate,
    open_methods_supervisor = n_pubs_open_methods_supervisor/n_pubs_supervisor
  )

## (Pearson) correlaton - Open Access
cor(dat$open_access_candidate, dat$open_access_supervisor, method = 'pearson')
## (Spearman) correlaton - Open Access
cor(dat$open_access_candidate, dat$open_access_supervisor, method = 'spearman')
## visual inspect
plot(dat$open_access_candidate, dat$open_access_supervisor)

## (Pearson) correlaton - open data
cor(dat$open_data_candidate, dat$open_data_supervisor, method = 'pearson')
## (Spearman) correlaton - open data
cor(dat$open_data_candidate, dat$open_data_supervisor, method = 'spearman')
## visual inspect
plot(dat$open_data_candidate, dat$open_data_supervisor)

## (Pearson) correlaton - open methods
cor(dat$open_methods_candidate, dat$open_methods_supervisor, method = 'pearson', use = 'pairwise.complete.obs')
## (Spearman) correlaton - open methods
cor(dat$open_methods_candidate, dat$open_methods_supervisor, method = 'spearman', use = 'pairwise.complete.obs')
## visual inspect
plot(dat$open_methods_candidate, dat$open_methods_supervisor)
