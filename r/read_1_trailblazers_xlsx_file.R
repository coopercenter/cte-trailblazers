# File read_trailblazers_xlsx_file.R
#
# Script for reading in and parsing a single .xlsx file in CTE Trailblazers format
#
# Authors: Abigail Freed, Arthur Small
# June-Sept, 2021

extract_year <- function(column_names,key_word){
  # Extract the year value from a column header containing a distinctive key word
  # E.g., "2018 Estimate" + "Estimate" -> 2018
  #
  require(stringr)
  
  return(as.integer(word(column_names[which(str_detect(column_names, key_word))])))
}


fix_column_names <- function(column_names, start_year = "2018", end_year = "2028"){
  require(stringr)
  
  column_names %>%
    str_replace_all(., pattern = "[ -]", replacement = "_") %>%
    str_to_lower(.) %>%
    str_remove_all(., pattern = paste0(start_year,"_")) %>%
    str_remove_all(., pattern = paste0(end_year,"_"))   %>%
    str_remove_all(., pattern = paste0(str_trunc(end_year, 2, "right", ellipsis = ""),"_")) -> fixed_names

  # column_names <- str_replace_all(string = column_names, pattern = "[ -]", replacement = "_")
  # column_names <- str_to_lower(column_names)
  # column_names <- str_remove_all(column_names, pattern = paste0(start_year,"_"))
  # column_names <- str_remove_all(column_names, pattern = paste0(end_year,"_"))
  # column_names <- str_remove_all(column_names, pattern = paste0(str_trunc(end_year, 2, "right", ellipsis = ""),"_"))
  
  return(fixed_names)
}


split_LWDA_text <- function(area_char_vec){
  # Split the LWDA "area" text field into three pieces: name, type, area code
  require(stringr)
  
  split1 <- str_split(area_char_vec, fixed(" ("), simplify = TRUE)
  if(ncol(split1) > 1){
    split2 <- str_remove(split1[,2],   fixed(")"))
    split3 <- str_split(split2, " ", simplify = TRUE)
    return_mat <- cbind(split1[,1], split3)
  } else {
    return_mat <- cbind(split1,NA,NA)
  }
  
  return(return_mat)
}


read_1_xlsx <- function(path2file, sheet = "Nonduplicated"){
  require(dplyr)
  require(readxl)
  
  read_xlsx(path2file,
            sheet = sheet,
            col_types = c(rep("text", 13), rep("numeric",8)), na = ".") -> tbl
  
  column_names <- colnames(tbl)
  
  tbl %>%
    rename_with(.fn = fix_column_names) %>%
    mutate(region      = split_LWDA_text(area)[,1]) %>%
    mutate(lwda_code   = split_LWDA_text(area)[,3]) %>% 
    rename(num_jobs_estimate    = estimate,
           num_jobs_projected   = projection,
           num_jobs_projected_change = '28_change',             ############ ALERT! NEED TO GENERALIZE YEAR! ##################
           fraction_change_jobs = percent_change,
           fraction_change_us   = percent_change_us,
           nontrad_status       = '20nontrad_status') %>%       ############ ALERT! NEED TO GENERALIZE YEAR! ##################
    # mutate(cluster = str_replace(cluster, "Adminstration", "Administration")) %>%
    mutate(jobs_estimate_year   = extract_year(column_names, "Estimate"),
           income_year          = extract_year(column_names, "Median Income"),
           jobs_projection_year = extract_year(column_names, "Projection"),
           nontrad_year         = extract_year(column_names, "Nontrad"))  %>% 
    select(area, area_code, region, lwda_code,
           cluster_code, cluster, pathway_code, pathway, soc_code, soc_title,
           jobs_estimate_year, num_jobs_estimate, annual_openings, income_year, mean_income, median_income,
           jobs_projection_year, num_jobs_projected, num_jobs_projected_change, fraction_change_jobs, fraction_change_us,
           predominant_occ_prep_combo, predominant_education_level, training, work_experience,
           nontrad_year, nontrad_status) -> tbl
  
  return(tbl)
}

