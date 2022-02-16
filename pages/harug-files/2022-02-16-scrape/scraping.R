## HEADER ####
## Who: EdH
## What: HARUG! web scraping for files
## when: 2022-02-16 


## CONTENTS ####
## 00 Setup
## 01 Experiment 1
## 02 Experiment 2
## References

## 00 Setup ####
setwd(r'(D:\Dropbox\git-hads\ha-data-science.github.io\pages\harug-files\2022-02-16-scrape)')

# d/l data from https://modern-slavery-statement-registry.service.gov.uk/

d1 <- read.csv('data/StatementSummaries2020.csv')
d2 <- read.csv('data/StatementSummaries2021.csv')
d3 <- read.csv('data/StatementSummaries2022.csv')

dat <- rbind(d1,d2,d3)

## 01 Experiment 1 D/L a pdf ####

# get a url
dat$StatementURL[1] # no pdf

# peek at https://www.flyedelweiss.com/DE/about-edelweiss/responsibility/Pages/uk-modern-slavery-statement.aspx
test <- dat$StatementURL[1]
download.file(url = test, destfile = 'pdfs/test.aspx')


# get a url with a pdf
?grep
test <- dat$StatementURL[grep('.pdf', dat$StatementURL)[1]] # bad url?

# download a pdf
download.file(url = test, destfile = 'pdfs/test.pdf')


# try again 
test <- dat$StatementURL[grep('.pdf', dat$StatementURL)[2]] # bad url?


# download a pdf
download.file(url = test, destfile = 'pdfs/test.pdf')


# try again 
test <- d3$StatementURL[grep('.pdf', d3$StatementURL)[1]] 


# download a pdf
download.file(url = test, 
              destfile = 'pdfs/test.pdf',
              method = 'wininet',
              mode = 'wb')

## 02 Experiment 2 D/L several pdfs

n <- 3 # some number
for(i in 1:n){
  test <- d3$StatementURL[grep('.pdf', d3$StatementURL)][i]
  download.file(url = test, 
                destfile = paste('pdfs/', i, '.pdf', sep = ''),
                method = 'wininet',
                mode = 'wb')
  Sys.sleep(1)
}


## References ####
# https://statisticsglobe.com/download-file-in-r-example










