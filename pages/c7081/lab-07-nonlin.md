---
title: ""
author: "Ed Harris"
date: "last edited: 2021-09-20"
output: html_document
---

<center>
![](img/c7081-2021.png)

# C7081 lab 07 Nonlinear models

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

## Lab: Non-linear Modeling

&nbsp;

In this lab, we will analyze `Wage` data, in order to illustrate the fact that many complex non-linear model fitting procedures can be easily implemented in `R`.  We begin by loading the `ISLR2` library, which contains the data.

&nbsp;

```r
library(ISLR2)
attach(Wage)

?Wage
```

&nbsp;

## Polynomial Regression and Step Functions

&nbsp;

We first fit the model using the following command:

&nbsp;

```r
fit <- lm(wage ~ poly(age, 4), data = Wage)

coef(summary(fit))
```

&nbsp;

This syntax fits a linear model, using the `lm()` function, in order to predict `wage` using a fourth-degree polynomial in `age`: `poly(age, 4)`. The `poly()` command allows us to avoid having to write out a long formula with powers of `age`. The function returns a matrix whose columns are a basis of *orthogonal polynomials* , which essentially means that each column is a linear combination of the variables `age`, `age^2`,  `age^3` and `age^4`.

&nbsp;

However, we can also use `poly()` to obtain `age`, `age^2`,  `age^3` and `age^4` directly, if we prefer. We can do this by using the `raw = TRUE` argument to the `poly()` function.
Later we   see that this does not affect the model in a meaningful way---though the choice of basis clearly affects the coefficient estimates, it does not affect the fitted values obtained.

&nbsp;

```r
fit2 <- lm(wage ~ poly(age, 4, raw = T), data = Wage)

coef(summary(fit2))
```

&nbsp;

There are several other equivalent ways of fitting this model, which showcase the flexibility of the formula language in `R`. For example

&nbsp;

```r
fit2a <- lm(wage ~ age + I(age^2) + I(age^3) + I(age^4),
    data = Wage)
    
coef(fit2a)
```

&nbsp;

This simply creates the polynomial basis functions on the fly, taking care to protect terms like `age^2` via the  function `I()` (the `^` symbol has a special meaning in formulas).

&nbsp;

```r
fit2b <- lm(wage ~ cbind(age, age^2, age^3, age^4),
    data = Wage)
```

&nbsp;

This does the same more compactly, using the `cbind()` function for building a matrix from a collection of vectors; any function call such as `cbind()` inside a formula also serves as a wrapper.

&nbsp;

We now create a grid of values for `age` at which we want predictions, and then call the generic `predict()` function, specifying that we want standard errors as well.

&nbsp;

```r
agelims <- range(age)

age.grid <- seq(from = agelims[1], to = agelims[2])

preds <- predict(fit, newdata = list(age = age.grid),
    se = TRUE)
    
se.bands <- cbind(preds$fit + 2 * preds$se.fit,
    preds$fit - 2 * preds$se.fit)
```

&nbsp;

Finally, we plot the data and add the fit from the degree-4 polynomial.

&nbsp;

```r
par(mfrow = c(1, 2), mar = c(4.5, 4.5, 1, 1),
    oma = c(0, 0, 4, 0))
    
plot(age, wage, xlim = agelims, cex = .5, col = "darkgrey")

title("Degree-4 Polynomial", outer = T)

lines(age.grid, preds$fit, lwd = 2, col = "blue")

matlines(age.grid, se.bands, lwd = 1, col = "blue", lty = 3)
```

&nbsp;

Here the `mar` and `oma` arguments to `par()` allow us to control the margins of the plot, and the `title()` function creates a figure title that spans both subplots.

&nbsp;

We mentioned earlier that whether or not an orthogonal set of basis functions is produced in the `poly()` function will not affect the model obtained in a meaningful way. What do we mean by this? The fitted values obtained in either case are identical:

&nbsp;

```r
preds2 <- predict(fit2, newdata = list(age = age.grid),
    se = TRUE)
    
max(abs(preds$fit - preds2$fit))
```

&nbsp;

In performing a polynomial regression we must decide on the degree of the polynomial to use. One way to do this is by using hypothesis tests. We now fit models ranging from linear to a degree-5 polynomial and seek to determine the simplest model which is sufficient to explain the relationship between `wage` and `age`. We use the `anova()` function, which performs an \define{analysis of  variance} (ANOVA, using an F-test) in order to test the null hypothesis that a model $\mathcal{M}_1$ is sufficient to explain the data against the alternative hypothesis that a more complex model $\mathcal{M}_2$ is required. In order to use the `anova()` function, $\mathcal{M}_1$ and $\mathcal{M}_2$ must be *nested* models: the predictors in $\mathcal{M}_1$ must be a subset of the predictors in $\mathcal{M}_2$. In this case, we fit five different models and sequentially compare the simpler model to the more complex model.

&nbsp;

```r
fit.1 <- lm(wage ~ age, data = Wage)
fit.2 <- lm(wage ~ poly(age, 2), data = Wage)
fit.3 <- lm(wage ~ poly(age, 3), data = Wage)
fit.4 <- lm(wage ~ poly(age, 4), data = Wage)
fit.5 <- lm(wage ~ poly(age, 5), data = Wage)

anova(fit.1, fit.2, fit.3, fit.4, fit.5)
```

&nbsp;

The p-value comparing the linear `Model 1` to the quadratic `Model 2` is essentially zero ($<$$10^{-15}$), indicating that a linear fit is not sufficient. Similarly the p-value comparing the quadratic  `Model 2` to the cubic `Model 3` is very low ($0.0017$), so the quadratic fit is also insufficient. The p-value comparing the cubic and degree-4 polynomials, `Model 3` and `Model 4`, is approximately $5\,\%$ while the degree-5 polynomial `Model 5` seems unnecessary because its
p-value is $0.37$. Hence, either a cubic or a quartic polynomial appear to provide a reasonable fit to the data, but lower- or higher-order models are not justified.

&nbsp;

In this case, instead of using the `anova()` function, we could have obtained these p-values more succinctly by exploiting the fact that `poly()` creates orthogonal polynomials.

&nbsp;

```r
coef(summary(fit.5))
```

&nbsp;

Notice that the p-values are the same, and in fact the square of the  $t$-statistics are equal to the F-statistics from the `anova()` function; for example:

&nbsp;

```r
(-11.983)^2 # Mind blown
```

&nbsp;

However, the ANOVA method works whether or not we used orthogonal polynomials; it also works when we have other terms in the model as well. For example, we can use `anova()` to compare these three models:

&nbsp;

```r
fit.1 <- lm(wage ~ education + age, data = Wage)
fit.2 <- lm(wage ~ education + poly(age, 2), data = Wage)
fit.3 <- lm(wage ~ education + poly(age, 3), data = Wage)
anova(fit.1, fit.2, fit.3)
```


&nbsp;

As an alternative to using hypothesis tests and ANOVA, we could choose the polynomial degree using  cross-validation (James et al. 2021 Ch 05).

&nbsp;

Next we consider the task of predicting whether an individual earns more than $250{,}000$ per year. We proceed much as before, except that first we create the appropriate response vector, and then apply the `glm()` function using `family = "binomial"` in order to fit a polynomial logistic regression model.

&nbsp;

```r
fit <- glm(I(wage > 250) ~ poly(age, 4), data = Wage,
    family = binomial)
```

&nbsp;

Note that we again use the wrapper `I()` to create this binary response variable on the fly. The expression `wage > 250` evaluates to a logical variable containing `TRUE`s and `FALSE`s, which `glm()` coerces to binary by setting the `TRUE`s to 1 and the `FALSE`s to 0.

&nbsp;

Once again, we make predictions using the `predict()` function.

&nbsp;

```r
preds <- predict(fit, newdata = list(age = age.grid), se = T)
```

However, calculating the confidence intervals is slightly more involved than in the linear regression case.

&nbsp;

The default prediction type for a `glm()` model is `type = "link"`, which is what we use here.  This means we get predictions for the *logit* , or log-odds: that is, we have fit a model of the form

&nbsp;

\[
\log\left(\frac{\Pr(Y=1|X)}{1-\Pr(Y=1|X)}\right)=X\beta,
\]

&nbsp;

and the predictions given are of the form $X\hat\beta$.  The standard errors given are also for  

&nbsp;

$X\hat\beta$

&nbsp;

In order to obtain confidence intervals for $\Pr(Y=1|X)$, we use the transformation

&nbsp;

\[
\Pr(Y=1|X)=\frac{\exp(X\beta)}{1+\exp(X\beta)}.
\]

&nbsp;

```r
pfit <- exp(preds$fit) / (1 + exp(preds$fit))

se.bands.logit <- cbind(preds$fit + 2 * preds$se.fit,
    preds$fit - 2 * preds$se.fit)
    
se.bands <- exp(se.bands.logit) / (1 + exp(se.bands.logit))
```

&nbsp;

Note that we could have directly computed the probabilities by selecting the `type = "response"` option in the `predict()` function.

&nbsp;

```r
preds <- predict(fit, newdata = list(age = age.grid),
    type = "response", se = T)
```

&nbsp;

However, the corresponding confidence intervals would not have been sensible because we would end up with negative probabilities!

Finally, the right-hand plot from Figure 7.1 was made as follows:

&nbsp;

```r
plot(age, I(wage > 250), xlim = agelims, type = "n",
    ylim = c(0, .2))
    
points(jitter(age), I((wage > 250) / 5), cex = .5, pch = "|", col = "darkgrey")

lines(age.grid, pfit, lwd = 2, col = "blue")

matlines(age.grid, se.bands, lwd = 1, col = "blue", lty = 3)
```

&nbsp;

We have drawn  the `age` values corresponding to the observations with `wage` values above $250$ as gray marks on the top of the plot, and those with `wage` values below $250$ are shown as gray marks on the bottom of the plot. We used the `jitter()` function to jitter the `age` values a bit so that observations with the same `age` value do not cover each other up. This is often called a .

&nbsp;

In order to fit a step function, as discussed in Section 7.2, we use the `cut()` function.

&nbsp;

```r
table(cut(age, 4))

fit <- lm(wage ~ cut(age, 4), data = Wage)

coef(summary(fit))
```

&nbsp;

Here `cut()` automatically picked the cutpoints at $33.5$, $49$, and $64.5$~years of age. We could also have specified our own cutpoints directly using the `breaks` option.

&nbsp;

The function `cut()` returns an ordered categorical variable ; the `lm()` function then creates a set of dummy variables for use in the regression. The `age < 33.5` category is left out, so the intercept coefficient of $94{,}160$ can be interpreted as the average salary for those under $33.5$~years of age, and the other coefficients can be interpreted as the average additional salary for those in the other age groups.

&nbsp;

We can produce predictions and plots just as we did in the case of the polynomial fit.


&nbsp;

In order to fit regression splines in `R`, we use the `splines` library.
In Section 7.4, we saw that regression splines can be fit by constructing an appropriate matrix of basis functions.

&nbsp;

The `bs()` function generates the entire matrix of basis functions for splines with the specified set of knots. By default, cubic splines are produced. Fitting `wage` to `age` using a regression spline is simple:

&nbsp;

```r
library(splines)

fit <- lm(wage ~ bs(age, knots = c(25, 40, 60)), data = Wage)

pred <- predict(fit, newdata = list(age = age.grid), se = T)

plot(age, wage, col = "gray")
lines(age.grid, pred$fit, lwd = 2)
lines(age.grid, pred$fit + 2 * pred$se, lty = "dashed")
lines(age.grid, pred$fit - 2 * pred$se, lty = "dashed")
```

&nbsp;

Here we have prespecified knots at ages $25$, $40$, and $60$. This produces a spline with six basis functions. (Recall that a cubic spline with three knots has seven degrees of freedom; these degrees of freedom are used up by an intercept, plus six basis functions.) We could also use the `df` option to produce a spline with knots at uniform quantiles of the data.

&nbsp;

```r
dim(bs(age, knots = c(25, 40, 60)))
dim(bs(age, df = 6))
attr(bs(age, df = 6), "knots")
```

&nbsp;

In this case `R` chooses knots at ages $33.8, 42.0$, and $51.0$, which correspond to the 25th, 50th, and 75th percentiles of `age`. The function `bs()` also has a `degree` argument, so we can fit splines of any degree, rather than the default degree of 3 (which yields a cubic spline).  

&nbsp;

In order to instead fit a natural spline, we use the `ns()` function. 
Here we fit a natural spline with four degrees of freedom.

&nbsp;

```r
fit2 <- lm(wage ~ ns(age, df = 4), data = Wage)

pred2 <- predict(fit2, newdata = list(age = age.grid),
     se = T)
     
plot(age, wage, col = "gray")
lines(age.grid, pred2$fit, col = "red", lwd = 2)
```

&nbsp;

As with the `bs()` function, we could instead specify the knots directly using the `knots` option.

&nbsp;

In order to fit a smoothing spline, we use the `smooth.spline()` function. Figure 7.8  was produced with the following code:

&nbsp;

```r
plot(age, wage, xlim = agelims, cex = .5, col = "darkgrey")
title("Smoothing Spline")

fit <- smooth.spline(age, wage, df = 16)
fit2 <- smooth.spline(age, wage, cv = TRUE)
fit2$df

lines(fit, col = "red", lwd = 2)
lines(fit2, col = "blue", lwd = 2)
legend("topright", legend = c("16 DF", "6.8 DF"),
    col = c("red", "blue"), lty = 1, lwd = 2, cex = .8)
```

&nbsp;

Notice that in the first call to `smooth.spline()`, we specified `df = 16`. The function then  determines which value of $\lambda$  leads to $16$ degrees of freedom.

&nbsp;

In the second call to `smooth.spline()`, we select the smoothness level by cross-validation;
 this results in a value of $\lambda$ that yields 6.8 degrees of freedom.

&nbsp;

In order to perform local regression, we use the `loess()` function. 
&nbsp;


```r
plot(age, wage, xlim = agelims, cex = .5, col = "darkgrey")
title("Local Regression")

fit <- loess(wage ~ age, span = .2, data = Wage)
fit2 <- loess(wage ~ age, span = .5, data = Wage)

lines(age.grid, predict(fit, data.frame(age = age.grid)),
    col = "red", lwd = 2)
lines(age.grid, predict(fit2, data.frame(age = age.grid)),
    col = "blue", lwd = 2)
    
legend("topright", legend = c("Span = 0.2", "Span = 0.5"),
    col = c("red", "blue"), lty = 1, lwd = 2, cex = .8)
```

&nbsp;

Here we have performed local linear regression using spans of $0.2$ and $0.5$: that is, each neighborhood consists of 20\,\% or 50\,\% of the observations. The larger the span, the smoother the fit.

&nbsp;

The `locfit` library can also be used for fitting local regression models in `R`.

&nbsp;

## GAMs

&nbsp;

We now fit a GAM to predict `wage` using natural spline functions of `lyear` and `age`,  treating `education` as a qualitative predictor, as in (7.16). Since this is just a big linear regression model using an appropriate choice of basis functions, we can simply do this using the `lm()` function.

&nbsp;

```r
gam1 <- lm(wage ~ ns(year, 4) + ns(age, 5) + education,
    data = Wage)
```

&nbsp;

We now fit the model (7.16) using smoothing splines rather than natural splines.  In order to fit more general sorts of GAMs, using smoothing splines or other components that cannot be expressed in terms of basis functions and then fit using least squares regression, we will need to use the `gam` library in `R`.

&nbsp;

The `s()` function, which is part of the `gam` library, is used to indicate that we would like to use a smoothing spline. We specify that the function of `lyear` should have $4$ degrees of freedom, and that the function of `age` will have $5$ degrees of freedom. Since `education` is qualitative, we leave it as is, and it is converted into four dummy variables. We use the `gam()` function in order to fit a GAM using these components.

&nbsp;

All of the terms in (7.16) are fit simultaneously, taking each other into account to explain the response.

&nbsp;


```r
library(gam)
gam.m3 <- gam(wage ~ s(year, 4) + s(age, 5) + education,
    data = Wage)
```

&nbsp;

In order to produce  Figure 7.12, we simply call the `plot()` function:

&nbsp;

```r
par(mfrow = c(1, 3))
plot(gam.m3, se = TRUE, col = "blue")
```

&nbsp;

The generic `plot()` function recognizes that `gam.m3` is an object of class `Gam`, and invokes the appropriate `plot.Gam()` method.  Conveniently, even though   `gam1` is not of class `Gam` but rather of class `lm`, we can {\em  still} use `plot.Gam()` on it.  

&nbsp;

```r
plot.Gam(gam1, se = TRUE, col = "red")
```

&nbsp;

Notice here we had to use `plot.Gam()` rather than the *generic* `plot()` function.

&nbsp;

In these plots, the function of `lyear` looks rather linear. We can perform a series of ANOVA tests in order to determine which of these three models is best:  a GAM that excludes `lyear` ($\mathcal{M}_1$),  a GAM that uses a linear function of `lyear` ($\mathcal{M}_2$), or  a GAM that uses a spline function of `lyear` ($\mathcal{M}_3$).

&nbsp;

```r
gam.m1 <- gam(wage ~ s(age, 5) + education, data = Wage)
gam.m2 <- gam(wage ~ year + s(age, 5) + education,
    data = Wage)
    
anova(gam.m1, gam.m2, gam.m3, test = "F")
```

&nbsp;

We find that there is compelling evidence that a GAM with a linear function of `lyear` is better than a GAM that does not include `lyear` at all \hbox{(p-value\,=\,0.00014).} However, there is no evidence that a non-linear function of `lyear` is needed (p-value\,=\,0.349).

&nbsp;

In other words, based on the results of this ANOVA, $\mathcal{M}_2$ is preferred.

&nbsp;

The `summary()` function produces a summary of the gam fit.

&nbsp;

```r
summary(gam.m3)
```

&nbsp;

The "Anova for Parametric Effects" p-values clearly demonstrate that `year`, `age`, and `education` are all highly statistically significant, even when only assuming a linear relationship. Alternatively, the "Anova for Nonparametric Effects" p-values for `year` and `age` correspond to a null hypothesis of a linear relationship versus the alternative of a non-linear relationship. The large p-value for `year` reinforces our conclusion from the ANOVA test that a linear function is adequate for this term. However, there is very clear evidence that a non-linear term is required for `age`.

&nbsp;

We can make predictions using the `predict()` method for the class `Gam`.  Here we make predictions on the training set.

&nbsp;

```r
preds <- predict(gam.m2, newdata = Wage)
```

&nbsp;

We can also use local regression fits as building blocks in a GAM, using the `lo()` function.

&nbsp;

```r
gam.lo <- gam(
    wage ~ s(year, df = 4) + lo(age, span = 0.7) + education,
    data = Wage
  )
  
plot.Gam(gam.lo, se = TRUE, col = "green")
```

&nbsp;

Here we have used local regression for the `age` term, with a span of
$0.7$. We can also use the `lo()` function to create interactions before calling the `gam()` function. For example,

&nbsp;

```r
gam.lo.i <- gam(wage ~ lo(year, age, span = 0.5) + education,
    data = Wage)
```

&nbsp;

fits a two-term model, in which the first term is an interaction between `lyear` and `age`, fit by a local regression surface. We can plot the resulting two-dimensional surface if we first install the `akima` package.

&nbsp;

```r
library(akima)

plot(gam.lo.i)
```

&nbsp;

In order to fit a logistic regression GAM, we once again use the `I()` function in constructing the binary response variable, and set `family=binomial`.

&nbsp;

```r
gam.lr <- gam(
    I(wage > 250) ~ year + s(age, df = 5) + education,
    family = binomial, data = Wage
  )
  
par(mfrow = c(1, 3))
plot(gam.lr, se = T, col = "green")
```

&nbsp;

It is easy to see that there are no high earners in the `< HS` category:

&nbsp;

```r
table(education, I(wage > 250))
```

&nbsp;

Hence, we fit a logistic regression GAM using all but this category. This provides more sensible results.

&nbsp;

```r
gam.lr.s <- gam(
    I(wage > 250) ~ year + s(age, df = 5) + education,
    family = binomial, data = Wage,
    subset = (education != "1. < HS Grad")
  )
  
plot(gam.lr.s, se = T, col = "green")
```

&nbsp;

&nbsp;

&nbsp;



