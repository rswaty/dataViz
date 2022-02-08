library(spiralize)
library(lubridate)

covid <- read.csv("data/owid-covid-data.csv", stringsAsFactors = FALSE)
us <- covid[covid$location == "United States" & !is.na(covid$new_cases_smoothed),]
us$dt <- strptime(us$date, format="%Y-%m-%d")
us <- us[us$dt < "2022-01-07",]
ymax <- max(us$new_cases_smoothed)

# Initialize.
spiral_initialize_by_time(xlim=c("2020-01-01 00:00:00", "2022-01-06 00:00:00"), 
                          unit_on_axis = "days", period="years",
                          start=90, end=(709/365)*360+(28/365)*360+90,
                          flip="horizontal")

# Create the track.
spiral_track(ylim=c(0, ymax*.7),
             background=FALSE, background_gp = gpar(col = NA, fill = NA))

# Area-filled line.
# spiral_lines(x=us$dt, y=us$new_cases_smoothed, area=TRUE)

# Use a polygon instead.
spiral_polygon(x=c(us$dt, rev(us$dt)), 
               y=c(us$new_cases_smoothed/2, -rev(us$new_cases_smoothed/2)),
               gp = gpar(col="#d32e2b", fill="#d32e2b50"))

# Middle baseline.
spiral_lines(x=c(us$dt[1] - days(27:1), us$dt), y=0)

# Text.
spiral_text(x="2020-01-01", y=50000, text="2020", 
            facing = "curved_inside", just = "right",
            gp=gpar(cex=1, fontfamily="Courier"))
spiral_text(x="2021-01-01", y=50000, text="2021", 
            facing = "curved_inside", just = "right",
            gp=gpar(cex=1, fontfamily="Courier"))
spiral_text(x="2022-01-01", y=50000, text="2022", 
            facing = "curved_inside", just = "right",
            gp=gpar(cex=1, fontfamily="Courier"))




#
# Other options.
#

# Initialize.
spiral_initialize_by_time(xlim=c("2020-01-01 00:00:00", "2022-01-06 00:00:00"), 
                          unit_on_axis = "days", period="years",
                          start=90, end=(709/365)*360+(28/365)*360+90,
                          flip="horizontal")

# Create the track.
spiral_track(ylim=c(0, ymax),
             background=FALSE, background_gp = gpar(col = NA, fill = NA))

# Shapes.
spiral_bars(us$dt, us$new_cases_smoothed)
spiral_segments(us$dt, 0, us$dt, us$new_cases_smoothed)
spiral_lines(us$dt, us$new_cases_smoothed, gp=gpar(lwd=2))
spiral_lines(us$dt, us$new_cases_smoothed, type="h", gp=gpar(lwd=.5))
spiral_points(us$dt, us$new_cases_smoothed, pch=19, gp=gpar(cex=.4))

# Baseline.
spiral_lines(x=c(us$dt[1] - days(27:1), us$dt), 0, gp=gpar(lwd=2))

