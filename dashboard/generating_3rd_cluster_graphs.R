library(tidyverse)
library(reshape2)
library(scales)
library(GGally)

generate_cluster_graph_3 <- function(df,clusterx){
  my_colors3 <- c("#1170aa", "#fc7d0d", "#003366", "#5fa2ce", "#c85200", "#a3cce9", "#ffbc79")
  
    income_graph2 <- df %>% filter(cluster == clusterx, !is.na(pathway), !is.na(median_income)) %>% 
      ggplot(aes(median_income, pathway, color = pathway)) + 
      geom_point(size = 3) + 
      scale_color_manual(values = my_colors3) + 
      scale_x_continuous(labels = scales::dollar_format()) + 
      xlab("Median Income of Occupation") + 
      ylab("Pathway") +
      theme(axis.text.x = element_text(color = "black"), 
            axis.text.y = element_text(color = "black"),
            panel.background = element_blank(),
            axis.line = element_line(color = "grey"),
            panel.grid.major.y = element_line(color = "lightgrey"),
            panel.grid.major.x = element_line(color = "lightgrey"),
            axis.title.y = element_blank()) +
      scale_size_area(max_size = 6) +
      guides(color = FALSE) + labs(size ="Annual Openings") 
    
    return(income_graph2)
}