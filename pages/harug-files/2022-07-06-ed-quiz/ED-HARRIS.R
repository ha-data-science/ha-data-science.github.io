## HEADER ####
## who: 
## what: 
## when:

## CONTENTS ####
## 00 Setup
## Question 02
## Question 03
## Question 04
## Question 05
## Question 06
## Question 07

## Question 02 ####
mymat <- matrix(c(32,34,28,42), nrow = 2, byrow = 2)
colnames(mymat) <- c('dog', 'cat')
rownames(mymat) <- c('female', 'male')
mymat

## Question 03 ####
# set.seed(1);round(runif(40,18,28),1)

cat <- c(20.7, 21.7, 23.7, 27.1, 20.0, 27.0, 27.4,
         24.6, 24.3, 18.6, 20.1, 19.8, 24.9, 21.8, 25.7,
         23.0, 25.2, 27.9, 21.8, 25.8, 27.3, 20.1, 24.5,
         19.3, 20.7, 21.9, 18.1, 21.8, 26.7, 21.4, 22.8,
         24.0, 22.9, 19.9, 26.3, 24.7, 25.9, 19.1, 25.2,
         22.1)

hist(cat,
     xlab = 'Cat height at shoulder (cm)',
     col = 'goldenrod')

## Question 04 ####
shapiro.test(cat)

# Cat height at the shoulder is not significantly different from Gaussian 
# (Shapiro test: W = 0.96, n = 40, P = 0.13)

## Question 05 ####
data(CO2)
help(CO2)
head(CO2)

CO2_350 <- CO2[which(CO2$conc == 350), ]

boxplot(CO2_350$uptake ~ CO2_350$Treatment,
        xlab = 'Treatment',
        ylab = 'CO2 uptake (umol/m^2 sec)',
        col = c('red', 'blue'))

## Question 06 ####
y <- c(1.36, -0.10,  0.39, -0.05, -1.38, -0.41, -0.39, -0.06,  1.10,  0.76)
x <- c(-0.16, -0.25,  0.70,  0.56, -0.69, -0.71,  0.36,  0.77, -0.11,  0.88)

plot(y ~ x, 
     cex.axis = 1.5, cex.lab = 1.5, cex = 1.5,
     ylab = 'My y axis label',
     xlab = 'Just an example label',
     col = 'blue', pch = 15)

(mylm <- lm(y~x))

text(x = 0.5, y = 1,
     'y = 0.059 + 0.467*x',
     cex = 1.5)

abline(mylm, col = 'red', lty = 2, lwd = 3)

## Question 07 ####
summary(mylm)
mean(mylm$residuals)
sd(mylm$residuals)

# The mean of my residuals is 8.3 * 10^-17, i.e., close to zero as expected.  
# The standard deviation of my residuals is 0.76.

## Question 08 ####

# Some aspects of the data adhere to the tidy data standard 
# (variables arranged in columns, simple names without symbolds, etc.).
# However aspects do not adhere to the tidy data ideal, like the 
# embedded summary stats, the embedded figure, the space in the variable
# name in the final column.

## Question 09 ####

data(InsectSprays)
anova(lm(InsectSprays$count ~ InsectSprays$spray))

# There is a strong overall difference in mean insect count 
# between different spray treatments
# (ANOVA: F 5,66 = 34.7, P < 0.0001).

# Should be a boxplot
boxplot(InsectSprays$count ~ InsectSprays$spray,
        xlab = 'Spray treatment',
        ylab = 'Insect count',
        col = colors()[1:6],
        cex.lab=1.5,
        cex.axis = 1.2)

## Question 10 ####

# https://github.com/weharris/bootcamp