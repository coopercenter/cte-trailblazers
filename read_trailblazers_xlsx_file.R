# File read_trailblazers_xlsx_file.R
#
# Script for reading in and parsing a single .xlsx file in CTE Trailblazers format
#
# Authors: Abigail Freed, Arthur Small
# Sept., 2021

fix_names <- function(column_names, start_year = "2018", end_year = "2028"){
  require(stringr)
  
  column_names <- str_replace_all(string = column_names, pattern = "[ -]", replacement = "_")
  column_names <- str_to_lower(column_names)
  column_names <- str_remove_all(column_names, pattern = paste0(start_year,"_"))
  column_names <- str_remove_all(column_names, pattern = paste0(end_year,"_"))
  column_names <- str_remove_all(column_names, pattern = paste0(str_trunc(end_year, 2, "right", ellipsis = ""),"_"))
  
  return(column_names)
}

read_1_xlsx <- function(path2file, sheet = "Nonduplicated"){
  require(dplyr)
  require(readxl)
  
  read_xlsx(path2file,
            sheet = sheet,
            col_types = c(rep("text", 13), rep("numeric",8)), na = ".") %>%
    rename_with(.fn = fix_names) %>% 
    rename(fraction_change    = percent_change,
           fraction_change_us = percent_change_us) -> tbl
  
  return(tbl)
}

