## HEADER ####
#what: HARUG! for loops
#when: 2022-03-16

## CONTENTS ####
## 01 for() loop in R
## 02 ## while() conditions in R 
## 03 if(), else(), ifelse()
## 04 example IRL

## 01 for() loop in R ####

for(bob in 1:25){
  print(paste("The number is", bob ))
}


## while() conditions in R ####


x = 10 # initialize

# Print 1 to 5
while(x > 1){
  print(paste('My number is', x))
  x = x + 1  # condition increment
}


## if(), else(), ifelse() ####

# example 1
x <- 100
if(x > 10){
  print(paste(x, "is greater than 10"))
}


# example 2
x <- 9
if(x > 10){
  print(paste(x, "is greater than 10"))
} else{
  print(paste(x, "is not greater than 10"))
} 


# example 3
x <- 75

ifelse(test = x > 10,
       yes = paste(x, "is greater than 10"),
       no = paste(x, "is not greater than 10"))


## 04 example IRL ###
setwd(r'(D:\Dropbox\WORK\__Harper Adams stuff\_GRANTS\_Jude Capper ECOBEEF CIEL\data)')
data <- read.csv('../Karl stuff v2/EconMaster.csv')
tbl <- table(data$Sire)
data1 <- droplevels(data[data$Sire %in% names(tbl)[tbl >= 10], , drop = F])
length(table(data1$Sire)) # 20 unique sires with >= 10

lmeADG <- lmer(ADGkg ~ Sex + Past_Days + KillAge + (1+Sex + Past_Days + KillAge|Sire),
               data = data1)

lmeADG.c <- coef(lmeADG)$Sire

ord1 <- order(lmeADG.c$'(Intercept', decreasing=T)
lmeADG.c[ord1,]

mycex <- 1.2
plot(y = data1$ADGkg, x = data1$KillAge,
     pch=16, cex = .5,
     ylab = 'Avg. Daily Wt. Gain (Kg)',
     xlab = 'Kill Age (d)', cex.lab=mycex,
     main = '64.9% variation associated with Sire')
for (i in 1:length(table(data1$Sire))){
  abline(coef=lmeADG.c[i, c('(Intercept)', 'KillAge')],
         col = 'gray80')
}
abline(coef = apply(X = lmeADG.c[,c('(Intercept)', 'KillAge')],
                    MARGIN = 2,
                    FUN = mean),
       col = 'red', lty = 2, lwd=2)
legend(x = 550, y = 2.3,
       legend = c('sire', 'average'),
       col = c('gray80', 'red'),
       lty=c(1,2),
       lwd=c(1,2),
       bty='n', cex=mycex)


# problem

data <- data.frame(names=c('Tom', 'Bert', 'Anne'),
                   height = c(180, 188, 162),
                   country = c('England', 'Scotland', 'Wales'))
data

Use write.csv() to output each line to a csv file with the name of each file being the value of the 'names' vector(
  
)