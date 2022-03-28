library(tidyverse)

dat <- read_csv('data/pilot_data_processed.csv')

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
dat <- dat %>%
  mutate(
    is_registration = if_else(
      is_TRN == TRUE | type_of_open_methods_trial_registration_number == '1',
      TRUE,
      FALSE,
      missing = FALSE
    )
  )
summary(dat$is_registration)
dat %>%
  filter(owner == 'supervisor' & is_registration == TRUE) %>%
  nrow()
dat %>%
  filter(owner == 'candidate' & is_registration == TRUE) %>%
  nrow()

## descriptive stats - preregistration
summary(as.logical(dat$type_of_open_methods_preregistration))
dat %>%
  filter(owner == 'supervisor' & as.logical(type_of_open_methods_preregistration) == TRUE) %>%
  nrow()
dat %>%
  filter(owner == 'candidate' & as.logical(type_of_open_methods_preregistration) == TRUE) %>%
  nrow()

## descriptive stats - protocol
summary(as.logical(dat$type_of_open_methods_protocol))
dat %>%
  filter(owner == 'supervisor' & as.logical(type_of_open_methods_protocol) == TRUE) %>%
  nrow()
dat %>%
  filter(owner == 'candidate' & as.logical(type_of_open_methods_protocol) == TRUE) %>%
  nrow()

## descriptive stats - open notebook
summary(as.logical(dat$type_of_open_methods_open_notebook))
dat %>%
  filter(owner == 'supervisor' & as.logical(type_of_open_methods_open_notebook) == TRUE) %>%
  nrow()
dat %>%
  filter(owner == 'candidate' & as.logical(type_of_open_methods_open_notebook) == TRUE) %>%
  nrow()

## descriptive stats - open code
dat <- dat %>%
  mutate(
    is_open_code_3 = if_else(
      is_open_code_2 == TRUE | type_of_open_methods_open_code == '1',
      TRUE,
      FALSE,
      missing = FALSE
    )
  )
summary(dat$is_open_code_3)
dat %>%
  filter(owner == 'supervisor' & is_open_code_3 == TRUE) %>%
  nrow()
dat %>%
  filter(owner == 'candidate' & is_open_code_3 == TRUE) %>%
  nrow()


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
