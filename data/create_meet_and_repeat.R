# Jukke Kaaronen
# IODS2020 Exercise 6

# read datasets, explore structure, and change categorical integers to factors:
library(tidyverse)

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep = " ", header = TRUE )
str(BPRS)
BPRS$treatment <- as.factor(BPRS$treatment)
BPRS$subject <- as.factor(BPRS$subject)
str(BPRS) # 2 factor variables treatment (2 levels) subject (20 levels), 9 integer variables
dim(BPRS) # 40 observations of 11 variables
# the data is in wide form, meaning each row accounts for an observation of a specific subject in a specific treatment and their score in specific times

RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep = "\t", header = TRUE)
str(RATS)
RATS$ID <- as.factor(RATS$ID)
RATS$Group <- as.factor(RATS$Group)
str(RATS) # 2 factor variables ID (16 levels) Group (3 levels), 11 integer variables
dim(RATS) # 16 observations of 13 variables
# the data is in wide form, meaning each row accounts for an observation of a specific rat in a specific group and it's weight in specific times

# convert datasets from wide form to long form

long_BPRS <- gather(BPRS, key = weeks, value = bprs_score, -treatment, - subject) %>% mutate(week = as.integer(substr(weeks, 5,5)))
glimpse(long_BPRS)
# the long_BPRS data is now in long form with each observation of BPRS score on a spearate row
long_RATS <- gather(RATS, key = WD, value = Weight, -ID, -Group) %>% mutate(Time = as.integer(substr(WD, 3,4)))
glimpse(long_RATS) # 176 rows, 5 columns
# the long_RATS data is now in long form with each observation of weight on a separate row

setwd("C:/Users/Jukke/OneDrive/Työpöytä/IODS/IODS-project/data")
write.table(long_BPRS, "long_BPRS.txt", sep = ",")
write.table(long_RATS, "long_RATS.txt", sep = ",")
