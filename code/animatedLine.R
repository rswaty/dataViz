

############ animated line #############


library(ggplot2)
library(gganimate)
library(hrbrthemes)
library(scales)
library(readr)
library(htmltools)

current_fire <- read_csv("data/modernFiresAcres.csv")

animateCurr <-
  current_fire %>%
  ggplot(aes(x=Year, y=Acres)) +
  geom_line() +
  geom_point(shape = 21, colour = "black", aes(fill = Acres), size=5, stroke=1) +
  theme_bw(base_size = 18) +
  scale_fill_distiller(palette = "RdYlBu", guide = "none") +
  labs(
    title = "Annual acres of fire in the lower 48 states, 1984-2020",
    caption = "Data from the National Interagency Fire Center, https://www.nifc.gov/fire-information/statistics/wildfires",
    y = "Acres burned per year (~1300s- ~1600s)" ) +
  shadow_wake(wake_length = 0.2,
              alpha = FALSE,
              size = NULL,
              colour = "grey",
              falloff = "linear") +
  scale_y_continuous(label=comma, limits = c(0, 11000000)) +
  scale_x_continuous(limits = c(1980, 2020)) +
  theme(axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0))) +
  transition_reveal(Year)


animate(animateCurr, fps=7, nframes=50, renderer = gifski_renderer(loop = FALSE))
animateCurr
anim_save("animated.gif", animateCurr, width = 1000, height = 800)


# plotly

library(plotly)

accumulate_by <- function(dat, var) {
  var <- lazyeval::f_eval(var, dat)
  lvls <- plotly:::getLevels(var)
  dats <- lapply(seq_along(lvls), function(x) {
    cbind(dat[var %in% lvls[seq(1, x)], ], frame = lvls[[x]])
  })
  dplyr::bind_rows(dats)
}


df <- current_fire 

fig <- df %>% accumulate_by(~Year)


fig <- fig %>%
  plot_ly(
    x = ~Year, 
    y = ~Acres,
    frame = ~frame, 
    type = 'scatter',
    mode = 'lines', 
    line = list(simplyfy = F)
  )
fig <- fig %>% layout(
  xaxis = list(
    title = "Year",
    zeroline = F
  ),
  yaxis = list(
    title = "Acres",
    zeroline = F
  )
) 
fig <- fig %>% animation_opts(
  frame = 100, 
  transition = 0, 
  redraw = FALSE
)
fig <- fig %>% animation_slider(
  hide = T
)
fig <- fig %>% animation_button(
  x = 1, xanchor = "right", y = 0, yanchor = "bottom"
)

fig

# export using R-Studio tool in Viewer tab



