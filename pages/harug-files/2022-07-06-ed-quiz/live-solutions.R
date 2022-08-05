## HEADER ####
## who: Ed
## what: bootcamp quiz
## when 2022-07-07

## q1 Start a reproducible script for the assessment ####

## q2 Show the R code to produce the following output ####
mymat <- matrix(c(32,34,28,42), 
       nrow = 2, byrow = T)

rownames(mymat) <- c('female', 'male')
colnames(mymat) <- c('dog', 'cat')
mymat

## q3 Show the R code to make a good histogram of the following ####
# data, describing the height in centimeters of domestic cats at 
# the shoulder

cat <- c(20.7, 21.7, 23.7, 27.1, 20.0, 27.0, 27.4, 24.6, 
         24.3, 18.6, 20.1, 19.8, 24.9, 21.8, 25.7, 23.0, 
         25.2, 27.9, 21.8, 25.8, 27.3, 20.1, 24.5, 19.3, 
         20.7, 21.9, 18.1, 21.8, 26.7, 21.4, 22.8, 24.0, 
         22.9, 19.9, 26.3, 24.7, 25.9, 19.1, 25.2, 22.1)

hist(cat,
     xlab = 'Cat height at shoulder (cm)',
     ylab = 'Count',
     col = 'goldenrod')

## q4 Using the cat data object from the previous question, #### 
# perform the Shapiro test to decide whether the data adhere 
# to a Gaussian distribution. Show your R code to do this and 
# also, in comments, report and briefly interpret your results 
# in the technical style. 

shapiro.test(cat)

# There is no evidence the cat height data is distributed differently 
# to Gaussian (Shapiro test: W = 0.96, n = 40, P = 0.13) 

## q5 Using the following code, examine the 'CO2' data frame and help file ####
data(CO2) 
help(CO2) 
head(CO2)

sub <- CO2[which(CO2$conc == 350), ]

boxplot(uptake ~ Treatment, data = sub,
        ylab = 'CO2 uptake (umol/m^2 sec)',
        col = 'goldenrod')

## q6 Given the data ####

y <- c(1.36,-0.10, 0.39,-0.05,-1.38,-0.41,-0.39,-0.06, 1.10, 0.76) 
x <- c(-0.16,-0.25, 0.70, 0.56,-0.69,-0.71, 0.36, 0.77,-0.11, 0.88)

plot( y ~ x,
      ylab = 'My y axis label',
      xlab = 'Just and example label',
      col = 'blue',
      pch = 15, cex = 1.5,
      cex.lab = 1.5)
abline(lm(y~x), col = 'red', lty = 2, lwd = 2)
text(y = 1,
     x = 0.5,
     labels = 'y = 0.059 + 0.467*x')


## q7 Show the code to calculate the residuals for a simple ####
# linear regression of y as a function of x for the data in 
# the previous question, and calculate the mean and standard 
# deviation of the residuals. In comments, report your 
# findings appropriately and briefly interpret them 

mean(lm(y~x)$residuals)
sd(lm(y~x)$residuals)

# The mean of my residuals is close to zero (as it should be!), the 
# standard deviation is 0.76 units.

## q8 Based on on Figure 2 below, relate in comments the degree to ####
# which you believe the Excel dataset shown adheres to Tidy 
# Data standards. Be brief, but be as specific as you can

# The data appear to be arranged in rows and columns.  The figures
# and descriptive statistics should NOT be present.  At least one column name
# is probably too long and contains a space.  Verdict: Misdemeanor, but not in tidy format.

## q9 Perform 1-way Analysis of Variance to evaluate the 
# overall effect of insect spray type (spray) on the number 
# of insects counted (count) for the InsectSprays dataset. 
# Show your code and briefly summarize and interpret your 
# results in comments. Also, show the code to make a good 
# and appropriate graph for the data and statistical test.

data(InsectSprays)
anova(aov(count~spray, data = InsectSprays))

boxplot(count~spray, data = InsectSprays,
        ylab = 'Count of insects',
        xlab = 'Pesticide spray type',
        col = 'goldenrod')

# The mean insect count is different for different sprays in the ####
# InsectSprays data
# (ANOVA: F5,66 = 34.7, P < 0.0001)
        