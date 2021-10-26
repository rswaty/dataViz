

###  ridgeline chart
pacman::p_load(tidyverse, ggridges)

### load data
lt_vdep <- read_csv("data/lt_vdep.csv")
View(lt_vdep)

### format data
repeats <- lt_vdep[rep(seq(nrow(lt_vdep)), lt_vdep$Percent),]


### make chart
repeats$GP <- factor(repeats$GP,
                     levels = c(
                       "Calcareous",
                       "Silt/clay",
                       "Acidic Loam",
                       "Loam",
                       "Moderately calcareous",
                       "Moderately Calcareous Sedimentary",
                       "Acidic Granitic",
                       "Acidic sedimentary",
                       "Ultramafic",
                       "Calcareous Loam",
                       "Silt/clay over limestone",
                       "Sand",
                       "Deep Loess",
                       "Calcareous Sedimentary",
                       "Mafic/Intermediate Granitic",
                       "Loam over limestone",
                       "Clay/Silt"),
                     ordered = TRUE)



ggplot(repeats, aes(x = VDEP, y = as.factor(GP), fill = stat(x))) +
  geom_density_ridges_gradient(aes(fill = ..x..), scale = 0.9, size = 0.5) +
  scale_fill_gradientn(colours = c("#599440", "#FFFFFF", "#FF0000")) +
  theme_ridges() + 
  theme(legend.position = "none") +
  labs(
    title = "Smoothed Vegetation Departure per Geophysical Setting (Ag and Urban areas removed)",
    subtitle = "Used grouped Geophysical Settings; Geophysical settings with lowest average VDEP on top",
    caption = "Data from TNC's Center for Resilient Conservation Science",
    x = "Vegetation Departure (0 = low, 100 = high)",
    y = "Geophysical Setting" ) 


ggsave(filename="charts/ridgeline.png",width=10,height=8,units='in',dpi=300)
