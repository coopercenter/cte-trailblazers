# File read_trailblazers_xlsx_file.R
#
# Script for reading in and parsing a single .xlsx file in CTE Trailblazers format
#
# Authors: Arthur Small, Abigail Freed
# June-Sept, 2021

extract_year <- function(column_names,search_term){
  # Extract the integer year value from a column header containing the year plus a distinctive key word
  # E.g., "2018 Estimate" + "Estimate" -> 2018
  #
  require(stringr)
  
  return(as.integer(word(column_names[which(str_detect(column_names, search_term))])))
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
  # Function to ingest and parse a single trailblazers Excel spreadsheet 
  require(dplyr)
  require(readxl)
  
  read_xlsx(path2file,
            sheet = sheet,
            col_types = c(rep("text", 13), rep("numeric",8)), na = c(".","No data","Confidential")) -> tbl
  
  column_names <- colnames(tbl)
  
  tbl %>%
    mutate(jobs_estimate_year   = extract_year(column_names, "Estimate"),
           income_year          = extract_year(column_names, "Median Income"),
           jobs_projection_year = extract_year(column_names, "Projection"),
           nontrad_year         = extract_year(column_names, "Nontrad"))  %>% 
    rename_with(str_remove_all, pattern = "[0123456789]") %>%       # remove all digit characters, to make column names consistent across data vintages
    rename_with(str_remove, pattern = "- ") %>%
    rename_with(str_trim) %>% 
    rename_with(str_replace_all, pattern = "[ -]", replacement = "_") %>%
    rename_with(str_to_lower) %>%
    mutate(region      = split_LWDA_text(area)[,1]) %>%
    mutate(lwda_code   = split_LWDA_text(area)[,3]) %>% 
    rename(num_jobs_estimate    = estimate,
           num_jobs_projected   = projection,
           num_jobs_projected_change = change,            
           fraction_change_jobs = percent_change,
           fraction_change_us   = percent_change_us) %>%       
    # Fix typos and minor formatting issues in original data
    mutate(cluster = str_replace(cluster, "Adminstration", "Administration")) %>%
    mutate(pathway_code = round(as.numeric(pathway_code),2)) %>%
    mutate(predominant_education_level = str_replace_all(predominant_education_level, "HS Diploma", "High School Diploma")) %>%
    # Change data types as appropriate
    mutate(across(c(area, area_code, region, lwda_code,cluster_code, cluster, pathway_code, pathway), as.factor)) %>%
    mutate(across(c(num_jobs_estimate,annual_openings, num_jobs_projected, num_jobs_projected_change), as.integer)) %>%
    mutate(across(c(predominant_education_level, training, work_experience, predominant_occ_prep_combo,nontrad_status), as.factor)) %>%
    # Order columns into groups by theme: geography, occupational category, estimated current values, projected future values, required training, nontraditional status
    select(area, area_code, region, lwda_code,
           cluster_code, cluster, pathway_code, pathway, soc_code, soc_title,
           jobs_estimate_year, num_jobs_estimate, annual_openings, income_year, mean_income, median_income,
           jobs_projection_year, num_jobs_projected, num_jobs_projected_change, fraction_change_jobs, fraction_change_us,
           predominant_education_level, training, work_experience, predominant_occ_prep_combo,
           nontrad_year, nontrad_status) -> tbl
  
  return(tbl)
}

