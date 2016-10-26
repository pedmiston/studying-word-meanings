source("R/theme.R")

# ---- motivated-cues-exp1
library(plyr)
library(ggplot2)
library(grid)
library(gridExtra)
library(dplyr)

col.label <- colors[["orange"]]
col.incongr <- colors[["blue"]]
col.congr <- colors[["green"]]

library(RColorBrewer)
cols.labels <- rev(brewer.pal(5, 'Reds')[2:5])
cols.sounds <- rev(brewer.pal(5, 'Blues')[2:5])

library(motivatedcues)
data("exp1_final_rep")
exp1 <- exp1_final_rep

trial_type_levels <- c("label", "congruent", "incongruent")
trial_type_labels <- c("Word", "Congruent sound", "Incongruent sound")

exp1$trial_type <- factor(exp1$trial_type, levels = trial_type_levels, ordered = T)
exp1$exp <- factor(exp1$exp, levels=c('tyi','tyo-rep'), ordered=T)
exp1.bar <- summarySEwithin(exp1, measurevar='rt', betweenvars='exp', withinvars='trial_type', idvar='subjCode', conf.interval=0.95)

exp1.bar$trial_type <- factor(exp1.bar$trial_type, levels = trial_type_levels, labels = trial_type_labels)

dodge = position_dodge(width=0.9)
plot.exp1 <- ggplot(exp1.bar, aes(x=exp, y=rt, fill=trial_type)) +
  geom_bar(position=dodge, stat='identity', alpha = default_alpha) +
  geom_text(aes(y = 400, label=trial_type), angle = 90, position = dodge, hjust = 0) +
  geom_errorbar(aes(ymin=rt-ci, ymax=rt+ci), position=dodge, width=0.4, size=0.5) +
  coord_cartesian(ylim=c(400,700)) +
  scale_x_discrete('', labels=c('Experiment 1A', 'Experiment 1B')) +
  scale_y_continuous('Verification Speed (ms)', breaks=seq(400,700,by=50)) +
  scale_fill_manual('Cue Type', labels=c('Label','Congruent Sound', 'Incongruent Sound'),
                    values=c(col.label, col.congr, col.incongr)) +
  base_theme +
  theme(legend.position = "none")

plot.exp1

# ---- motivated-cues-exp2
require(lme4)
require(AICcmodavg)

data("typ_final")
data("imageratings")
typ <- typ_final
ratings <- imageratings

inter <- lmer(rt ~ cue_typeC * delayC * zSound + zLabel + (1+cue_typeC|subjCode) + (1|trialID), data=typ, REML=F)

predratings <- seq(round(min(ratings$zSound), 1), 1.5, by=0.1)

# generate model predictions
predictors <- expand.grid(cue_typeC = c(-0.5, 0.5),
                          delayC = c(-0.5, 0.5),
                          zSound = predratings,
                          zLabel = 0)
modelPredictions <- predictSE(inter, predictors, type='response', print.matrix=F)
plotvals <- cbind(predictors, modelPredictions)

names(plotvals)[names(plotvals) %in% c('fit','se.fit')] <- c('rt','se')
plotvals$upr <- plotvals$rt + plotvals$se
plotvals$lwr <- plotvals$rt - plotvals$se

# reverse key to reflect order in chart
plotvals$cue_typeC <- plotvals$cue_typeC * -1

typ.all <- ggplot(plotvals, aes(x=zSound)) +
  geom_smooth(aes(y=rt, ymin=lwr, ymax=upr, color=factor(cue_typeC), linetype=factor(cue_typeC)),
              data=plotvals[plotvals$delayC == -0.5, ],
              stat='identity', lwd=0.7) +
  geom_smooth(aes(y=rt, ymin=lwr, ymax=upr, color=factor(cue_typeC), linetype=factor(cue_typeC)),
              data=plotvals[plotvals$delayC == 0.5, ],
              stat='identity', lwd=0.7) +
  geom_rug(data=ratings, sides='b', stat='identity') +
  coord_cartesian(ylim=c(400, 750)) +
  scale_x_continuous('Sound-Image Congruence (z-score)', breaks=seq(-1.5, 1.5, by=0.5)) +
  scale_y_continuous('Verification Speed (ms)', breaks=seq(400,750,by=50)) +
  scale_color_manual('Cue Type', labels=c('Sound','Label'), values=c(col.congr, col.label)) +
  scale_linetype_manual('Cue Type', labels=c('Sound','Label'), values=c(2,1)) +
  annotate('text', label='Simultaneous', x=0, y=740) +
  annotate('text', label='Delayed (400 msec)', x=0, y=540) +
  theme_classic(base_size=12) +
  theme(legend.position=c(0.85, 0.59),
        legend.key=element_rect(color='white', fill='white'),
        axis.ticks.length=unit(10, units='points'))

print(typ.all)
