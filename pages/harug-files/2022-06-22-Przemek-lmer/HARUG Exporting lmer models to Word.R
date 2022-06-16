#
# HARUG script 
# 15 June 2022
# Exporting lmer model results to Word

# Libraries and user's functions -------------------------------------------------------------
library(tidyverse)
library(tidyr)
library(ggplot2)
library(lme4)
library(lmerTest)
library(GLMsData)
library(emmeans)
library(interactions)
library(gtsummary)
library(broom.mixed)
library(flextable)
ClassFilter <- function(x) inherits(get(x), 'lmerModLmerTest' )

# Read in data, convert to factors ---------------------------------------------
X <- read.csv("pendata.csv")
va <- "PR"

X$TRAFFIC_CONTROL <- factor(X$TRAFFIC_CONTROL)
X$TILLAGE_DEPTH <- factor(X$TILLAGE_DEPTH, 
                          levels = c("D", "S", "Z"), 
                          labels=c("Deep", "Shallow", "Zero")) # change to ordered factor ordered = T
X$TRAFFIC.by.zone <- factor(X$TRAFFIC.by.zone, 
                            levels = sort(unique(X$TRAFFIC.by.zone)),
                            ordered = TRUE)
X$BLOCK <- factor(X$BLOCK)
X$Depth <- factor(X$Depth, ordered = TRUE)
X$Layer <- factor(X$Layer, ordered = TRUE)
X$TYRE_PRESSURE <- factor(X$TYRE_PRESSURE)
X$TC <- factor(X$TC, levels = c("LT", "HT"))

# lmer models ------------------------------------------------------------------
MS0 <- lmer(as.formula(paste0("sqrt(", va, ") ~ TYRE_PRESSURE * TILLAGE_DEPTH * Layer + (1|BLOCK/PLOT_ID)")), data = X)
MS1 <- lmer(as.formula(paste0("sqrt(", va, ") ~ TRAFFIC.by.zone * Layer + (1|BLOCK/PLOT_ID)")), data = X)
MS2 <- lmer(as.formula(paste0("sqrt(", va, ") ~ TC * Layer + (1|BLOCK/PLOT_ID)")), data = X) # Tyre pressure not in model as for TC=="LT" tyre pressure is only NA
XS3 <- X[X$ZONE=="W" | X$ZONE=="C",] # subset data
MS3 <- lmer(as.formula(paste0("sqrt(", va, ") ~ ZONE * Layer + (1|BLOCK/PLOT_ID)")), data = XS3)

# 
Objs <- Filter(ClassFilter, ls()) # a vector of names of objects of class defined in the ClassFilter function definition

# Export model results to Excel ------------------------------------------------
d0 <- data.frame("Model" = Objs[1],
                 "Call" = paste(as.character(MS0@call[["formula"]]),
                                collapse = " "), anova(get(Objs[1])))
for(oi in seq_along(Objs)[-1]){
  d <- data.frame("Model" = Objs[oi],
                  "Call" = paste(as.character(get(Objs[oi])@call[["formula"]]),
                                 collapse = " "), anova(get(Objs[oi])))
  d0 <- rbind(d0, d) # "never grow objects in a loop..."
}
write.csv(d0, "Model.csv")

# Export model results to Word -------------------------------------------------
for(oi in seq_along(Objs)){
  get(Objs[oi]) %>% 
    tbl_regression(pvalue_fun = function(x) style_pvalue(x, digits = 3), conf.int = T) %>% 
    as_flex_table() %>%
    flextable::save_as_docx(path = paste0("ModelTable_", Objs[oi],".docx"))
}
# Export data Summary to Word --------------------------------------------------
tbl_summary(X) %>%
  as_flex_table() %>%
  flextable::save_as_docx(path = "ModelDataSummary.docx")
