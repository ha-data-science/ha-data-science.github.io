---
title: ""
author: "Ed Harris"
date: "last edited: 2021-09-20"
output: html_document
---

<center>
![](img/c7081-2021.png)

# C7081 lab 02 R review
</center>

&nbsp;

Material for C7081 labs follows the spirit and select content of:

[James, G., Witten, D., Hastie, T., Tibshirani, R., 2021. An Introduction to Statistical Learning: with Applications in R, Springer Texts in Statistics 2ed. Springer-Verlag, New York.](https://www.statlearning.com/)

&nbsp;

### Recommendations

- Use a formal, reproducible R script to solve each lab

- Start with a simple [template script](files/script-template.R)

- Type 100% of your own code and do not copy and paste any code

&nbsp;

## Basic Commands

`R` uses *functions* to perform operations. To run a function called `funcname`, we type `funcname(input1, input2)`, where the inputs (or *arguments*) `input1` and `input2` tell `R`
 how to run the function. A function can have any number of inputs. For example, to create a vector of numbers, we use the function `c()` (for *concatenate*). Any numbers inside the parentheses are joined together. The following  command instructs `R` to join together the numbers 1, 3, 2, and 5, and to save them as a vector  named `x`. When we type `x`, it gives us back the vector.

&nbsp;

```r
# Try this:

# assign a vector to a variable and print it
x <- c(1, 3, 2, 5)
x
```

&nbsp;

We can also save things using `=` rather than `<-` (NB using `=` does not conform to recommended R code style, but it is possible):

&nbsp;

```r
# Try this:

# Use of = for assignment works, but is poor R form
x = c(1, 6, 2)
x
y = c(1, 4, 3)
y
```

&nbsp;

Hitting the *up* arrow while your cursor is in the R Console command line will display previous commands, which can then be edited. This is useful since one often wishes to repeat a similar command. In addition, typing `?funcname` will always cause `R` to open a new help file window with additional information about the function `funcname()`.

&nbsp;

We can tell `R` to add two sets of numbers together. It will then add the first number from `x` to the first number from `y`, and so on. However, `x` and `y` should be the same length.

We can check their length using the `length()` function.

&nbsp;

```r
# Try this:

length(x)
length(y)
x + y
```


The `ls()` function allows us to look at a list of all of the objects, such as data and functions, that we have saved so far in the R Global Environment (i.e., in the memory space for this R session). The `rm()` function can be used to specify and delete any that we don't want.

&nbsp;

```r
# Try this:

ls()
rm(x, y)
ls()
```
&nbsp;

It's also possible to remove all objects at once:

```r
# Try this

rm(list = ls())

# Do you think this is a safe practice?  
# If unsure, make sure you are sure before going on (i.e., discuss)!

```

&nbsp;

The `matrix()` function can be used to create a matrix of numbers.
Before we use the `matrix()` function, we can learn more about it:

&nbsp;

```r
# Same as help(matrix):

?matrix

# Tip: with your cursor in a function name in a script, 
# hitting 'F1' will also bring up the help menue for the function

```

&nbsp;

The help file reveals that the `matrix()` function takes a number of inputs, but for now we focus on the first three: the data (the entries in the matrix), the number of rows, and the number of columns.
First, we create a simple matrix.

&nbsp;

```r
x <- matrix(data = c(1, 2, 3, 4), 
            nrow = 2, 
            ncol = 2)
x
```

&nbsp;

Note that we could just as well omit typing the argument names  `data=`, `nrow=`, and `ncol=` in the `matrix()` command above: that is, we could just type

&nbsp;


```r
# Is this better than the previous chunk?
x <- matrix(c(1, 2, 3, 4), 2, 2)
```

&nbsp;

Although this chunk would have the same output, it is sometimes be useful to specify the names of the arguments passed in,  since otherwise `R` will assume that the function arguments are passed into the function in the same order that is given in the function's help file. As this example illustrates, by default `R` creates matrices by successively filling in columns. Alternatively, the `byrow = TRUE` option can be used to populate the matrix in order of the rows.

&nbsp;

```r
matrix(c(1, 2, 3, 4), 2, 2, byrow = TRUE)
```

&nbsp;

Notice that in the above command we did not assign the matrix to a value such as `x`. In this case the matrix is printed to the screen but is not saved for future calculations.
The `sqrt()` function returns the square root of each element of a vector or matrix. The command
`x^2` raises each element of `x` to the power `2`; any powers are possible, including fractional or negative powers.

&nbsp;


```r
sqrt(x)
x^2
```

&nbsp;

The `rnorm()` function generates a vector of random Gaussian variables, with first argument `n` the sample size.  Each time we call this function, we will get a different answer. Here we create two correlated sets of numbers, `x` and `y`, and use the `cor()` function to compute the correlation between them.

&nbsp;

```r
x <- rnorm(50)
y <- x + rnorm(50, mean = 50, sd = .1)
cor(x, y)
```

&nbsp;

By default, `rnorm()` creates standard Gaussian random variables with a mean of $0$ and a standard deviation of $1$. However, the mean and standard deviation can be altered using the `mean` and `sd` arguments, as illustrated above. Sometimes we want our code to reproduce the exact same set of random numbers; we can use the `set.seed()` function to do this. The `set.seed()` function takes an (arbitrary) integer argument.

&nbsp;

```r
Try this:

rnorm(50) # a vector
rnorm(50) # a different vector...?

set.seed(42)
rnorm(50) # a vector
set.seed(42)
rnorm(50) # same vector!

```

&nbsp;

We use `set.seed()` whenever we perform calculations involving random quantities. In general this should allow the user to reproduce our results. 

The `mean()` and `var()` functions can be used to compute the mean and variance of a vector of numbers. Applying `sqrt()` to the output of `var()` will give the standard deviation. Or we can simply use the `sd()` function.

&nbsp;

```r
set.seed(3)
y <- rnorm(100)
mean(y)
var(y)
sqrt(var(y))
sd(y)
```
&nbsp;


## Graphics

&nbsp;

The `plot()` function is the primary way to plot data in `R`. For instance, `plot(x, y)` produces a scatterplot of the numbers in `x` versus the numbers in `y`. There are many additional options that can be passed in to the `plot()` function. For example, passing in the argument `xlab` will result in a label on the $x$-axis. To find out more information about the `plot()` function, type `?plot`.

&nbsp;

```r
x <- rnorm(100)
y <- rnorm(100)
plot(x, y)
plot(x, y, 
     xlab = "This is the x-axis",
     ylab = "This is the y-axis",
     main = "Plot of X vs Y")
```

&nbsp;

We will often want to save the output of an `R` plot. The command that we use to do this will depend on the file type that we would like to create. For instance, to create a pdf, we use the `pdf()` function, and to create a jpeg, we use the `jpeg()` function.

&nbsp;

```r
pdf("Figure.pdf")  # 'opens' output to file 
plot(x, y, col = "green")
dev.off() # 'closes output to file and saves to working directory

# PS, you did set your working directory, didn't you? setwd()
```

&nbsp;

The function `dev.off()` indicates to `R` that we are done creating the plot. Alternatively, we can simply copy the plot window and paste it into an appropriate file type, such as a Word document (but this is not part of a reproducible workflow).

&nbsp;

The function `seq()` can be used to create a sequence of numbers. For instance, `seq(a, b)` makes a vector of integers between `a` and `b`. There are many other options: for instance,  `seq(0, 1, length = 10)` makes a sequence of `10` numbers that are equally spaced between `0` and `1`. Typing `3:11` is a shorthand for `seq(3, 11)` for integer arguments.

&nbsp;

```r
x <- seq(1, 10)
x
x <- 1:10
x
x <- seq(-pi, pi, length = 50)
x
```

&nbsp;

We will now create some more sophisticated plots. The `contour()` function can be used to represent three-dimensional data like a topographical map.

&nbsp;

`contour()` takes three arguments:
 
 * A vector of the `x` values (the first dimension),
 * A vector of the `y` values (the second dimension), and
 * A matrix whose elements correspond
 to the `z` value (the third dimension) for each pair of (`x`, `y`) coordinates.

&nbsp;

As with the  `plot()` function, there are many other inputs that can be used to fine-tune the output of the `contour()` function. To learn more about these, take a look at  the help file by typing `?contour`.

&nbsp;

```r
y <- x
f <- outer(x, y, function(x, y) cos(y) / (1 + x^2))
contour(x, y, f)
contour(x, y, f, nlevels = 45, add = T)
fa <- (f - t(f)) / 2
contour(x, y, fa, nlevels = 15)
```

&nbsp;

The `image()` function works the same way as `contour()`, except that it produces a color-coded plot whose colors depend on the `z` value. This is is sometimes used to plot temperature in weather forecasts. Alternatively, `persp()` can be used to produce a three-dimensional plot.

&nbsp;

The arguments `theta` and `phi` control the angles at which the plot is viewed.

&nbsp;

```{r chunk18}
image(x, y, fa)
persp(x, y, fa)
persp(x, y, fa, theta = 30)
persp(x, y, fa, theta = 30, phi = 20)
persp(x, y, fa, theta = 30, phi = 70)
persp(x, y, fa, theta = 30, phi = 40) # Mind blown
```

&nbsp;

## Indexing Data

&nbsp;

We often wish to examine part of a set of data. Suppose that our data is stored in the matrix `A`.

&nbsp;

```r
A <- matrix(1:16, 4, 4)
A
```

&nbsp;

Then, typing

&nbsp;

```r
A[2, 3]
```

&nbsp;

will "slice out" the element corresponding to the second row and the third column. The first number after the open-bracket symbol `[` always refers to the row, and the second number always refers to the column. We can also select multiple rows and columns at a time, by providing vectors as the indices.

&nbsp;


```r
# Flexible slicing
A[c(1, 3), c(2, 4)]
A[1:3, 2:4]
A[1:2, ]
A[, 1:2]
```

&nbsp;

The last two examples include either no index for the columns or no index for the rows. These  indicate that `R` should include all columns or all rows, respectively. `R` treats a single row or column of a matrix as a vector.

&nbsp;

```r
A[1, ]
```

&nbsp;

The use of a negative sign `-` in the index tells `R` to keep all rows or columns except those indicated in the index.

&nbsp;

```r
A[-c(1, 3), ]
A[-c(1, 3), -c(1, 3, 4)]
```

&nbsp;

The `dim()` function outputs the number of rows followed by the number of columns of a given matrix.

&nbsp;

```r
dim(A)
```

&nbsp;

## Loading Data

&nbsp;

For most analyses, the first step involves importing a data set into `R`. The `read.table()` function is one of the primary ways to do this, along with `read.csv`, `read.xlsx` from `{openxlsx}`, etc. The `help()` function can be used to find details about how to use these functions.

&nbsp;

We can use the function `write.table()` to export data to a file.

&nbsp;

Before attempting to load a data set, we must make sure that `R` knows to search for the data in the proper directory. For example, on a Windows system one could select the directory using the
`Change dir ...` option under the `File` menu. However, the details of how to do this depend on the operating system (e.g. Windows, Mac, Unix) that is being used, and so we do not give further details here.

&nbsp;

We begin by loading in the `Auto` data set. This data is part of the `ISLR2` library.

&nbsp;

To illustrate the `read.table()` function, we load it now from a text file, `Auto.data`, which you can find on the textbook website.
 The following command will load the `Auto.data` file into `R` and store it as an object called `Auto`,  in a format referred to as a .  Once the data has been loaded, the `View()` function can be used to view it in a spreadsheet-like window. (*This function can sometimes be a bit finicky. If you have trouble using it, then try the `head()` function instead.*) The `head()` function can also be used to view the first few rows of the data.

&nbsp;

```r
# Try this:

# You may need to install the package ISLR2
# install.packages('ISLR2')

library(ISLR2)

# Run these lines one at a time
data(Auto) # load Auto data from the ISLR2 package
help(Auto)
View(Auto)
head(Auto)
```

&nbsp;

```r
dim(Auto)
```

&nbsp;

The `dim()` function tells us that the data has $392$ observations, or rows, and nine variables, or columns. 

&nbsp;

Once the data are loaded , we can use `names()` to check the variable names.

&nbsp;

```r
names(Auto)
```

&nbsp;

## Graphical and Numerical Summaries

&nbsp;

We can use the `plot()` function to produce *scatterplots*  of the quantitative variables. However, simply typing the variable names will produce an error message,  because `R` does not know to look in the `Auto` data set for those variables.

&nbsp;

```r
# the passive agressive butler says no
plot(cylinders, mpg)
```

&nbsp;

To refer to a variable, we must type the data set and the variable name  joined with a \textR{\$} symbol.  Alternatively, we can use the `attach()` function in order to tell `R` to make the variables in this data frame available by name. 

&nbsp;

```r
# This works
plot(Auto$cylinders, Auto$mpg)

# This works too
attach(Auto)
plot(cylinders, mpg)
```

The `cylinders` variable is stored as a numeric vector, so `R` has treated it as quantitative. However, since there are only a small number of possible values for `cylinders`, one may prefer to treat it as a qualitative variable. The `as.factor()` function converts quantitative variables into qualitative variables.

&nbsp;

```r
# The reason why factors versus numerical format are important and different 
# is technical and to do with statistical modelling

cylinders <- as.factor(cylinders)
```

&nbsp;

If the variable plotted on the $x$-axis is qualitative, then  *boxplots* will  automatically be produced by the `plot()` function.  As usual, a number of options can be specified in order to customize the plots.

&nbsp;

```r
plot(cylinders, mpg)
plot(cylinders, mpg, col = "red")
plot(cylinders, mpg, col = "red", varwidth = T)
plot(cylinders, mpg, col = "red", varwidth = T,
    horizontal = T)
plot(cylinders, mpg, col = "red", varwidth = T,
    xlab = "cylinders", ylab = "MPG")
```

&nbsp;

The `hist()` function can be used to plot a . Note that `col = 2` has the same effect as `col = "red"`.

&nbsp;

```r
hist(mpg)
hist(mpg, col = 2)
hist(mpg, col = 2, breaks = 15)
```

&nbsp;

The `pairs()` function creates a *scatterplot matrix*, i.e. a scatterplot for every pair of variables. We can also produce scatterplots for just a subset of the variables. This is good for a fast variable and data inspection of data.

&nbsp;

```r
pairs(Auto)
pairs(
    ~ mpg + displacement + horsepower + weight + acceleration,
    data = Auto
  )
```

&nbsp;

In conjunction with the `plot()` function,  `identify()` provides a useful interactive method for identifying the value of a particular variable for points on a plot. We pass in three arguments to `identify()`: the $x$-axis variable, the $y$-axis variable, and the variable whose values we would like to see printed for each point. Then clicking one or more  points in the plot and hitting Escape will cause `R` to print the values of the variable of interest. The numbers printed under the `identify()` function correspond to the rows for the selected points.

&nbsp;


```r
plot(horsepower, mpg)
identify(horsepower, mpg, name)
```

&nbsp;

The `summary()` function produces a numerical summary of each variable in a particular data set.

&nbsp;

```r
summary(Auto)
```

&nbsp;

For qualitative variables such as `name`,  `R` will list the number of observations that fall in each category. We can also produce a summary of just a single variable.

&nbsp;


```r
summary(mpg)
```

&nbsp;


Once we have finished using `R`, we can type `q()` in order to shut it down, or quit. When exiting `R`, we have the option to save the current so that all data objects (such as data sets) that we have created in this `R` session will be available next time.  Before exiting `R`, we may want to save a record of all of the commands that we typed in the most recent session; this can be accomplished using the `savehistory()` function. Next time we enter `R`, we can load that history using
the `loadhistory()` function, if we wish. 


&nbsp;

&nbsp;

&nbsp;

