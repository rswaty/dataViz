

################# sankey diagram ##################

# load libraries

library(networkD3)
library(dplyr)
library(readr)



# read in snkyPdata
snkyPdata <- read_csv("data/bps2evt2.csv")

# define nodes
nodes <- data.frame(
         name=c(as.character(snkyPdata$source), 
         as.character(snkyPdata$target)) %>% 
          unique())

# add source and target fields
snkyPdata$IDsource <- match(snkyPdata$source, nodes$name)-1 
snkyPdata$IDtarget <- match(snkyPdata$target, nodes$name)-1

# Make the Network
snkyP2 <- sankeyNetwork(Links = snkyPdata, 
                       Nodes = nodes,
                       Source = "IDsource", 
                       Target = "IDtarget",
                       Value = "value", 
                       NodeID = "name", 
                       width = 1500,
                       height = 600, 
                       fontSize=22,
                       iterations = 0,
                       sinksRight=FALSE,
                       margin = 1)

snkyP2


saveNetwork(snkyP2, "sankeyP2.html", selfcontained = TRUE)


