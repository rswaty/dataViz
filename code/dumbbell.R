

###########  Dumbbell   #######################

## load packages

library(tidyverse)
library(scales)
library(ggplot2) 
library(ggalt)   

# read in data


histCurStates <- read_csv("data/histCurStates.csv")
## ggplot with mean lines

avgCur <- mean(historicalCurrentFire$currentAverageAcres)
avgHist <- mean(historicalCurrentFire$historic_acres_burned)


db <-
  ggplot(historicalCurrentFire, aes(x=currentAverageAcres, xend=historic_acres_burned, y=state)) + 
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
  theme_bw(base_size = 16) +
  scale_x_continuous(label=comma) + 
  geom_vline(xintercept = avgCur) +
  geom_vline(xintercept = avgHist) +
  labs(
    title = "Comparison of historical and current average annual fire amounts",
    subtitle = "Yellow = Current (average of 1999-2014), Green = Historical (pre-European colonization)",
    caption = "\nData from landfire.gov.",
    x = "",
    y = "Acres")

db

