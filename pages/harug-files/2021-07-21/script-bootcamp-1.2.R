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
# Challenge: Install and load the "ggplo2" package, 
# and then use help() to look at the help page for the function ggplot().

install.packages("ggplot2")
library(ggplot2)

help(topic = ggplot)

## 1.2.3 R packages ####
## 1.2.4 Finding, downloading and using packages ####

my_dat <- data.frame(y = c(2,3,4,5,4,3),
                     x = c('a','a','a','b','b','b'))

  ggplot(data = my_dat, 
       aes(x = x, y = y)) + 
  geom_boxplot()


## 1.2.5 Practice exercises ####

### Ex 01 ####
# Explain in your own words what the freq argument in 
# the hist() function does.  It often helps to practice trail 
# and error to understand what is happening with data.  
# Try experimenting with this data vector with the hist() 
# function to explore the freq argument:
 
c(1,2,4,3,5,6,7,8,6,5,5,5,3,4,5,7)

  
### Ex 02 ####
# Tailor your code from the hist() example in problem 1 so 
# that your histogram has a main title, axis labels, and 
# set the `col` argument to "blue".  We are just 
# scratching the surface with plot customization - try 
# to incorporate other arguments to make an attractive graph.
  

### Ex 03 ####
# Use the mean() function on the following data vector

c(1,2,4,3,5,6,7,8,6,5,NA,5,3,4,5,7)

# You will see an error message.  The symbol "NA" 
# has a special meaning in R, indicating a missing 
# value.  Use help() for the mean function and implement 
# the na.rm argument to fix the problem.  Show your code.
  

### Ex 04 ####
# In your own words, what value is required for the "d" 
# argument in the pwr.t.test() function in the {pwr} 
# package? Show all code involved including any 
# appropriate comment code required to answer this question. 
# (hint: you will probably need to install the package, 
# load it, and use 'help()' on the function name)


### Ex 05 ####
# Comprehensive R Archive Network (CRAN) and there are 
# often tutorials called "vignettes".  Google the 
# CRAN page for the package {ggplot2} and find the 
# vignette called "Aesthetic specifications".  
# Read the section right near the top called 
# "Colour and fill".  
# 
# Follow the instructions to list all of the built-in 
# colours in R and list them in the console.  Ed's personal 
# favourite is "goldenrod", index number [147].  
# Can you find the index number for "tomato2"? 


### Ex 06 ####
# Write a plausible practice question involving the use 
# of the help menu for an R function.
  

  