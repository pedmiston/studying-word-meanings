source("R/theme.R")

# ---- property-verification-results
library(dplyr)
library(ggplot2)

library(propertyverificationdata)
data("question_first")
question_first %<>%
  tidy_property_verification_data %>%
  recode_property_verification_data %>%
  label_outliers %>%
  filter(is_subj_outlier == 0, is_prop_outlier == 0) %>%
  mutate(feat_label = factor(feat_label, labels = c("Encyclopedic", "Visual")))

ggplot(question_first, aes(x = mask_f, y = is_error)) +
  geom_bar(aes(fill = feat_type, alpha = mask_type, width = 1),
           stat = "summary", fun.y = "mean") +
  facet_wrap("feat_label") +
  scale_x_discrete("", labels = c("Blank", "Interference")) +
  scale_y_continuous("Error rate", labels = scales::percent,
                     breaks = seq(0, 0.5, by = 0.02)) +
  scale_fill_manual(values = c(colors[["blue"]], colors[["green"]])) +
  scale_alpha_manual(values = c(0.9, 0.4)) +
  coord_cartesian(ylim = c(0, 0.07)) +
  base_theme +
  theme(legend.position = "none",
        panel.grid.major.x = element_blank())