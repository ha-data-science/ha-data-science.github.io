library(spatial)
library(readxl)
Corn <- read_excel("Data 2022 V 04.xlsx",
                   sheet = "R")

x <- c(1:6)
y <- c(1:6)


# make a map

Y.real <- matrix(Corn$CovOM, nrow = 6)
persp(x,y,Y.real, theta = 220, phi = 30, scale = F)

# model the trend

model.lin <- lm(CovOM ~ x + y, data = Corn)
coef(model.lin)
trend.lin <- predict(model.lin)
Y.lin <- matrix(trend.lin, nrow = 6)
Fit <- 4* Y.lin
persp(x,y,Fit, theta = 220, phi = 30, scale = F)

# the difference

persp(x,y,Fit-Y.real, theta = 220, phi = 30, scale = F)


# autocorrelation experiment

set.seed(123)
lambda <- 0.4
ttest <- funtion(lambda){
  Y <- numeric(20)
  for(i in 2:20)
}
