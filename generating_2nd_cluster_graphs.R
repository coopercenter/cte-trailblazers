library(tidyverse)
library(reshape2)
library(scales)
library(GGally)

generate_cluster_graph_2 <-function(df, clusterx){
  
  my_colors2 <- c("darkgrey", "#405C7A")
  jobs_labels <- c("2018 Estimate", "2028 Projection")
  text_size <- 3
  text_width <- 0.8
  text_vertical <- 0
  text_height <- -0.05
  
  
  df <- df %>% mutate(pathway = str_replace_all(pathway,"Transportation Systems/Infrastructure Planning, Management, and Regulation", "Transportation Systems Management"))
  
  df <- df %>% mutate(pathway_for_labels_change = paste(pathway,"\n", "(", trimws(format(round(fraction_change*100, digits = 1), nsmall = 1)), "%", ")", sep = ""))
  
  my_theme <-  theme(legend.title = element_blank(),
                     axis.title.y = element_blank(),
                     panel.grid.minor.y = element_blank(),
                     panel.grid.major.y = element_blank(),
                     axis.text = element_text(color = "black"), 
                     panel.background = element_blank(), 
                     panel.grid.major.x = element_blank(), 
                     panel.grid.minor.x = element_blank(),
                     axis.ticks = element_blank(), 
                     axis.text.x = element_text())
  
  linked_pathway <- df %>%
    filter(!is.na(pathway), is.na(soc_title),cluster == clusterx) %>%
    select(pathway_for_labels_change, estimate, projection)
  linked_pathway <- melt(linked_pathway, id = "pathway_for_labels_change")
  
  graph_2 <- ggplot(linked_pathway, aes(value, pathway_for_labels_change, fill =variable)) +
    geom_bar(stat="identity", position =  position_dodge2(reverse=TRUE)) +
    xlab("Number of Jobs") +
    my_theme +
    scale_fill_manual(values = my_colors2,
                      labels = jobs_labels) +
    scale_x_continuous(labels = c("0", "", "", "", ""), expand = expansion(mult = c(0, .1))) +
    scale_y_discrete(expand = expansion(mult = c(0, .1))) +
    geom_text(aes(label = formatC(value, big.mark = ",", format = "f", drop0trailing = TRUE)), 
              size = text_size, 
              position =  position_dodge2(width = text_width, reverse=TRUE), 
              vjust = text_vertical, 
              hjust = text_height) +
    expand_limits(x = 35000)
  
  return(graph_2)
}

