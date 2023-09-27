

# panel chart

library(tidyverse)

lt_now <- read.csv("data/lt_now.csv")


lt_now_clean <- filter(lt_now, Now != "Barren or Sparse" & Now != "Water") %>%
  mutate(GP = fct_relevel(GP,'Loam over limestone','Calcareous Loam','Clay/Silt','Deep Loess','Silt/clay','Loam','Calcareous','Calcareous Sedimentary','Silt/clay over limestone','Moderately calcareous','Moderately Calcareous Sedimentary','Sand','Acidic sedimentary','Acidic Loam','Acidic Granitic','Mafic/Intermediate Granitic','Ultramafic'
  )
  )



ggplot(lt_now_clean, aes(x = GP, y = Percent, fill = Now)) + 
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(
    title = "Current status of Geophysical Settings ",
    subtitle = "Descending order by amount of NaturalVeg",
    caption = "Data from TNC's Center for Resilient Conservation Science and LANDFIRE",
    x = "Geophysical Setting",
    y = "Percentage" ) +
  theme_minimal(base_size = 16) +
  theme(panel.grid = element_blank()) +
  facet_wrap(~ Now, ncol= 3)+ 
  guides(fill = "none") +
  scale_fill_manual(values = c("Agriculture" = "#ded076", "NaturalVeg"= "#8da69e", "Urban" = "#b3b1a6"))