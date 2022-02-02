## HEADER ####
## who: Ed H
## what: HARUG ReprEx
## when: 2022-01-26


## CONTENTS ####
## 00 setup
## 01 example from slides
## 02 your own ReprEx

## 00 setup ####

# setwd()


## 01 example from slides ####

data(iris)
head(iris)

my_iris <- iris[which(iris$Species != 'virginica')]

# finish this
t.test(iris$)

## Go through the steps

# - context

# - what do you want to do?

# - what have you tried (code, not screenshot)?

# - minimal data (probably also code)

dput(head(iris))

my_iris <- structure(list(Sepal.Length = c(5.1, 4.9, 4.7, 4.6, 5, 5.4), 
               Sepal.Width = c(3.5, 3, 3.2, 3.1, 3.6, 3.9), Petal.Length = c(1.4, 
                                                                             1.4, 1.3, 1.5, 1.4, 1.7), Petal.Width = c(0.2, 0.2, 0.2, 
class(my_iris)                                                                                                                                                1L), .Label = c("setosa", "versicolor", "virginica"), class = "factor")), row.names = c(NA, 
                                                                                                                                                                                                                                                     6L), class = "data.frame")

# - error message or wrong outcome


## 02 your own ReprEx ####


library(lm)
