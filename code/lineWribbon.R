

## line with ribbons

library(tidyverse)

df <- read_csv("data/lineWribbon.csv")
View(lineWribbon)


chart <-
  ggplot(df, aes(x =year, y= mean))+
  geom_line(col = 1.5, size = 2) +
  geom_ribbon(aes(ymin = min, ymax = max), alpha = 0.2) +
  geom_hline(data=df,aes(yintercept=hmean), size = 1.5) + 
  annotate("rect", xmin=1985, xmax=2019, ymin=4, ymax=11, alpha=0.2, fill="grey") +
  theme_bw() +
  labs(
    title = "Stand-replacing fires, past and present",
    subtitle = "Top line is current with min-max ribbon, bottom line is historical mean with rectangle representing min and max",
    caption = "Current data fictional!", 
    x = "Year",
    y = "Percent")

chart
