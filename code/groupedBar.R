## grouped bar

## load libraries and set theme

pacman::p_load(tidyverse, ggsci, ggtext, readr, dplyr, DT, crosstalk, plotly)


## read data
bps_scls3 <- read_csv("data/bps_scls3.csv")
View(bps_scls3)

## pivot data longer
bps_scls3 <- bps_scls3 %>%
  pivot_longer(
    cols = c(`Reference`, `Current`), 
    names_to = "refCur", 
    values_to = "Percent"
    )
## order sclasses, then reverse 'cause I messed up (but maybe this will help someone later)
bps_scls3$Sclass <- factor(bps_scls3$Sclass, levels = c(
  "Regeneration", 
  "Mid-development, open canopy", 
  "Mid-development, closed canopy", 
  "Late-development, open canopy", 
  "Late-development, closed canopy", 
  "Late-development, closed canopy, tallest",
  "UE", 
  "UN", 
  "Agriculture", 
  "Urban"))
# reverse
factor(bps_scls3$Sclass, levels = rev(levels(bps_scls3$Sclass)))

# make chart.  NOTE lines 56 and 57 where I select the BpS to make the chart for.  Make sure to adjust title, etc.
sclasplot <-
  ggplot(bps_scls3, aes(fill=factor(refCur), y=Percent, x=Sclass)) + 
  geom_col(width = 0.8, position = position_dodge()) +
  coord_flip() +
  #facet_grid(. ~BpS) +
  scale_x_discrete(limits = rev(levels(bps_scls3$Sclass))) +
  labs(
    title = "Succession Classes past and present for the Upper Cheat Watershed",
    subtitle = "Appalachian (Hemlock-)Northern Hardwood Forest",
    caption = "Late-development, closed canopy, tallest succession class not present in this BpS. \nData from landfire.gov.",
    x = "",
    y = "Percent")+
  theme_minimal(base_size = 14)+
  theme(plot.caption = element_text(hjust = 0, face= "italic"), #Default is hjust=1
        plot.title.position = "plot", #NEW parameter. Apply for subtitle too.
        plot.caption.position =  "plot") +
  scale_fill_manual(values = c("#3d4740", "#32a852" ), # present (grey), historical (green)
                    name = " ", 
                    labels = c("Present",
                               "Past"))

sclasplotHardwoods <- sclasplot %+% subset(bps_scls3, BpS %in% c("Appalachian (Hemlock-)Northern Hardwood Forest"))

sclasplotHardwoods #may not be able to view here?

ggsave(filename="charts/sclasplotHardwoods.png",width=10,height=8,units='in',dpi=300)



