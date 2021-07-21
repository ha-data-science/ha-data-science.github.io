## HEADER ####
## Who: Ed Harris
## what: Bootcamp 1.1 code
## Last edited: 2021-07-12


## CONTENTS ####
## 00 Setup
## 1.1.1 Example script, comments, help, pseudocode
## 1.1.2 Math operators
## 1.1.3 Logical Boolean operators
## 1.1.4 Regarding base R and the Tidyverse
## 1.1.5 Practice exercises


## 00 Setup ####
# working directory (Windows)
# setwd(r"(<YOUR_FILEPATH>)")


## 1.1.1 Example script, comments, help, pseudocode ####
# Display help page for the function mean
help(mean)

# try this code in your own script
my_length <- c(101, 122, 97) # 3 numerical measures
mean(x = my_length) 

## 1.1.2 Math operators ####
# Add with "+"
2 + 5

# Subtract with "-"
10 - 15

# Multiply with "*"
6 * 4.2

# Divide by "/"

10 / 4

# raise to the power of x
2^3 
9^(1/2) # same as sqrt()!


# Try this
4 + 2 * 3

# Order control - same
4 + (2 * 3)

# Order control - different...
(4 + 2) * 3

## Use of spaces

# Try this
6+10                                  # no spaces
7     -5                              # uneven spaces
1.6             /                2.3  # large spaces
16 * 3                                # exactly 1 space

# exactly 1 space is easiest to read...


## 1.1.3 Logical Boolean operators ####
# Try this
# simplest example
3 > 5

# 3 is compared to each element
3 < c(1, 2, 3, 4, 5, 6) 

# Logic and math
# & (ampersand) means "and"
# | (pipe) means "or"

# This asks if both phrases are true (true AND true)
# notice "TRUE" has a special meaning in R

TRUE & TRUE # both phrases are true

3 > 1 & 1 < 5 # both phrases are true

# Are both phrases true?

TRUE & FALSE # are both true?

FALSE & FALSE # are both true?

# Booleans can be useful to select data

# Put some data into a variable and then print the variable
# Note "<-" is the ASSIGNMENT syntax in R, which puts the value on the left "into" x

x <- c(21, 3, 5, 6, 22)
x

x > 20

# the square brackets act as the index for the data vector
x[x > 20]

# Try this
TRUE # plain true

!FALSE # not false is true!

6 < 5 #definitely false

!(6 < 5) #not false...

!(c(23, 44, 16, 51, 12) > 50) 

## 1.1.4 Regarding base R and the Tidyverse ####


## 1.1.5 Practice exercises ####

### Ex 01 ####
# Name and describe the purpose of the first 2 sections that 
# should be present in every R script



### Ex 02 ####
# What is the purpose of "main" argument in the boxplot() 
# function (hint: use help())
  
  
  
### Ex 03 ####
# Write an expression using good R spacing syntax that 
# takes the sum of 3, 6, and 12 and divides it by 25



### Ex 04 ####
# Write pseudocode steps for calculating the volume of a 
# cylinder (hint, if you do not know it by heart, you may need 
# to research the equation for the volume of a cylinder!). 
# For a cylinder of height = 3.2 cm and end radius of 5.5 cm, 
# report the volume in cm to 2 decimal points of accuracy. 
# Use at least 3 decimal points of accuracy for pi.



### Ex 05 ####
# Execute the code and explain the outcome in comments.

TRUE & 3 < 5 & 6 > 2 & !FALSE



### Ex 06 ####
# Write a plausible practice question involving the use of 
# the not Boolean operator, "!".

