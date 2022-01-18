## HEADER ####
## What: HARUG Data viz Xmas edition
## Who: Last edited by Ed H
## When: Last edited 2021-12-15


## CONTENTS ####
## 00 Setup
## 01 Data EDA
## 02 Colour munging
## 02 Figure 1


## 00 Setup ####

# Get the Data
# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

library(tidyverse)
library(png)

# Ed work PC
setwd(r'(D:\Dropbox\git-hads\ha-data-science.github.io\pages\harug-files\2021-12-15-data-viz)')

spidata <- tidytuesdayR::tt_load('2021-12-07')
spiders <- spidata$spiders

## 01 Data EDA ####
summary(spiders$year)
2021-1757

spiders$year[which(spiders$author == 'Linnaeus')]

myseq <- seq(from = 1, to = (2021-1757), by = 20)
barplot(count(spiders, year)$n)
axis(side = 1, at =  myseq, las = 2,
     labels = c(1757:2021)[myseq])


x <- barplot(count(spiders, year)$n,
        col = rep(c('goldenrod', 'blue'), each = 4),
        ylab = '# Species per year')
axis(side = 1, at =  x, las = 2,
     labels = sort(unique(spiders$year)), cex.axis=.5)
mtext(side = 1, line = 2, at = 140, 
      text = 'Year of \'discovery\'')

pic <- readPNG('img/spi-right.png')
dim(pic)
rasterImage(pic, xleft = 190, xright = 240,
            ybottom = 400, ytop = 800)


## 02 Colour munging ####

library(RColorBrewer)
par(mar=c(3,4,2,2))
display.brewer.all()
par(mar=c(5,4,2,2)+.1)


edcol <- brewer.pal(n=9, 'Set1')[c(1,3,6)]

x<-barplot(count(spiders, year)$n,
           col = rep(edcol, each = 4),
           ylab = '# Species per year')
axis(side = 1, at =  x, las = 2,
     labels = sort(unique(spiders$year)), cex.axis=.5)
mtext(side = 1, line = 2, at = 140, 
      text = 'Year of \'discovery\'')

rasterImage(pic, xleft = 190, xright = 240,
            ybottom = 400, ytop = 800)


## 02 Figure 1 ####
unique(spiders$family)
table(spiders$family)
count(spiders, family)$n
spct <- count(spiders, family)
spct <- arrange(spct, n)

par(mar = c(4,6,0,1))
names <- barplot(log(spct$n)+1,
                 col = rep(edcol[1:2], each = 5),
                 horiz = T)
axis(side = 2, at = names, labels = spct$family, 
     las = 2, cex.axis = .4)
mtext(text = 'Spider family name', side = 2, line = 4.5)
mtext(text = '# Species (log)', side = 1, line = 2)


pic2 <- readPNG('img/spi-down.png') # so cute it hurts
dim(pic2)
rasterImage(pic2, xleft = 5.92, xright = 6.92,
            ybottom = 38, ytop = 52)

arrows(x0 = 6.4, x1 = 6.4,
       y0 = 50, y1 = 107,
       length = 0)


# Maybe one of them there polar barplots
# https://www.r-graph-gallery.com/295-basic-circular-barplot.html

ggplot(spct, aes(x = as.factor(family)), y = log(n)) +
    geom_bar(stat = "identity", fill = alpha(edcol[1], 0.3), aes(y=n)) +
  ylim(-500, 1000) +
  coord_polar() + 
  theme_minimal() + 
  theme(
    axis.title = element_blank(),
    panel.grid = element_blank(),
    plot.margin = unit(rep(0,4), "cm")     
  )


