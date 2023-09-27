


# Make and do some simple data wrangling and customization of a bar chart
#------------------------------------------------------------------------

# ----------------
# Video demo at https://www.loom.com/share/50d640b4699b40f38e323b3930c19716?sid=bc090418-5bc7-4299-a317-74c238f055f2
# ----------------

# ----------------
# Load packages
# ----------------

library(tidyverse)

# ----------------
# Wrangle data
# ----------------

# Read the CSV file "bps_aoi_attributes.csv" into the variable 'bps_df' (bps = LANDFIRE Biophysical Settings)
bps_df <- read.csv(file = "horizontal_bar/bps_aoi_attributes.csv") %>%
  # Group the data by the 'BPS_NAME' column
  group_by(BPS_NAME) %>%
  # Summarize the grouped data by calculating the sum of 'acres', 'hectare', and 'rel_percent' columns (you might not need all of this!)
  summarize(acres = sum(acres),
            hectare = sum(hectare),
            rel_percent = sum(rel_percent)) %>%
  # Arrange the summarized data in descending order based on the 'rel_percent' column
  arrange(desc(rel_percent)) %>%
  # Select the top 10 rows based on the 'rel_percent' column
  top_n(n = 10, wt = rel_percent)

# ----------------
# Make the plot
# ----------------

# Create a ggplot object 'bps_chart' using the 'bps_df' data frame and specify aesthetics
bps_chart <- 
  ggplot(data = bps_df, aes(x = BPS_NAME, y = rel_percent)) +
  
  # Create a bar chart using geom_bar with the identity statistic
  geom_bar(stat = "identity") +
  
  # Set the chart labels and captions
  labs(
    title = "Top 10 Biophysical Settings for Deer Creek Landscape",
    subtitle = "Represents dominant vegetation systems pre-European colonization",
    caption = "Represents ~95% of the landscape. \nData from landfire.gov.",
    x = "",
    y = "Percent of landscape") +
  
  # Customize the x-axis by reversing the order of categories
  scale_x_discrete(limits = rev(bps_df$BPS_NAME)) +
  
  # Flip the coordinates to create a horizontal bar chart
  coord_flip() +
  
  # Use a white and black theme for the chart
  theme_bw()

# Display the 'bps_chart'
bps_chart


# ----------------
# Save chart
# ----------------
ggsave("horizontal_bar/horizontal_bar.png", width = 12, height = 5)

