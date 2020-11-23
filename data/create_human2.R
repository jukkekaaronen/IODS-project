# Jukke Kaaronen
# Nov 23rd 2020
# Data wrangling exercise for IODS2020
# Data source:
# http://hdr.undp.org/en/content/human-development-index-hdi
# technical notes:
# http://hdr.undp.org/sites/default/files/hdr2019_technical_notes.pdf
# http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf
# This script is a continuation of last week's data wrangling exercise on the human.csv dataset

library(tidyverse)

setwd("C:/Users/Jukke/OneDrive/Työpöytä/IODS/IODS-project/data")
human <- read.csv("human.csv")

dim(human) # 195 observation of 19 variables
str(human) # 1 character class, 18 numerical classes

#note: I changed the GNI column from character to numeric already in last weeks exercise with the code below:

#hd$GNI <- sub(",", "", hd$GNI, fixed = TRUE) # substitute "," with nothing "" in hd$GNI
#hd$GNI <- as.numeric(hd$GNI) # change from character to numeric
#str(hd) # yay

# HDIrank: rank in Human Development Index
# Country: Character class for country
# HDI: Human Development Index
# LEB: Life Expectancy at Birth
# EDUexpect: Expected years of education
# EDUmean: mean years of education
# GNI: Gross national income per capita
# GNIHDI: GNI per capita rank minus HDI rank
# GIIrank: Gender Inequality Rank
# GII: Gender Inequality Index
# MMR: Maternal Mortality Ratio
# ABR: Adolescent birth rate
# PRPF: Percentage of representation in parliament (female percentage)
# EDU2F: Female population with secondary education
# EDU2M: Male population with secondary education
# LABF: Rate of female population in labour force
# LABM: Rate of male population in labour force
# EDU2ratio: Ratio of EDU2F and EDU2M (EDU2F / EDU2M)
# LABratio: Ratio of LABF and LABM (LABF / LABM)

# Select: "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F"

h1 <- human %>% select("Country", "EDU2ratio", "LABratio", "EDUexpect", "LEB", "GNI", "MMR", "ABR", "PRPF")

# Filter out rows with NA

h1 <- filter(h1, complete.cases(h1))

# Filter Regions: remove Arab to World from dataset
h2 <- h1[1:155,]

rownames(h2) <- h2$Country
h2<- select(h2, -Country)

write.csv(h2, "human2.csv")
read.csv("human2.csv")
