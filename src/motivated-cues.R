# ---- motivated-cues-exp1
library(plyr)
library(ggplot2)
library(grid)
library(gridExtra)

library(RColorBrewer)
col.label <- brewer.pal(3, 'Reds')[3]
col.incongr <- brewer.pal(5, 'Blues')[2]
col.congr <- brewer.pal(5, 'Blues')[5]
cols.labels <- rev(brewer.pal(5, 'Reds')[2:5])
cols.sounds <- rev(brewer.pal(5, 'Blues')[2:5])

library(motivatedcues)
data("exp1_final_rep")

exp1 <- exp1_final_rep
exp1$trial_type <- factor(exp1$trial_type, levels=c('label','congruent', 'incongruent'), ordered=T)
exp1$exp <- factor(exp1$exp, levels=c('tyi','tyo-rep'), ordered=T)

exp1.bar <- summarySEwithin(exp1, measurevar='rt', betweenvars='exp', withinvars='trial_type', idvar='subjCode', conf.interval=0.95)

dodge = position_dodge(width=0.9)
plot.exp1 <- ggplot(exp1.bar, aes(x=exp, y=rt, fill=trial_type)) +
  geom_bar(position=dodge, stat='identity') +
  geom_bar(position=dodge, stat='identity', color='black', size=0.5, show_guide=FALSE) +
  geom_errorbar(aes(ymin=rt-ci, ymax=rt+ci), position=dodge, width=0.4, size=0.5) +
  coord_cartesian(ylim=c(400,700)) +
  scale_x_discrete('', labels=c('Experiment 1A', 'Experiment 1B')) +
  scale_y_continuous('Verification Speed (ms)', breaks=seq(400,700,by=50)) +
  scale_fill_manual('Cue Type', labels=c('Label','Congruent Sound', 'Incongruent Sound'),
                    values=c(col.label, col.congr, col.incongr)) +
  theme_classic(base_size=12) +
  theme(legend.position=c(0.75, 0.9),
        legend.direction='vertical',
        legend.key=element_rect(color='black', size=1.0),
        legend.key.size=unit(8, units='points'),
        axis.ticks.length=unit(5, units='points'),
        axis.ticks.x=element_blank())

plot.exp1
