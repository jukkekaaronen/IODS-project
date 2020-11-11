# Jukke Kaaronen
# Nov 9th 2020
# Data wrangling exercise for IODS2020
# Data source:
# https://archive.ics.uci.edu/ml/machine-learning-databases/00320/
# Database citation:
# P. Cortez and A. Silva. Using Data Mining to Predict Secondary School Student Performance. In A. Brito and J. Teixeira Eds., Proceedings of 5th FUture BUsiness TEChnology Conference (FUBUTEC 2008) pp. 5-12, Porto, Portugal, April, 2008, EUROSIS, ISBN 978-9077381-39-7.

##READ DPLYR##
library(dplyr)

# read .csv, sep = ;
mat <- read.csv("C:/Users/Jukke/OneDrive/Työpöytä/IODS/IODS-project/data/student-mat.csv", sep = ";", header = TRUE)
por <- read.csv("C:/Users/Jukke/OneDrive/Työpöytä/IODS/IODS-project/data/student-por.csv", sep = ";", header = TRUE)

# explore structure and dimensions
str(mat) # 395 observations of 33 variables
str(por) # 649 observations of 33 variables
dim(mat)
dim(por)

# 
# create vector join for 13 identifier columns (these will be used..)
# create vector suf for 2 suffix identifiers (these are used as id tags)
join <- c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet")
suf <- c(".mat",".por")

# create new dataframe from join vector, add suf with argument suffix =
matpor <- inner_join(mat, por, by = join, suffix = suf)
# create new dataframe with only join columns
matpor_comb <- select(matpor, one_of(join))

# columns that were not used for joining the data
no_join <- colnames(mat)[!colnames(mat) %in% join]

# print out the columns not used for joining
no_join

# create for-loop that goes through matpor (copied from DataCamp exercise)
# for every column name not used for joining...
for(column_name in no_join) {
  # select two columns from 'matpor' with the same original name
  two_columns <- select(matpor, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column  vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    matpor_comb[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the matpor_comb data frame
    matpor_comb[column_name] <- first_column
  }
}

# create two new columns for alcohol use (alc_use = (weekday + weekend) / 2)
# and logical T/F for high_use (alc_use > 2)
matpor_comb <- mutate(matpor_comb, alc_use = ((Dalc + Walc) / 2)) %>%
  mutate(matpor_comb, high_use = alc_use > 2)

# take a glimpse everything OK
glimpse(matpor_comb)

# setwd and write as .csv
setwd("C:/Users/Jukke/OneDrive/Työpöytä/IODS/IODS-project/data")
write.csv(matpor_comb, "alc.csv", row.names = FALSE)
read.csv("alc.csv")