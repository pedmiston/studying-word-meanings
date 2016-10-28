source("R/theme.R")

# ---- property-verification-results
library(dplyr)
library(ggplot2)
library(lme4)
library(AICcmodavg)

library(propertyverificationdata)
data("question_first")

question_first %<>%
  tidy_property_verification_data %>%
  recode_property_verification_data %>%
  label_outliers %>%
  filter(is_subj_outlier == 0, is_prop_outlier == 0)

error_mod <- glmer(is_error ~ mask_c * feat_c + (1|subj_id),
                   family = "binomial", data = question_first)
preds <- expand.grid(mask_c = c(-0.5, 0.5), feat_c = c(-0.5, 0.5)) %>%
  cbind(., predictSE(error_mod, newdata = ., se = TRUE)) %>%
  dplyr::rename(is_error = fit, se = se.fit) %>%
  recode_property_verification_data %>%
  mutate(feat_label = factor(feat_label, labels = c("Encyclopedic", "Visual")))

ggplot(preds, aes(x = mask_f, y = is_error)) +
  geom_bar(aes(fill = feat_type, alpha = mask_type), stat = "identity", width = 1) +
  geom_errorbar(aes(ymin = is_error - se, ymax = is_error + se), width = 0.2) +
  facet_wrap("feat_label") +
  scale_x_discrete("", labels = c("Blank", "Interference")) +
  scale_y_continuous("Error rate", labels = scales::percent,
                     breaks = seq(0, 0.5, by = 0.02)) +
  scale_fill_manual(values = c(colors[["blue"]], colors[["green"]])) +
  scale_alpha_manual(values = c(0.9, 0.4)) +
  coord_cartesian(ylim = c(0, 0.07)) +
  labs(title = "Visual interference disrupts\nvisual knowledge") +
  base_theme +
  theme(legend.position = "none",
        panel.grid.major.x = element_blank())