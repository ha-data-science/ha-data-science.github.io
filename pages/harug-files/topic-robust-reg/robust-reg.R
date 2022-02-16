# Robust regression
# https://www.rdocumentation.org/packages/MASS/versions/7.3-55/topics/rlm

# p-vals from rls()
# https://stats.stackexchange.com/questions/205614/p-values-and-significance-in-rlm-mass-package-r

y <- rnorm(30) 
x <- factor(rep(c('a', 'b'), each = 15))
dat <- data.frame(y,x)

library(MASS)
library(sfsmisc)

rlm0 <- MASS::rlm(y~x, data = dat)
summary(rlm0)


sfsmisc::f.robftest(rlm0, var = "xb")
