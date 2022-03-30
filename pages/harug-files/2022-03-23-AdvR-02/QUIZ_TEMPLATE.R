## HEADER ####
## What: Quiz Qs Advanced R, Chapter 2: Names and Values 
## Who: George  
## Last edited: 2022-03-23
install.packages('installr')
library(installr)
installr::install.Rtools()

library(devtools)
install_git(package = 'lobstr',
            url = 'https://github.com/r-lib/lobstr')
library(lobstr)


# Q1 Given the following data frame, how do I create a new column called '3'
# that contains the sum of 1 and 2? You may only use $, not [[. What makes 1, 2, 
# and 3 challenging as variable names?


df <- data.frame(runif(3), runif(3))
names(df) <- c(1, 2)
df$'3' <- apply(X=df, MARGIN = 1, FUN = sum )


# Q2 In the following code, how much memory does y occupy?

x <- runif(1e6)
y <- list(x, x, x)

object.size(x)
lobstr::obj_size(x)
lobstr::obj_addr(x)

object.size(y)
lobstr::obj_size(y)

#Q3 On which line does a get copied in the following example?

a <- c(1, 5, 3, 2)
b <- a
b[[1]] <- 10 # changes here!

