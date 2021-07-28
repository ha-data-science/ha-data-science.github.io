## HEADER ####
## Who: Ed Harris
## what: Bootcamp 1.3 code
## Last edited: 2021-07-28


## CONTENTS ####
## 00 Setup
## 1.3.1 Basic data types, str
## 1.3.2 Data with factor
## 1.3.3 Class and converting variables
## 1.3.4 Vector and Matrix fun
## 1.3.5 Practice exercises


## 00 Setup ####
# working directory (Windows)
# setwd(r"(<YOUR_FILEPATH>)")

# https://dsgarage.netlify.app/bootcamp/1.2-m1-function-and-packages/


## 1.3.1 Basic data types, str ####
# Try this

### Make some data ####

variable_1 <- c(4,5,7,6,5,4,5,6,7,10,3,4,5,6) # a numeric vector

variable_2 <- c(TRUE, TRUE, TRUE, FALSE) # a logical vector

variable_3 <- c("Peter Parker", "Bruce Wayne", "Groo the Wanderer") # a character vector

class(variable_1) # "numeric"
class(variable_2) # "logical"
class(variable_3) # "character"

# have a look at the Global environment

### Naming variables ####


# Try this

## Variable name rules ####

# Can contain letters, numbers, some symbolic characters
x1 <- 5  # OK
x2 <- "It was a dark and stormy night" # OK
my_variable_9283467 <- 1 # technically works, but hard to read and too long
  
# Must begin with a letter 
varieties <- c("red delicious", "granny smith") # OK
x432 <- c("a", "b") # OK
22catch <- c(TRUE, TRUE, FALSE)  # nope

# Must not contain spaces
my_variable <- 3 # OK
my.variable <- 4 # OK
myVariable <- 5 # OK

my variable <- 6 # nope
"my variable" <- 7 # nope

# Must not contain forbidden characters like 
# math operators, "@", and a few others
my@var <- 1 # nope
my-var <- 1 # nope
my=var <- 1 # nope
# etc.

# Should be human-readable, consistent, and not too long

Diameter_Breast_Height_cm <- c(22, 24, 29, 55, 43) # legal but too long
DBH_cm <- c(22, 24, 29, 55, 43) # much better

#Case sensitive
height <- c(180, 164, 177) # OK
Height # Error: object 'Height' not found (notice capital H)
height # OK

## 1.3.2 Data with factor ####


## 1.3.3 Class and converting variables ####

# try this

# non-ordered factor
variety <- c("short", "short", "short",
             "early", "early", "early",
             "hybrid", "hybrid", "hybrid")
class(variety)  # "character", but this is really a factor...
variety # Notice the character strings are just printed out

variety <- factor(variety) # use factor() to convert the character vector to a factor
class(variety)  # now variety is a "factor"
variety # notice the output has changed

# Ordered factors
day <- c("Monday", "Monday", 
         "Tuesday", "Tuesday", 
         "Wednesday", "Wednesday", 
         "Thursday")
class(day) # "character

#make day a factor
day <- factor(day)
class(day)
day # Notice the Levels: Monday Thursday Tuesday Wednesday

# To set the order explicitly we need to set them explicitly
help(factor) # notice the levels argument - it sets the order of the level names

day <- factor(x = day, levels = c("Monday", "Tuesday",
                                  "Wednesday", "Thursday"))
day # Notice the level order now

## 1.3.4 Vector and Matrix fun ####

### Vectors ####

# Try this

myvec1 <- c(1,2,3,4,5) # numeric vector
myvec1
class(myvec1) # see? I told ya!

myvec2 <- as.character(myvec1) #convert to character
myvec2 # notice the quotes
class(myvec2) # now character

myvec3 <- c(2, 3, "male")
myvec3 #notice the numbers now have quotes - forced to character...

myvec4 <- as.numeric(myvec3) #notice the warning
myvec4 # The vector element that could not be coerced to be a numeric was converted to NA

### Matrices ####

# Try this

vec1 <- 1:16 # make a numeric vector with 16 elements
vec1 

help(matrix) #notice the ncol, nrow and byrow arguments

mat1 <- matrix(data = vec1, ncol = 4, byrow = FALSE) #byrow = FALSE is the default

mat1 # Notice the numbers filled in by columns
colnames(mat1) # The Columns and Rows have no names

colnames(mat1) <- c("A", "B", "C", "D") # Set the column names for mat1
colnames(mat1)

mat1 # Yep the columns shows names

# Challenge 1: Set the Row names for Mat1 using the rownames() function

# Challenge 2: make a matrix with 3 rows with the following vector, 
# so the the first COLUMN contains the numbers 2, 5, and 9, in the order,
# for rows 1, 2, and 3 respectively:

vec2 <- c(2,3,5,4,5,6,7,8,9,5,3,1)


## 1.2.5 Practice exercises ####

### 01 ####
# Create a vector named my_var1 that contains the following 
# 6 integers: 3, 6, 12, 7, 5, 1. Create a Second vector 
# called my_var2 that contains the following 2 integers: 
#   2, 3. Evaluate the expression my_var1 + my_var 2. 
# Explain the output in terms of R mechanics in your own words.



### 02 ####
Create a character vector with the names of the 12 months 
of the year. Convert the vector to a factor, with the 
month names in chronological order. Show your code.



### 03 ####
# What is wrong with the following code? Describe, show the 
# code, and justify a fix for the problem in your own words.

mymat <- matrix(data = c( 12,   23,   45,
                          "34", "22", "31"))


### 04 ####
# Use the array() function to make a 2 x 2 x 3 array 
# to produce the following output:
  
# , , 1
# 
# [,1] [,2]
# [1,]    1    3
# [2,]    2    4
# 
# , , 2
# 
# [,1] [,2]
# [1,]    5    7
# [2,]    6    8
# 
# , , 3
# 
# [,1] [,2]
# [1,]    9   11
# [2,]   10   12  

### 05 ####
# Show the code to make the following matrix:

# cat dog
# male    22  88
# female  71  29 
  
### 06 ####
# Write a plausible practice question involving the use of 
# the matrix() and vector() functions.
