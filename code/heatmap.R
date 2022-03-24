

# try heat map for cove forests


# libraries
pacman::p_load(tidyverse,  RColorBrewer,  scales)

# cove forest data from Upper Cheat watershed in WV
coveHeat <- read_csv("./data/coveHeat.csv")
View(coveHeat)

coveHeatChart <- ggplot(coveHeat,aes(x=evc, y=evh, fill = percent)) +
  geom_tile(colour="white",size=0.2) +
  guides(fill=guide_legend(title="Percent of BpS \nper particular \ncombination")) +
  scale_x_discrete(labels = function(x) paste0(x, "%")) +
  coord_cartesian(ylim=c(0, 30)) +
  labs(x="Canopy Cover",
       y="Canopy Height (meters)",
       title="Canopy cover and height combinations",
       subtitle = "Southern Appalachian Cove Forest-Upper Cheat Watershed",
       caption = "~80% of this forest type has canopy cover between 70-90%, and heights ranging from 21-28 meters.  \nData from landfire.gov") +
  scale_fill_distiller(palette = "Greens", trans = "reverse") +
  theme_bw(base_size=14) 



coveHeatChart

ggsave(filename="./charts/coveHeatChart.png",width=10,height=8,units='in',dpi=300)
