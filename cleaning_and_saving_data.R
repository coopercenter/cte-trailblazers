"
Original cleaning by Abigail Freed

"

library(readxl)
library(tidyverse)
library(reshape2)
library(scales)

file_name <- "Projections_2018-28_PRIME_2021-05-20.xlsx"

nonduplicated <- read_xlsx(path=file_name, 
                           sheet = "Nonduplicated",
                           col_types = c(rep("text", 13), rep("numeric",8)), na = ".")

fix_names <- function(x){
  x <- str_replace_all(string = x, pattern = "[ -]", replacement = "_")
  x <- str_to_lower(x)
  x <- str_remove_all(x, pattern = "2018_")
  x <- str_remove_all(x, pattern = "2028_")
  x <- str_remove_all(x, pattern = "28_")
  
  return(x)
}

nonduplicated <- nonduplicated %>%
  rename_with(.fn = fix_names) %>% 
  rename(fraction_change = percent_change) %>%
  rename(fraction_change_us = percent_change_us)

my_colors <- c("#00264D","#405C7A", "#8C9DAF","#CCD4DB")
#c("#003366", "#335C85", "#6685A3", "#99ADC2") 
#c("#003366", "#2E5882", "#7490AC", "#C4D0DC")
names(my_colors) <- levels(nonduplicated$predominant_education_level)

nonduplicated <- nonduplicated %>% mutate(pathway_for_labels = str_replace_all(pathway,"Transportation Systems/Infrastructure Planning, Management, and Regulation", "Transportation Systems Management"))

nonduplicated <- nonduplicated %>% mutate(pathway_for_labels = str_replace_all(pathway, "Tele", "Tele-\n"))

nonduplicated <- nonduplicated %>% mutate(pathway_for_labels = str_replace_all(pathway, " ", "\n"))

nonduplicated <- nonduplicated %>% mutate(pathway_for_labels = str_replace_all(pathway_for_labels, "/", "/\n"))

nonduplicated <- nonduplicated %>% mutate(predominant_education_level = str_replace_all(predominant_education_level, "HS Diploma", "High School Diploma"))

nonduplicated$predominant_education_level <- factor(nonduplicated$predominant_education_level,levels = c("Graduate / Professional Degree", "Bachelor's Degree", "Some College / Associate Degree", "High School Diploma"))

#found a typo in the original data
nonduplicated$cluster <- replace(nonduplicated$cluster, nonduplicated$cluster=="Government and Public Adminstration", "Government and Public Administration")
#Saving the cleaned output so that the data cleaning doesn't have to be redone for this dataset
write.csv(nonduplicated, 'Projections_2018_28_cleaned.csv')
