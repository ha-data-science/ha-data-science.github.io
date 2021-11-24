# HEADER ####
# Testing the assumption that sampling from plant rows follows Poisson distribution 
# based on real data - position of plant rows measured on New Hopyard in May 2018
# Nov 2021
# PD

# Data preparation ------------------------------------------------------------------------------------------
dt <- read.csv("Plant_distribution_along_rows.csv")

# In the original dataset, there are 7 separate sections of row (limited by tape measure length!) 
# Let's make them into one long row to take our samples from.
# cmc will be a vector of plant positions along row. Unit is centimeter.

cmc <- numeric()
u <- unique(dt$rid)
mx <- 0
av <- numeric(length(u))
for(i in seq_along(u)){
  cmc1 <- dt$cm[dt$rid==u[i]]
  av[i] <- length(cmc1) / max(cmc1)
  cmc1 <- cmc1 + mx
  mx <- max(cmc1)
  cmc <- c(cmc, cmc1)
}
rm(cmc1, i, mx)

length(cmc) # total number of plants
max(cmc) # total length of row in cm

# By the way, let's have a look if the rows that were merged together were reasonably similar.
plot(av, ylim = c(0, mean(av)*2), main = "Average number of plants \nper unit length on the measured rows")
sd(av)/mean(av) # coefficient of variation

# Sampling from real plant rows --------------------------------------------------------------------------------
# Settings
L <- 100 # transect length (in cm!)
N <- 5000 # number of transects
# Simulation
ts <- runif(n = N, min = min(cmc), max = max(cmc)-L) # transect starts evenly and randomly distributed along the row
te <- ts+L # transect ends
x <- numeric(N) # dummy vector for plant counts
for(i in 1:N){ # sampling
  x[i] <- sum(cmc > ts[i] & cmc <= te[i]) # how many plants fall on a transect
}

# Histogram of x
hx <- hist(x, main = "Real distribution", xlim = c(0,20), ylim = c(0, 0.2), breaks = 20, freq = F)
sum(x) # total number of plants on all samples

# Poisson-simulated sampling with real-life mu (= lambda)------------------------------------------------
# Settings
mu <- length(cmc) / max(cmc) # mean number of plants per unit length
m <- mu * L # mean number of plants per transect length
# Simulation (lambda = mean in function rpois)
a <- rpois(n = N, lambda = m)

# Histogram of a
ha <- hist(a, main = "Simulated distribution", xlim = c(0,20), ylim = c(0, 0.2), breaks = 20, freq = F)
sum(a) # total number of plants on all samples

# Comparison ----------------------------------------------------------------------------------------------------
abs(sum(x)-sum(a)) / mean(sum(x), sum(a)) # how the simulated and real number of plants differ
# Compare two graphs 
hh <- data.frame(hx$counts, ha$counts[1:length(hx$counts)])
plot(hh[,1], type="l", ylim = c(0, 1.2*max(hh[,1])))
lines(hh[,2])

rm(list=ls())

# Further examples ----------------------------------------------------------------------------------------------
# 2019 New Hopyard germination survey (EME_NH 2019)
dt <- read.csv("EME NH long.csv")
eme <- dt$EME.raw[dt$SEASON==2019]
heme <- hist(eme, main = "Real EME 2019 distribution", xlim = c(0,50), ylim = c(0, 0.1), breaks = 20, freq = F)

m <- mean(eme)
N <- length(eme)
r <- rpois(n = N, lambda = m)
hr <- hist(r, main = "Simulated distribution, \nlambda = mean(EME 2019)", xlim = c(0,50), ylim = c(0, 0.1), breaks = 20, freq = F)

# 2021 New Hopyard germination survey (EME_NH 2021)
dt <- read.csv("EME NH long.csv")
eme <- dt$EME.raw[dt$SEASON==2021]
heme <- hist(eme, main = "Real EME 2021 distribution", xlim = c(0,30), ylim = c(0, 0.2), breaks = 20, freq = F)
# Zero-inflated Poisson (?) distribution

m <- mean(eme)
N <- length(eme)
r <- rpois(n = N, lambda = m)
hr <- hist(r, main = "Simulated distribution, \nlambda = mean(EME 2021)", xlim = c(0,30), ylim = c(0, 0.2), breaks = 20, freq = F)
