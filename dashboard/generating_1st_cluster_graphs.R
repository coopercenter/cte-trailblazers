library(tidyverse)
library(reshape2)
library(scales)
library(GGally)

#set this piece aside for now, I may not need it
#cluster_list <- unique(nonduplicated$cluster, fromLast = TRUE) 
#cluster_list <- cluster_list[-1]

#nonduplicated <- read.csv(here::here('Projections_2018_28_cleaned.csv'))

generate_cluster_graph_1 <- function(df, clusterx){
  my_colors <- c("#00264D","#405C7A", "#8C9DAF","#CCD4DB")
  
  edu_graph <- df %>% filter(cluster == clusterx, 
                                        !is.na(predominant_education_level)) %>% 
    ggplot(aes(pathway_for_labels, fill = predominant_education_level)) + 
    geom_bar(position = "fill") + 
    theme(panel.grid = element_blank(),
          axis.title = element_blank(),
          legend.title = element_blank(),
          legend.text = element_text(color = "black"),
          axis.text.x = element_text(color = "black"), 
          axis.text.y = element_text(color = "black"), 
          panel.background = element_blank(), 
          axis.line.x = element_line(color = "grey"), 
          axis.line.y = element_line(color = "grey")) + 
    scale_y_continuous(expand = expansion(mult = c(0, .1)), labels = scales::percent_format(accuracy = 1), breaks = seq(0,1, 0.1)) +
    scale_fill_manual(values = my_colors) +
    scale_color_manual(values = my_colors)
  #ggsave(here::here("images", paste0(strtrim(x,3),"-fig1.png")), height = 2.5, width = 7.5, units = c("in"))
  return(edu_graph)
}
