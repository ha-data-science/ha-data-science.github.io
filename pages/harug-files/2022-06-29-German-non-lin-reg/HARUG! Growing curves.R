## Header ####
## Coder: German A. Fernandez Casals
## Main: HARUG! Growing curves
## Date of creation: 14/06/2022
## Date of last modification: 14/06/2022

##Index ####

## Call packages

## 1) Import data set (change to your directory) and subset

## 2) Non lineal sigmoidal regression
## 2.1 Treatment 1 fit
## 2.2 Treatment 3 fit
## 2.3 Treatment 7 fit
## 2.4 Treatment 9 fit

## 3) Plot of all treatments
## 3.1 Values predictions and new data set 
## 3.2 Newdata plot


## Call packages ####
library(readxl)       #Import the data from excel
library(mosaic)       #plotPoints function
library(ggplot2)      #Graphical representation 
library(tidyverse)    #Graphical representation (as.tibble function)
library(broom)        #Graphical representation (for the argument)
library(purrr)        #Graphical representation (map_df function)
library(nlstools)     #Non linear regressions
library(minpack.lm)   #Non linear regressions
library(qpcR)         #For the fit of goodness


## 1) Import data set (change to your directory) and subset ####

D <- read_excel("D:/German Disk/OneDrive/Escritorio/Data.xlsx", 
                sheet = "R")

dataT1 <- subset(D, Trat == "T1")
dataT3 <- subset(D, Trat == "T3")
dataT7 <- subset(D, Trat == "T7")
dataT9 <- subset(D, Trat == "T9")


## 2) Non lineal sigmoidal regression ####
## Notes: On this meeting we are going to fit only the dray matter 
#        (DM) accumulation.
#        The code for make the fit and the plots are repeated for 
#        each treatment.
#        DMT1 stands for the fit on the dry matter for the treatment 1.


## 2.1 Treatment 1 fit
plotPoints(DM ~ Day, pch=19, col="black", data = dataT1)    #For plotting the DM accumulation

#Sigmoidal fit of the treatment 1
DMT1 <- nlsLM(DM ~ a + ((b - a)/(1 + exp(-c * (Day - d)))), #Formula (equation)
              data = dataT1,                                #Data of the treatment 1
              start = list(a = min(dataT1$DM),              #An approximation of the a factor
                           b = max(dataT1$DM),              #An approximation of the c factor
                           c = 1,                           #An approximation of the d factor
                           d = median(dataT1$Day)),         #An approximation of the d factor
              trace = TRUE,                                 #To print the graph later
              algorithm = "port")                           #By defect "LM", this has an error in big data sets, so change by "port"

overview(DMT1)                                              #To view the formula amd tables
plotfit(DMT1, smooth = TRUE, xlab="Days after sowing",      #To plot the fit
        ylab=expression("kg DM "~ha^-1), col.fit = "blue", pch.obs = 19,
        lwd = 3)

pcrGOF(DMT1, PRESS = FALSE)                                 #To get the fit goodness

## 2.2 Treatment 3 fit
plotPoints(DM ~ Day, pch=19, col="black", data = dataT3)
DMT3 <- nlsLM(DM ~ a + ((b - a)/(1 + exp(-c * (Day - d)))),
              data = dataT3,
              start = list(a = min(dataT3$DM),
                           b = max(dataT3$DM),
                           c = 1, d = median(dataT3$Day)),
              trace = TRUE, algorithm = "port")

overview(DMT3)
plotfit(DMT3, smooth = TRUE, xlab="Days after sowing", 
        ylab=expression("kg DM "~ha^-1), col.fit = "blue", pch.obs = 19,
        lwd = 3)
pcrGOF(DMT3, PRESS = FALSE)

## 2.3 Treatment 7 fit
plotPoints(DM ~ Day, pch=19, col="black", data = dataT7)
DMT7 <- nlsLM(DM ~ a + ((b - a)/(1 + exp(-c * (Day - d)))),
              data = dataT7,
              start = list(a = min(dataT7$DM),
                           b = max(dataT7$DM),
                           c = 1, d = median(dataT7$Day)),
              trace = TRUE, algorithm = "port")

overview(DMT7)
plotfit(DMT7, smooth = TRUE, xlab="Days after sowing", 
        ylab=expression("kg DM "~ha^-1), col.fit = "blue", pch.obs = 19,
        lwd = 3)
pcrGOF(DMT7, PRESS = FALSE)

## 2.4 Treatment 9 fit
plotPoints(DM ~ Day, pch=19, col="black", data = dataT9)
DMT9 <- nlsLM(DM ~ a + ((b - a)/(1 + exp(-c * (Day - d)))),
              data = dataT9,
              start = list(a = min(dataT9$DM),
                           b = max(dataT9$DM),
                           c = 1, d = median(dataT9$Day)),
              trace = TRUE, algorithm = "port")

overview(DMT9)
plotfit(DMT9, smooth = TRUE, xlab="Days after sowing", 
        ylab=expression("kg DM "~ha^-1), col.fit = "blue", pch.obs = 19,
        lwd = 3)
pcrGOF(DMT9, PRESS = FALSE)

## 3) Plot of all treatments ####
## Notes: Need to use the function "predict" for create a new data 
#         (newdataDM) for have a smooth graph.
#         Explanations on notations on the right
 
## 3.1 Values predictions and new data set 
#(explanations at the right)

newdataDMT1 <- expand.grid(Day=seq(min(dataT1$Day),max(dataT1$Day),by=5)) #for create a dataframe with range of the days of the experiment
newdataDMT1$DM_predicted_vals <- predict(DMT1,newdata=newdataDMT1)         #Predict the values (DM) each 5 points (days)
newdataDMT1$Treatment="T1"                                               #Create a column call "Treatment" with the value "T1" that stand for Treatment 1
newdataDMT3 <- expand.grid(Day=seq(min(dataT3$Day),max(dataT3$Day),by=5)) #Repit the previus operation with the rest of the treatments
newdataDMT3$DM_predicted_vals <- predict(DMT3,newdata=newdataDMT3)
newdataDMT3$Treatment ="T3"
newdataDMT7 <- expand.grid(Day=seq(min(dataT7$Day),max(dataT7$Day),by=5))
newdataDMT7$DM_predicted_vals <- predict(DMT7,newdata=newdataDMT7)
newdataDMT7$Treatment="T7"
newdataDMT9 <- expand.grid(Day=seq(min(dataT9$Day),max(dataT9$Day),by=5))
newdataDMT9$DM_predicted_vals <- predict(DMT9,newdata=newdataDMT9)
newdataDMT9$Treatment="T9"
newdataDM <- rbind(newdataDMT1, newdataDMT3, newdataDMT7, newdataDMT9)      #Create a database call "newdataDM" with all the data of the previous databases
rm(newdataDMT1, newdataDMT3, newdataDMT7, newdataDMT9)                      #Remove the previous databases that we are not going to use anymore
str(newdataDM)

## 3.2 Newdata plot
#(explanations at the right)

newdataDM%>%                                                                #Database used
  split(.$Treatment) %>%                                                    #Split the regressions by treatment
  map( ~nlsLM(DM_predicted_vals ~ a + ((b - a)/(1 + exp(-c * (Day - d)))),  #Formula and starting values (like before)
              start = list(a = min(.$DM_predicted_vals),
                           b = max(.$DM_predicted_vals),
                           c = 1, 
                           d = median(.$Day)),
              trace = TRUE, 
              algorithm = "port", 
              data=.)) %>% 
  map_df(~augment(.), .id="Treatment") %>% 
  as_tibble() %>%                      
  ggplot(aes(x=Day, y=DM_predicted_vals, color=Treatment)) +
  geom_line(aes(y=.fitted))+
  labs(title="",
       x="Days after sowing",  
       y=expression("kg DM ha"^-1))+
  scale_color_manual(name="Treatment",
                     labels=c("T1 (Witness)",
                              bquote("T3 (360 kg N"[org] ~ "ha"^-1 ~ ")"),
                              bquote("T7 (180 kg N"[min] ~ "ha"^-1 ~ ")"),
                              bquote("T9 (360 kg N"[org] ~ "ha"^-1 ~ "+ 180 kg N"[min] ~ "ha"^-1 ~ ")")),
                     values= c("T1"="red1",
                               "T3"="green3",
                               "T7"="turquoise4",
                               "T9"="mediumorchid1")) +
  theme_minimal(base_size = 12)
