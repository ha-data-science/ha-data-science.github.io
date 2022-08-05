## HEADER ####
## what: DSSAT overview for HARUG!
## when: 2022-07-20
## who: Ed

## CONTENTS ####
## 00 Setup
## 01 Install {DSSAT}
## 02 Modifying DSSAT files soil
## 03 Modifying DSSAT files weather
## 04 Experiment file filex
## 05 Generating 'batch' file
## 06 DSSAT output

## 00 Setup ####
library(tidyverse)
library(lubridate)
library(DSSAT)

# Ed home PC
setwd(r'(D:\Dropbox\git-hads\ha-data-science.github.io\pages\harug-files\2022-07-20-DSSAT)')

setwd(r'(C:\DSSAT48)')
# You need to download and install DSSAT (the real, non-R version...)
#https://dssat.net/

# DSSAT package Github
# https://github.com/palderman/DSSAT




## 01 Install R {DSSAT} ####


# loading the DSSAT R package.",results='asis',message=FALSE}
# Install DSSAT package from Github source using devtools package
devtools::install_github('https://github.com/palderman/DSSAT')

# Install DSSAT package from CRAN
install.packages('DSSAT')

# Load the DSSAT package
library(DSSAT)

# Example setting DSSAT-CSM path for Windows operating system
options(DSSAT.CSM = 'C:\\DSSAT48\\DSCSM048.EXE')

# Example setting DSSAT-CSM path for Unix-style operating system
# options(DSSAT.CSM = '/DSSAT48/dscsm048')


## 02 Modifying DSSAT files soil ####


# Reading all profiles in a file
all_profiles <- read_sol('c:/DSSAT48/Soil/SOIL.SOL')

# Reading a single profile
single_profile <- read_sol('c:/DSSAT48/Soil/SOIL.SOL',
                           id_soil = 'IB00000001')

# Renaming the profile and replacing SSAT with new values
#     calculated from SBDM using tidyverse-style coding
new_profile <- single_profile %>% 
  mutate(PEDON='IBNEW00001',
         SSAT=0.95*(2.65-SBDM)/2.65)

# Renaming the profile and replacing SSAT with new values
# calculated from SBDM without using tidyverse-style coding
new_profile <- single_profile
new_profile$PEDON[1] <- 'IBNEW00001'
new_profile$SSAT[[1]] <- 0.95*(2.65-single_profile$SBDM[[1]])/2.65

# Appending new profile to SOIL.SOL
write_sol(new_profile,'c:/DSSAT48/Soil/SOIL.SOL',append=TRUE)


## 03 Modifying DSSAT files weather ####


# Generate a list of the weather files
wth_file_list <- list.files(path = r'(C:\DSSAT48\Weather)',
                            pattern='.WTH')

# Read all weather files into a list of tibbles
all_wth <- paste(r'(C:\DSSAT48\Weather\)', 
                 wth_file_list,
                 sep = '') %>% 
  map(read_wth)

read_wth(r'(C:\DSSAT48\Weather\ACNM1301.WTH)')

# Combine all years into a single tibble for summary calculations
combined_wth <- all_wth %>% 
  bind_rows()

# Calculate long-term average temperature (TAV)
tav <- combined_wth %>% 
  summarize(TAV=mean((TMAX+TMIN)/2))

# Calculate monthly temperature amplitude (AMP)
amp <- combined_wth %>% 
  # Extract month from DATE column
  mutate(month = month(DATE)) %>% 
  # Group data by month
  group_by(month) %>% 
  # Calculate monthly means
  summarize(monthly_avg = mean((TMAX+TMIN)/2)) %>% 
  # Calculate AMP as half the difference between minimum and
  #     maximum monthly temperature
  summarize(AMP = (max(monthly_avg)-min(monthly_avg))/2)

# Generate new general information table
general_new <- all_wth[[1]] %>% # use first year as template
  # Extract GENERAL table
  attr('GENERAL') %>% 
  # Replace TAV and AMP with new values
  mutate(TAV=tav$TAV,
         AMP=amp$AMP)

# Store new general information table within each year
for(i in 1:length(all_wth)){
  # Replace general information table
  attr(all_wth[[i]],'GENERAL') <- general_new
}

# Overwrite previous weather files with modified weather data
for(i in 1:length(all_wth)){
  # Write weather file i
  write_wth(all_wth[[i]],wth_file_list[i])
}

# THIS ONE WORKS...
my_wth <- read_wth(r'(C:\DSSAT48\Weather\ACNM1301.WTH)')


## ## 04 Experiment file filex ####

# read in fileX
file_x <- read_filex(r'(C:\DSSAT48\Wheat\KSAS8101.WHX)')


# Add an additional 60 mm irrigation event on 4 May 1982
file_x$`IRRIGATION AND WATER MANAGEMENT` <- 
  # Extract the original IRRIGATION AND WATER MANAGEMENT section
  file_x$`IRRIGATION AND WATER MANAGEMENT` %>% 
  # Modify the IDATE, IROP, and IRVAL columns only where I equals 1
  mutate_cond(I==1,
              IDATE = c(IDATE, as.POSIXct('1982-05-04')),
              IROP  = c(IROP, "IR001"),
              IRVAL = c(IRVAL, 60))

# Overwrite original FileX with new values
write_filex(file_x, r'(C:\DSSAT48\Wheat\TEST8101.WHX)')

## 05 Generating 'batch' file ####
# >>> this does not work <<

# Generate a DSSAT batch file using a tibble
tibble(FILEX='TEST8101.WHX', 
       TRTNO=1:6, RP=1, SQ=0, OP=0, CO=0) %>% 
  write_dssbatch()

# Generate a DSSAT batch file with function arguments
 write_dssbatch(filex='TEST8101.WHX', 
                trtno=1:6)

# Run DSSAT-CSM
run_dssat(run_mode = 'B', file_name = 'Wheat/KSAS8101.WHX')

# Read seasonal output file
smry <- read_output('Summary.OUT')


## 06 DSSAT output ####

pgro <- read_output(r'(D:\Dropbox\DSSAT\PlantGro.OUT)')



ggplot(data=pgro, aes(x=DAP, y=LAID))+
  # Add a line plot for simulated data
  geom_line()
