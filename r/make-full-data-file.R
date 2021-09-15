# File make-full-data-file.R
#
# Script to read in statewide and regional data files from CTE Trailblazers, parse, and merge to create complete data set
#   including data for all regions, clusters, and pathways.
#
# Author: Arthur Small
# Date: Sept, 2021

library(dplyr)
library(stringr)

source(here::here("r", "read_trailblazers_xlsx_file.R"))  # define function read_1_xlsx() for reading in and parsing trailblazers data files

regional_data_dir   <- here::here("data_raw","Regional")
statewide_data_file <- here::here("data_raw","Projections_2018-28_PRIME_2021-05-20.xlsx")

fs::dir_ls(regional_data_dir, recurse = FALSE)  %>%
  str_subset(pattern = ".xlsx") %>% 
  append(statewide_data_file) %>% 
  purrr::map_dfr(read_1_xlsx) -> all_data_tbl

# Save combined, cleaned file
save(all_data_tbl, here::here("data_prep","all-regions-and-pathways.Rds"))
readr::write_csv(all_data_tbl, here::here("data_prep","all-regions-and-pathways.csv"))