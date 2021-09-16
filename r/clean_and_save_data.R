"
Original cleaning by Abigail Freed

2021-09-10: Create function read_1_xlsx(); move functions to separate .R script
"

library(readxl)
library(tidyverse)
library(reshape2)
library(scales)

source(here::here("read_trailblazers_xlsx_file.R"))  # define function read_1_xlsx() for reading in and parsing trailblazers data files

file_name <- "Projections_2018-28_PRIME_2021-05-20.xlsx"

nonduplicated <- read_1_xlsx(path=file_name, sheet = "Nonduplicated")

#############################

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

nonduplicated <- nonduplicated %>% mutate(pathway = str_replace_all(pathway,"Transportation Systems/Infrastructure Planning, Management, and Regulation", "Transportation Systems Management"))

nonduplicated <- nonduplicated %>% mutate(pathway_for_labels_change = paste(pathway,"\n", "(", trimws(format(round(fraction_change*100, digits = 1), nsmall = 1)), "%", ")", sep = ""))

#Saving the cleaned output so that the data cleaning doesn't have to be redone for this dataset
write.csv(nonduplicated, 'Projections_2018_28_cleaned.csv')
