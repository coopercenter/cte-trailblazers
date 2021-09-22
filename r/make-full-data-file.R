# File make-full-data-file.R
#
# Script to read in statewide and regional data files from CTE Trailblazers, parse, and merge to create complete data set
#   including data for all regions, clusters, and pathways.
#
# Author: Arthur Small
# Date: Sept, 2021

library(dplyr)
library(stringr)

source(here::here("r", "read_1_trailblazers_xlsx_file.R"))  # define function read_1_xlsx() for reading in and parsing trailblazers data files

regional_data_dir   <- here::here("data_raw","Regional")
statewide_data_file <- here::here("data_raw","Projections_2018-28_PRIME_2021-05-20.xlsx")

fs::dir_ls(regional_data_dir, recurse = FALSE)  %>%
  str_subset(pattern = ".xlsx") %>% 
  append(statewide_data_file) %>% 
  purrr::map_dfr(read_1_xlsx, sheet = "Nonduplicated") -> all_nonduplicated_tbl

# Save combined, cleaned file
saveRDS(all_nonduplicated_tbl, here::here("data_prep","nonduplicated-all-regions-and-pathways.Rds"))
readr::write_csv(all_nonduplicated_tbl, here::here("data_prep","nonduplicated-all-regions-and-pathways.csv"))
writexl::write_xlsx(all_nonduplicated_tbl, path = here::here("data_prep","nonduplicated-all-regions-and-pathways.xlsx"))
