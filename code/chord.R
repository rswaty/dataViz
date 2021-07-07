

############## chord diagram ##############


library(chorddiag)
library(igraph)
library(readr)
library(tidygraph)
library(htmlwidgets)
# saveWidget(p, file=paste0( getwd(), "/HtmlWidget/chord_interactive.html"))


# read in data
histFireGVchord <- read_csv("data/histFireGVchord.csv")
#view(histFireGVchord)

#convert to matrix
histFireGVchordMatrix<-as.matrix(as_adjacency_matrix(as_tbl_graph(histFireGVchord),attr = "acres"))

#clean up matrix (could be cleaner!)
histFireGVchordMatrix = subset(histFireGVchordMatrix, select = -c(1:7))

histFireGVchordMatrix2 <- histFireGVchordMatrix[-c(8:10),]

#make a custom color pallet

# ORIGINAL
# groupColors <-c( "#e6e0be", # grassland OK
#                  "#56bf5f", # hardwood OK
#                  "#1d4220", # conifer OK
#                  "#7db7c7", # riparian OK
#                  "#397d3f", # hardwood-conifer OK
#                  "#917e5c", # shrub
#                  "#5e513a", # savana
#                  "#fed98e", # surface
#                  "#fe9929", # mixed
#                  "#cc4c02") 

#MODIFIED
groupColors <-c( "#b8e3b9", # grassland OK
                 "#b8e3b9", # hardwood OK
                 "#b8e3b9", # conifer OK
                 "#b8e3b9", # riparian OK
                 "#b8e3b9", # hardwood-conifer OK
                 "#b8e3b9", # shrub
                 "#b8e3b9", # savana
                 "#e8ede9", # surface
                 "#bfbfbf", # mixed
                 "#aba9a9") 






#make chord diagram
chord<-chorddiag(data = histFireGVchordMatrix2,
                 type = "bipartite",
                 groupColors = groupColors,
                 groupnamePadding = 10,
                 groupPadding = 3,
                 groupnameFontsize = 11 ,
                 showTicks = FALSE,
                 margin=80,
                 tooltipGroupConnector = "    &#x25B6;    ",
                 chordedgeColor = "#B3B6B7"
)
chord   


saveWidget(chord, "./charts/chord_interactive.html")
