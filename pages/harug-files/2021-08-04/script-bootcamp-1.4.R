## HEADER ####
## Who: Ed Harris
## what: Bootcamp 1.4 code
## Last edited: 2021-08-04


## CONTENTS ####
## 00 Setup
## 1.4.1 Tidy data concept
## 1.4.2 Common data file types
## 1.4.3 Excel, data setup, and the data dictionary
## 1.4.4 Getting data into R
## 1.4.5 Manipulation variables in the data frame
## 1.4.6 Practice exercises


## 00 Setup ####
# working directory (Windows)
# setwd(r"(<YOUR_FILEPATH>)")

# https://dsgarage.netlify.app/bootcamp/1.4-m1-data-frames/


## 1.4.1 Tidy data concept ####



## 1.4.2 Common data file types ####



## 1.4.3 Excel, data setup, and the data dictionary ####



## 1.4.4 Getting data into R ####

# Try this

getwd() # Prints working directory in Console

setwd(r"()") 

# NB the quotes

# NB this is MY directory - change the string to YOUR directory :)

getwd() # Check that change worked

## Read in Excel data file


# install.packages(openxlsx, dep = T) # Run if needed
library(openxlsx) # Load package needed to read Excel files

# Make sure the data file "1.4-tidy.xlsx" is in your working directory
my_data <- read.xlsx("1.4-tidy.xlsx")


## 1.4.5 Manipulation variables in the data frame ####
# Try this

class(my_data) # data.frame, a generic class for holding data


## The ```names()``` function ####

# The names() function returns the name of attributes in R objects
# When used on a data frame it returns the names of the variables
names(my_data)

# Note the conc.ind variable is classed numeric
# Note the treatment variable is classed as character (not a factor)


## The use of the ```$``` operator for data frames ####

# The $ operator allows us to access variable names inside R objects
# Use it like: data_object$variable_name
my_data$conc.ind

# Try this
conc.ind # Gives an error because the variable conc.ind is INSIDE my_data


## The use of the ```str()``` function for data frames ####
# The str() function returns the STRUCTURE of a data frame
# This includes variable names, classes, and the first few values

str(my_data) # This is similar to the graphical Global Environment view in RStudio

## The use of the index operator ```[ , ]``` ####
# The index operator allows us to access specified rows and colums in data frames
# (this works exactly the same in matrices and otehr indexed objects)

my_data$conc.tot # The conc.tot variable with $
my_data$conc.tot[1:6] # each variable is a vector - 1st 6 values

help(dim)
dim(my_data) # my_data has 18 rows, 6 columns

my_data[ , ] # Leaving the entries blank means return all rows and columns
names(my_data) # Note conc.tot is the 6th variable
names(my_data)[6] # Returns the name of the 6th variable

my_data[ , 6] # Returns all rows of the 6th variable in my_data

# We can explicitly specify all rows (there are 18 remember)
my_data[1:18 , 6] # ALSO returns all rows of the 6th variable in my_data

# We can specify the variable names with a character
my_data[ , "conc.tot"]
my_data[ , "conc.ind"]

# Specify more than 1 by name with c() in the column slot of [ , ]
my_data[ , c("conc.tot", "conc.ind")] 


## The use of the ```attach()``` function ####
# The attach() function makes variable names available 
# for a data object in R space

conc.ind # Error; the Passive-Aggressive Butler doesn't understand...

attach(my_data)
conc.ind # Now that my_data is "attached", the Butler can find variables inside

help(detach) # Undo attach()
detach(my_data)
conc.ind # Is Sir feeling well, Sir?


## 1.4.6 Practice exercises ####



### 01 ####
# Download the data file above and place it in a working directory. 
# Set your working directory. Read in the data file and place it in 
# a data frame object named "data1". After examining the data, 
# use mean() to calculate the mean of the variable "length" and 
# report the results in a comment to 2 decimal points accuracy. 
# Show your R code.


### 02 ####
# Show the code to convert the diet variable to an ordinal factor 
# with the order "control" > "enhanced", and the sex variable to 
# a plain categorical factor.
library(openxlsx)
setwd(r'(D:\Dropbox\git-hads\ha-data-science.github.io\pages\harug-files\2021-08-04)')
data1 <- read.xlsx('1.4-butterfly.xlsx') 

data1[ ,"diet"] <- factor(x = data1[ ,"diet"], levels = c("control", "enhanced"))
data1$diet <- factor(data1$diet, ordered = T, levels = c("enhanced", "control"))
str(data1)
data1$diet

class(data1$diet)
### 03 ####
# Show code for 2 different variations of using only the "[ , ]" operator 
# with your data frame to show the following output:

#   diet length
# 8   control      6
# 9   control      7
# 10  control      6
# 11 enhanced      8
# 12 enhanced      7
# 13 enhanced      9

### 04 ####
# Show code to read in a comma separated values data file that does not 
# have a header (first row containing variable names).


### 05 ####
# Describe in your own words what the attach() function does.
  

### 06 ####
# Write a plausible practice question involving any aspect of 
# manipuation of a data frame.
