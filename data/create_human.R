# Jukke Kaaronen
# Nov 16th 2020
# Data wrangling exercise for IODS2020
# Data source:
# http://hdr.undp.org/en/content/human-development-index-hdi
# technical notes:
# http://hdr.undp.org/sites/default/files/hdr2019_technical_notes.pdf
# http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf

library(tidyverse)

# read csv
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#explore structure
str(hd)
str(gii)

# rename long names for hd

hd <- rename(hd, HDIrank = HDI.Rank)
hd <- rename(hd, HDI = Human.Development.Index..HDI.)
hd <- rename(hd, LEB = Life.Expectancy.at.Birth)
hd <- rename(hd, EDUexpect = Expected.Years.of.Education)
hd <- rename(hd, EDUmean = Mean.Years.of.Education)
hd <- rename(hd, GNI = Gross.National.Income..GNI..per.Capita)
hd <- rename(hd, GNIHDI = GNI.per.Capita.Rank.Minus.HDI.Rank)

str(hd) # look at hd again

# rawr oh dear GNI has comma separators in the numerals and is classed as character

hd$GNI <- sub(",", "", hd$GNI, fixed = TRUE) # substitute "," with nothing "" in hd$GNI
hd$GNI <- as.numeric(hd$GNI) # change from character to numeric
str(hd) # yay

# rename long names for gii

gii <- rename(gii, GIIrank = GII.Rank)
gii <- rename(gii, GII = Gender.Inequality.Index..GII.)
gii <- rename(gii, MMR = Maternal.Mortality.Ratio)
gii <- rename(gii, ABR = Adolescent.Birth.Rate)
gii <- rename(gii, PRPF = Percent.Representation.in.Parliament) # this is female percentage
gii <- rename(gii, EDU2M = Population.with.Secondary.Education..Male.)
gii <- rename(gii, EDU2F = Population.with.Secondary.Education..Female.)
gii <- rename(gii, LABF = Labour.Force.Participation.Rate..Female.)
gii <- rename(gii, LABM = Labour.Force.Participation.Rate..Male.)

# check str again
str(gii) #no silly comma separators in this one

# create new variables: ratio of EDU2F and EDU2M
# and ratio of LABF and LABM

gii <- gii %>% mutate(EDU2ratio = EDU2F / EDU2M)
gii <- gii %>% mutate(LABratio = LABF / LABM)

human <- inner_join(hd, gii, by = "Country")
str(human) # bigger
colnames(human) # shorter
dim(human) # desired
is.na(human) # quick look at NA values reveals missing values but we'll probably deal with them somehow in next weeks task

#write .csv

setwd("C:/Users/Jukke/OneDrive/Työpöytä/IODS/IODS-project/data")
write.csv(human, "human.csv", row.names = FALSE)
read.csv("human.csv") # works