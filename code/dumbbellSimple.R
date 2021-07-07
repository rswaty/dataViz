#### simple dumbbell ###


library(readr)
library(tidyverse)
library(scales)
library(ggplot2) 
library(ggalt)   


dumbbell <- read_csv("data/dumbbell.csv")



ggplot(dumbbell, aes(x=currentAverageAcres, xend=historic_acres_burned, y=state)) + 
  #create a thick line between x and xend instead of using defaut 
  #provided by geom_dubbell
  geom_segment(aes(x=currentAverageAcres, 
                   xend=historic_acres_burned, 
                   y=state, 
                   yend=state), 
               color="#b2b2b2", size=1.5)+
  geom_dumbbell(color="light blue", 
                size_x=4.0, 
                size_xend = 4.0,
                colour_x="#edae52", 
                colour_xend = "#9fb059")+
  labs(x=NULL, y=NULL) +
  theme_bw(base_size = 14) +
  scale_x_continuous(label=comma)
