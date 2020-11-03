#Jukke Kaaronen
#Nov 2nd 2020
#Data wrangling exercise for IODS2020 learning2014 dataset
#Data source:
#http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt
##READ DPLYR##
library(dplyr)

####################################
#Read table and assign as learn2014#
####################################

learn2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", 
                        sep="\t", header=TRUE)
#Explore dimension
dim(learn2014) #183 rows of 60 variables
str(learn2014) #59 integer columns (55 columns on scale 1-5, Age 17-55), 1 character column (gender M 61 & F 122)
summary(learn2014$Age)
distinct(learn2014, gender)
count(learn2014, gender)

#########################
#Create analysis dataset#
#########################

#Scale attitude to 1-5 scale (Attitude / N of questions in survey (10))
learn2014$attitude <- learn2014$Attitude / 10
summary(learn2014$attitude)

# questions related to deep, surface and strategic learning (Copied/defined from/in DataCamp exercise)
# and https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS2-meta.txt (see bottom page)

#Assign values for deep, surface, and strategic vectors
deep_q <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_q <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_q <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep'
# with rowMeans (produces average of values defined above)
deep_columns <- select(learn2014, one_of(deep_q))
learn2014$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column "surf" 
# with rowMeans (produces average of values defined above)
surface_columns <- select(learn2014, one_of(surface_q))
learn2014$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column "stra"
# with rowMeans (produces average of values defined above)

strategic_columns <- select(learn2014, one_of(strategic_q))
strategic_columns
learn2014$stra <- rowMeans(strategic_columns)
learn2014$stra

# Assign dataset with columns
# gender,age, attitude, deep, stra, surf, points and filter Points > 0
ln14_analysis <- select(learn2014,gender, Age, attitude, deep, stra, surf, Points) %>% filter(Points > 0)
dim(ln14_analysis) #166 rows 7 columns
str(ln14_analysis)
head(ln14_analysis)

# Write .csv
write.csv(ln14_analysis, "ln14_analysis.csv")
read.csv("ln14_analysis.csv")
