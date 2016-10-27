# ---- theme
library(ggplot2)

colors <- RColorBrewer::brewer.pal(4, "Set2")
names(colors) <- c("blue", "orange", "green", "pink")

base_theme <- theme_minimal(base_size = 20) +
  theme(axis.ticks = element_blank(),
        panel.grid.minor = element_blank())

default_alpha <- 0.9
text_label_size <- 6