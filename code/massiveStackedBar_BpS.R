

# order bars - DONE
# order stacks - DONE
# nice colors -DONE
# scales
# plotly

library(plotly)
library(scales)
library(tidyverse)


data <- read.csv("bps_evt_all.csv")

data$BPS_NAME <- factor(data$BPS_NAME, levels = unique(data$BPS_NAME))

data$EVT_PHYS2 <- factor(data$EVT_PHYS2, levels = c(
  "NaturalVeg",
  "Agricultural",
  "Developed",
  "Exotics",
  "OtherClearing"
) )

data$EVT_PHYS2 <- factor(data$EVT_PHYS2, levels = rev(levels(data$EVT_PHYS2)))

plot <-
  ggplot(data, aes(fill = EVT_PHYS2, y = ACRES, x = BPS_NAME)) +
  geom_bar(position = "stack", stat = "identity") +
  coord_flip() +
  labs(
    title = "Conversion status of our 402 ecosystems",
    subtitle = "~62% of America remains as Natural Vegetation, the condition of which is highly degraded for much of the country",
    caption = "Data from landfire.gov.",
    x = "",
    y = "Acres",
    fill = "Status")+
  scale_x_discrete(limits=rev) +
  scale_y_continuous(label=comma) + 
  theme_bw() + 
  scale_fill_manual(values = c("#f5922f", # orange
                               "#532a66", # purple
                               "#827c75", # grey
                               "#f5eb2f", # yellow
                               "#74a36f" # green-natural veg
                               ))+
  theme(plot.caption = element_text(hjust = 0, face= "italic"), #Default is hjust=1
        plot.title.position = "plot", #NEW parameter. Apply for subtitle too.
        plot.caption.position =  "plot") 

plot

plotly <- ggplotly(plot, height = 5200)
plotly
