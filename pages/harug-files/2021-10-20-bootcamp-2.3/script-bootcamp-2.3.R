## HEADER ####
## Who: <YOUR NAME>
## https://dsgarage.netlify.app/
## What: 2.3 Correlation
## Last edited: <DATE TODAY in yyyy-mm-dd format)
####


## CONTENTS ####
## 2.3.1 The question of correlation
## 2.3.2 Data and assumptions
## 2.3.3 Graphing
## 2.3.4 Test and alternatives
## 2.3.5 Practice exercises



## 2.3.1 The question of correlation ####
# devtools::install_github("debruine/faux")
library(faux) 

set.seed(42)
dat <- rnorm_multi(
  n = 99,
  vars = 2,
  mu = c(100, 1000),
  sd = c(10, 50),
  r = c(1, 0.6,
        0.6, 1),
  varnames = c("veg", "arthropods"),
  empirical = FALSE,
  as.matrix = FALSE
)

plot(x = dat, 
     xlab = "Vegetation biomass",
     ylab = "Arth. abundance",
     main = "A positive correlation",
     pch = 16, col = "blue", cex = .7)

dput(round(dat$veg, 1))
dput(round(dat$arthropods, 0))

## flash challenge ####
# Try this:

# Flash challenge
# Take the data input below and try to exactly recreate the figure above!

veg <- c(103.3, 87.1, 94, 111.8, 87.9, 104.6, 108.5, 102.7, 113.4, 98.1, 
         107.1, 114.3, 90.6, 102.1, 103.2, 117, 101.3, 87.7, 63.7, 118.9, 
         97, 100.8, 110.5, 106.5, 119.5, 97.4, 101.8, 94, 118.8, 105.7, 
         101.4, 99.9, 110.3, 96.3, 94.3, 78.1, 103.8, 95.7, 75.7, 103.9, 
         101.7, 98.5, 111.7, 99, 91.8, 105.9, 86.2, 112.7, 100.8, 98.5, 
         110.3, 95.5, 121.9, 94.8, 102.7, 105.4, 113.9, 100.6, 87.9, 106, 
         87.6, 102.5, 112, 107.3, 98.4, 103.4, 90.8, 114.2, 102.1, 103.8, 
         86.5, 101.3, 97.2, 107.9, 83.3, 96.8, 105.9, 114.3, 89.5, 89.4, 
         109.4, 100.4, 105.1, 96.3, 90.3, 106, 109.2, 93.4, 101.4, 111.6, 
         121.1, 95.5, 106.7, 106.6, 103.4, 102.3, 84.5, 87.8, 95.9)

arth <- c(1069, 973, 1019, 1031, 1022, 994, 1076, 995, 1101, 997, 1065, 
          1114, 931, 986, 993, 1030, 985, 867, 881, 1065, 985, 910, 990, 
          1061, 1094, 978, 987, 911, 1021, 967, 1023, 1036, 1051, 970, 
          1026, 916, 960, 957, 880, 1001, 1010, 982, 1037, 963, 932, 1021, 
          961, 1072, 978, 1033, 1015, 961, 1077, 1033, 1004, 1013, 1033, 
          1004, 850, 1014, 983, 1009, 1028, 1070, 963, 1066, 1018, 1051, 
          1046, 1036, 949, 995, 1032, 951, 975, 1030, 1038, 1022, 956, 
          945, 1076, 1013, 1004, 994, 941, 1030, 988, 992, 1047, 1040, 
          1068, 976, 1032, 1070, 943, 956, 944, 927, 1005)

## 2.3.2 Data and assumptions ####

# Try this:
# use veg and arth from above

# r the "hard way"

# r = ((covariance of x,y) / (std dev x * std dev y) )


# sample covariance (hard way)
(cov_veg_arth <- sum( (veg-mean(veg))*(arth-mean(arth))) / (length(veg) - 1 ))

cov(veg,arth) # easy way

# r the "hard way"
(r_arth_veg <- cov_veg_arth / (sd(veg) * sd(arth)))

# r the easy way
help(cor)
cor(x = veg, y = arth,
    method = "pearson") # NB "pearson" is the default method if unspecified



## 2.3.3 Graphing ####

myr <- c(.99, .8, .5, .1, 0, -.1, -.5, -.8, -.99)

par(mfrow=c(3,3))
for (i in 1:9){
  
  dat <- rnorm_multi(n = 100, vars = 2, r = c(1,myr[i],myr[i],1))
  plot(dat, main = paste("r = ", myr[i])) 
  
}
par(mfrow=c(1,1))


## Correlation matrices ####
# Try this:

# Use the iris data to look at correlation matrix 
# of flower measures
data(iris)
names(iris)
cor(iris[ , 1:4]) # all rows, just the numeric columns

# fix the decimal output
round(cor(iris[ , 1:4]), 2) # nicer

# pairs plot
pairs(iris[ , 1:4], pch = 16, 
      col = iris$Species) # Set color to species...

## 2.3.4 Test and alternatives ####

## Correlation test ####
# Try this:

# 1 The question: whether Petal length and width are correlated

# 2 Graph
plot(iris$Petal.Width, iris$Petal.Length,
     xlab = "Petal width",
     ylab = "Petal length",
     col = iris$Species, pch = 16)

# 3 Test
cor.test(iris$Petal.Width, iris$Petal.Length)

# 4 Validate
hist(iris$Petal.Length) # Ummm..
hist(iris$Petal.Width) # Yuck

# We violate the assumption of Gaussian

# ... Relatedly, we also violate the assumption of independence 
# due to similarities within and differences between species!

## Spearman rank correlation ####

# Try this:

set.seed(42)
height <- round(runif(30, 1, 20), 1)
height[seq(2, 30, by=2)] <- sort(height[seq(2, 30, by=2)])
dput(height)
dput(vol <- sort(round(rnorm(30, 30, 5), 1)))

plot(height, vol,
     xlab = "Height",
     ylab = "Volume",
     pch = 16, col = "blue", cex = .7)

cor(height, vol, method = "spearman")
cor.test(height, vol, method = "spearman")

## 2.3.5 Practice exercises ####

library(MASS)
data(waders)
help(waders)


# 1 Load the waders data and read the help page. Use the 
# pairs function on the data and make a statement about 
# the overall degree of intercorrelation between variables 
# based on the graphical output.



# 2 Think about the variables and data themselves in waders. 
# Do you expect the data to be Gaussian? Formulate hypothesis 
# statements for correlations amongst the first 3 columns 
# of bird species in the dataset. Show the code to make 3 
# good graphs (i.e., one for each pairwise comparison for 
# the first 3 columns), and perform the 3 correlation tests.



# 3 Validate the test performed in question 2. Which form 
# of correlation was performed, and why. Show the code for 
# any diagnostic tests performed, and any adjustment to the 
# analysis required. Formally report the results of your 
# validated results.



# 4 Load the 2.3-cfseal.xlsx data and examine the information 
# in the data dictionary. Analyse the correlations amongst the 
# weight heart and lung variables, utilising the 1 question, 
# 2 graph, 3 test and 4 validate workflow. Show your code and 
# briefly report the results.



# 5 Comment on the expectation of Gaussian for the age variable 
# in the cfseal data. WOuld expect this variable to be Gaussian? 
# Briefly explain you answer and analyse the correlation between 
# weight and age, using our 4 step workflow and briefly 
# report your results.



# 6 Write a plausible practice question involving any aspect 
# of the use of correlation, and our woprkflow. Make use of 
# the data from either the waders data, or else the cfseal data.

