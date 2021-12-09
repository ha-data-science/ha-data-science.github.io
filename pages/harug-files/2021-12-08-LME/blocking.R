## demo script for blocking analysis ####
## Who: Ed H
## what: HARUG! mixed effects and blocking
## Last edited: 2021-12-07


## CONTENTS ####
## 00 Setup
## 01 Data
## 02 Graph
## 03 Stats


## 00 Setup ####

# Load packages
# NB might not use all of these
library(nlme)
library(ggplot2)
library(dplyr)
library(ggpubr)
library(lme4)
library(lmerTest)
library(visreg)
library(MuMIn)
library(emmeans)
library(lsmeans)
library(multcomp)
library(multcompView)
library(openxlsx)
library(lsr) # for etaSquared()
library(sjPlot) # for plot_model()

## 01 Data ####

setwd(r'(D:\Dropbox\git-hads\ha-data-science.github.io\pages\harug-files\2021-12-08-LME)')
data <- read.xlsx('blocking.xlsx')

data$Block <- factor(data$Block)
data$Traffic <- factor(data$Traffic)
data$Tillage <- factor(data$Tillage, ordered = T, 
                       levels = c('Zero', 'Shallow', 'Deep'))
table(data$Plot); length(table(data$Plot))



# look at interaction plots and summary plots
# does block look like it matters?
# the next graphs are just for exploratory data analysis
summary(data$OM)
interaction.plot(x.factor = data$Traffic,
                 trace.factor = data$Block,
                 response = data$OM)  #the blocks look different!

interaction.plot(x.factor = data$Tillage,
                trace.factor = data$Block,
                response = data$OM)  #the blocks look different!

interaction.plot(x.factor = data$Tillage,
                 trace.factor = data$Traffic,
                 response = data$OM)  #not much interaction?

## 02 Graph ####

# diagnose block
# https://imaging.mrc-cbu.cam.ac.uk/statswiki/FAQ/effectSize
boxplot(OM ~ Block, data = data)
etaSquared(aov(OM ~ Block, data = data))
etaSquared(aov(OM ~ Traffic, data = data))
etaSquared(aov(OM ~ Tillage, data = data))


boxplot(OM ~ Traffic + Tillage, data = data,
        ylim = c(4.3,5.8), xaxt='n', xlab='',
        col = c('gray20', 'gray70', 'white'),
        at = c(1,2,3,5,6,7,9,10,11))
stripchart(OM ~ Traffic + Tillage, data = data,
           ylim = c(4,6), add = T, vertical = T,
           method = 'jitter', pch = 16, cex = .5,
           at = c(1,2,3,5,6,7,9,10,11), col = 'red')
axis(side = 1, at = c(2,6,10), tick = F, line = -0.5,
     labels = c('Deep', 'Shallow', 'Zero'))
axis(side = 1, at = c(6), tick = F, line = 1,
     labels = c('Tillage'))
legend(x = 10, y = 5.8, 
       legend = c('CTF', 'LTF', 'STP'),
       pch = 22, pt.bg = c('gray20', 'gray70', 'white'),
       title = 'Traffic', bty='n')


## 03 Stats ####
# Note 1 avoid model building it is an experiment
# Note 2 low replication
# Note 3 Experiment should show negative effects as a result if present
# Note 4 The block seems like it could contribute confounding (random) effect

# Note 5 There is arguably not really enough replication for interaction 
# Tillage:Traffic (not legitimately), but we could compare models 
# with and without it

# OM ~ 
# fixed: Tillage + Traffic 
# random: 1|Block

#Mixed effect models with random effect: block
lme0 <- lmer(OM ~ Tillage + Traffic + (1|Block), data = data)
plot(lme0) # acceptable
summary(lme0)
anova(lme0)
r.squaredGLMM(lme0)
plot_model(lme0, show.values=TRUE, show.p=TRUE)


#Mixed effect models with random effect: block AND interaction
#If you are interested in the interaction, only consider this one
lme1 <- lmer(OM ~ Tillage * Traffic + (1|Block), data = data)
summary(lme1)
anova(lme1)
r.squaredGLMM(lme1)
plot_model(lme1, show.values=TRUE, show.p=TRUE)


# the models are not statistically different
# and the one without the interaction is slightly better
# based on the lower AIC
anova(lme0, lme1) 

# replication is so low, we can try all-fixed model
lm0 <- lm(OM ~ Tillage + Traffic + Block, data = data)
summary(lm0)
anova(lm0)
plot_model(lm0, show.values=TRUE, show.p=TRUE)



# Compute some post hocs (but power is low because of small replication)
cld(lsmeans(lme0, ~ Tillage + Traffic)) # oof



