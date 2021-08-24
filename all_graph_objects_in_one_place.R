#All graphs as objects
nonduplicated <- read.csv(here::here('Projections_2018_28_cleaned.csv'))
source(here::here('generating_1st_cluster_graphs.R'))
source(here::here('generating_2nd_cluster_graphs.R'))
source(here::here('generating_3rd_cluster_graphs.R'))
#"Agriculture, Food, and Natural Resources"
Ag_graph_1 <- generate_cluster_graph_1(nonduplicated,"Agriculture, Food, and Natural Resources")
Ag_graph_2 <- generate_cluster_graph_2(nonduplicated,"Agriculture, Food, and Natural Resources")
Ag_graph_3 <- generate_cluster_graph_3(nonduplicated,"Agriculture, Food, and Natural Resources")

#"Architecture and Construction"
Arc_graph_1 <- generate_cluster_graph_1(nonduplicated,"Architecture and Construction")
Arc_graph_2 <- generate_cluster_graph_2(nonduplicated,"Architecture and Construction")
Arc_graph_3 <- generate_cluster_graph_3(nonduplicated,"Architecture and Construction")

#"Arts, Audio/Video Technology, and Communications"
Arts_graph_1 <- generate_cluster_graph_1(nonduplicated,"Arts, Audio/Video Technology, and Communications")
Arts_graph_2 <- generate_cluster_graph_2(nonduplicated,"Arts, Audio/Video Technology, and Communications")
Arts_graph_3 <- generate_cluster_graph_3(nonduplicated,"Arts, Audio/Video Technology, and Communications")

#"Business Management and Administration"
Bus_graph_1 <- generate_cluster_graph_1(nonduplicated,"Business Management and Administration")
Bus_graph_2 <- generate_cluster_graph_2(nonduplicated,"Business Management and Administration")
Bus_graph_3 <- generate_cluster_graph_3(nonduplicated,"Business Management and Administration")

#"Education and Training"
Edu_graph_1 <- generate_cluster_graph_1(nonduplicated,"Education and Training")
Edu_graph_2 <- generate_cluster_graph_2(nonduplicated,"Education and Training")
Edu_graph_3 <- generate_cluster_graph_3(nonduplicated,"Education and Training")

#"Finance"
Fin_graph_1 <- generate_cluster_graph_1(nonduplicated,"Finance")
Fin_graph_2 <- generate_cluster_graph_2(nonduplicated,"Finance")
Fin_graph_3 <- generate_cluster_graph_3(nonduplicated,"Finance")

#"Government and Public Administration"
Gov__graph_1 <- generate_cluster_graph_1(nonduplicated,"Government and Public Administration")
Gov__graph_2 <- generate_cluster_graph_2(nonduplicated,"Government and Public Administration")
Gov__graph_3 <- generate_cluster_graph_3(nonduplicated,"Government and Public Administration")

#"Health Science" 
Health_graph_1 <- generate_cluster_graph_1(nonduplicated,"Health Science")
Health_graph_2 <- generate_cluster_graph_2(nonduplicated,"Health Science")
Health_graph_3 <- generate_cluster_graph_3(nonduplicated,"Health Science")

#"Hospitality and Tourism"
Tour_graph_1 <- generate_cluster_graph_1(nonduplicated,"Hospitality and Tourism")
Tour_graph_2 <- generate_cluster_graph_2(nonduplicated,"Hospitality and Tourism")
Tour_graph_3 <- generate_cluster_graph_3(nonduplicated,"Hospitality and Tourism")

#"Human Services"
Hum_graph_1 <- generate_cluster_graph_1(nonduplicated,"Human Services")
Hum_graph_2 <- generate_cluster_graph_2(nonduplicated,"Human Services")
Hum_graph_3 <- generate_cluster_graph_3(nonduplicated,"Human Services")

#"Information Technology"
IT_graph_1 <- generate_cluster_graph_1(nonduplicated,"Information Technology")
IT_graph_2 <- generate_cluster_graph_2(nonduplicated,"Information Technology")
IT_graph_3 <- generate_cluster_graph_3(nonduplicated,"Information Technology")

#Law, Public Safety, Corrections, and Security"
Law_graph_1 <- generate_cluster_graph_1(nonduplicated,"Law, Public Safety, Corrections, and Security")
Law_graph_2 <- generate_cluster_graph_2(nonduplicated,"Law, Public Safety, Corrections, and Security")
Law_graph_3 <- generate_cluster_graph_3(nonduplicated,"Law, Public Safety, Corrections, and Security")

#"Manufacturing"
Manuf_graph_1 <- generate_cluster_graph_1(nonduplicated,"Manufacturing")
Manuf_graph_2 <- generate_cluster_graph_2(nonduplicated,"Manufacturing")
Manuf_graph_3 <- generate_cluster_graph_3(nonduplicated,"Manufacturing")

#"Marketing"
Mark_graph_1 <- generate_cluster_graph_1(nonduplicated,"Marketing")
Mark_graph_2 <- generate_cluster_graph_2(nonduplicated,"Marketing")
Mark_graph_3 <- generate_cluster_graph_3(nonduplicated,"Marketing")

#"Science, Technology, Engineering, and Mathematics"
Sci_graph_1 <- generate_cluster_graph_1(nonduplicated,"Science, Technology, Engineering, and Mathematics")
Sci_graph_2 <- generate_cluster_graph_2(nonduplicated,"Science, Technology, Engineering, and Mathematics")
Sci_graph_3 <- generate_cluster_graph_3(nonduplicated,"Science, Technology, Engineering, and Mathematics")

#"Transportation, Distribution, and Logistics"
Transp_graph_1 <- generate_cluster_graph_1(nonduplicated,"Transportation, Distribution, and Logistics")
Transp_graph_2 <- generate_cluster_graph_2(nonduplicated,"Transportation, Distribution, and Logistics")
Transp_graph_3 <- generate_cluster_graph_3(nonduplicated,"Transportation, Distribution, and Logistics")

#"Energy"
Energy_graph_1 <- generate_cluster_graph_1(nonduplicated,"Energy")
Energy_graph_2 <- generate_cluster_graph_2(nonduplicated,"Energy")
Energy_graph_3 <- generate_cluster_graph_3(nonduplicated,"Energy")