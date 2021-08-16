library(tidyverse)
library(reshape2)
library(scales)
library(GGally)

#nonduplicated <- read.csv(here::here('Projections_2018_28_cleaned.csv'))

generate_cluster_graph_2 <-function(df, clusterx){
  
  my_colors2 <- c("darkgrey", "#405C7A")
  jobs_labels <- c("2018 Estimate", "2028 Projection")
  text_size <- 3
  text_width <- 0.8
  text_vertical <- 0
  text_height <- -0.05
  
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
  
  expand_limit <- 0
  if(clusterx=="Business Management and Administration"){
    expand_limit <- max(linked_pathway$value) + min(linked_pathway$value)
  } else if(clusterx=="Human Services"){
    expand_limit <- max(linked_pathway$value)+18000
  } else if(clusterx == "Information Technology"){
    expand_limit <- max(linked_pathway$value)+20000
  } else if(clusterx=="Government and Public Administration"){
    expand_limit <- max(linked_pathway$value)+2050
  } else if(clusterx=="Transportation, Distribution, and Logistics"){
    expand_limit <- 149000
  } else if(clusterx=="Energy"){
    expand_limit <- max(linked_pathway$value)+min(linked_pathway$value)
  } else if(clusterx=="Health Science"){
    expand_limit <- 320000
  }else if(clusterx=="Law, Public Safety, Corrections, and Security"){
    expand_limit <- 62800
    } else if(clusterx=="Marketing"){
      expand_limit <- 627780
    } else if(clusterx=="Science, Technology, Engineering, and Mathematics"){
      expand_limit <- 62900
    }else {
    expand_limit <- max(linked_pathway$value)
  }
  
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
    expand_limits(x = expand_limit)
  
  return(graph_2)
}
#generate_cluster_graph_2(nonduplicated,"Energy")
#generate_cluster_graph_2(nonduplicated,"Business Management and Administration")




