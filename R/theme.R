# ---- theme
library(ggplot2)

colors <- RColorBrewer::brewer.pal(4, "Set2")
names(colors) <- c("blue", "orange", "green", "pink")

base_theme <- theme_minimal() +
  theme(axis.ticks = element_blank())

default_alpha <- 0.8