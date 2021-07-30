## HEADER ####
## What: R version of Georges python meeting: Tidy Data ####
## Who: George 
## When: 2021-07-29

## Contents ####
## 00 Set up ####
## 01 Improvement 1 ####
## 02 Improvement 2 ####
## 03 Improvement 3 ####
## 04 Improvement 4 ####
## 05 Improvement 5 ####
## 06 Improvement 6 ####
## 07 Improvement 7 ####


## 00 Set up ####
setwd("~/") # setting working directory to my documents
students_performance_df <- read.csv(file = 'studentperformance.csv') ## loading data 

## 01 Improvement 1 ####
student_df <- students_performance_df[, c('id', 'name', 'phone', 'sex.and.age')] ## selecting column by name
# student_df <- students_performance_df[, c(1 , 2, 3, 4)] ## selecting column by number/index
# student_df <- students_performance_df[, c(1:4)] ## selecting column by number sequence

performance_df <- students_performance_df[, c('id', 'test.number', 'term.1', 'term.2', 'term.3')]

## 02 Improvement 2 ####
# One column (sex and age) is representing two variables
student_df1 <- data.frame(do.call("rbind", strsplit(as.character(student_df$sex.and.age), "_", fixed = TRUE)))
names(student_df1) <- c('sex', 'age')
student_df <- cbind(student_df1, student_df)
student_df <- subset(student_df, select = -c (sex.and.age)) # remove the sex and age column
student_df$sex[student_df$sex == "m"] <- "male"
student_df$sex[student_df$sex == "f"] <- "female"# rename the "m" and "f" to male and female

## 03 Improvement 3 ####
# Some of the column headers in the performance data are values, not variable names
install.packages("tidyverse")
library(tidyr)
performance_df <- pivot_longer(performance_df, cols=3:5, names_to = "term", values_to = "marks")

## 04 Improvement 4 ####
performance_df$term <- gsub("term.", "", performance_df$term) # removing "term."

## 05 Improvement 5 ####
# Multiple variables are stored in one column
performance_df <- pivot_wider(performance_df, names_from = test.number, values_from = marks) 

## 06 Improvement 6 ####
# not needed here 

## 07 Improvement 7 ####
# Inserting the school where each student went (adding a new variable)
school <- c("glynne")
performance_df <- data.frame(performance_df, school)


