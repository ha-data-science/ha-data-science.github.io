## HEADER ####
## Who: Ed Harris
## what: Bootcamp 1.2 code
## Last edited: 2021-07-20


## CONTENTS ####
## 00 Setup
## 1.2.1 Function tour
## 1.2.2 Using functions and getting help
## 1.2.3 R packages
## 1.2.4 Finding, downloading and using packages
## 1.2.5 Practice exercises


## 00 Setup ####
# working directory (Windows)
# setwd(r"(<YOUR_FILEPATH>)")


## 1.2.1 Function tour ####

## A workflow for using functions
## (make pseudocode of steps)

# Overall task: calculate the mean for a vector of numbers
# Step 1: Code the vector of data - c() function
# Step 2: Calculate the mean - mean() function
# Step 3: Plot the data - boxplot()

# Step 1: Code the vector of data - c() function

help(c) # We use this a lot - it "combines" numbers
my_var <- c(2, 6, 7, 8.1, 5, 6) 

# Step 2: Calculate the mean - mean() function

help(mean) 
# Notice under Usage, the "x" argument
# Notice under Arguments, x is a numeric vector

mean(x = my_var) # Easy

# Step 3: Plot the data - boxplot()

help(boxplot) # x again!
boxplot(x = my_var)

# Challenge 1: Add a title to you boxplot using the argument "main"
# Challenge 2: Add an axis label to the y-axis - can you find the argument?

boxplot(x = my_var,
        
        )

## 1.2.2 Using functions and getting help ####
# Challenge: Install and load the "yarrr" package, 
# and then use help() to look at the help page for the function pirateplot().

install.packages("yarrr")
library(yarrr)

help(topic = pirateplot)

pirateplot(data = data.frame(my_var))

my_dat <- data.frame(y = c(2,3,4,5,4,3),
                     x = c('a','a','a','b','b','b'))
pirateplot(formula = weight ~ Time,
           data = ChickWeight)
## 1.2.3 R packages ####


## 1.2.4 Finding, downloading and using packages ####


## 1.2.5 Practice exercises ####
