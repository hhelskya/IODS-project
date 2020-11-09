# create_alc.R
# Heli Helskyaho
# 09.11.2020
# R file for wrangling the student performance data
# Data source: https://archive.ics.uci.edu/ml/datasets/Student+Performance
#read data
# source <- "http://archive.ics.uci.edu/ml/machine-learning-databases/00320/student.zip"
# dest <- "~/IODS-project/data/student.zip"
# Load Data from the web and unzip it
# setwd("~/IODS-project")
# download.file(source,dest)
# unzip(dest,exdir="~/IODS-project/data/")
# Download also the paper in which data were originally used
# download.file(paper,"~/IODS-project/data/student/student.pdf")

mat <- read.csv("C:/Users/Heli/Heli/HY/Introduction to Open Data Science/Projects/IODS-project/data\\student-mat.csv", sep=";",header=TRUE)
por <- read.csv("C:/Users/Heli/Heli/HY/Introduction to Open Data Science/Projects/IODS-project/data\\student-por.csv", sep=";", header=TRUE)

#check mat data
dim(mat)
# [1] 395  33
str(mat)
dim(por)
# [1] 649  33
str(por)
## Join the two data sets
library(dplyr)
# define the variables used for joining
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
# 
mat_por <- inner_join(mat, por, by = join_by, suffix = c(".mat", ".por"))
dim(mat_por)
# [1] 382  53
str(mat_por)
#columns that are not in both data sets
notjoined_columns <- colnames(mat)[!colnames(mat) %in% join_by]
# create a new data frame with only the joined columns
alc <- select(mat_por, one_of(join_by))
# If both data sets have a value for the same variable, we need to decide what to do
# For numeric variables: take the rounded average 
# For others: choose the first answer
for(column_name in notjoined_columns) {
  # select two columns from 'mat_por' with the same original name
  two_columns <- select(mat_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}
colnames(alc)
# Calculate other required variables 
## alc_use as average of the answers related to weekday and weekend alcohol consumption 
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
colnames(alc)
summary(alc)
str(alc)
## create a new logical column 'high_use' which is TRUE for students for which 'alc_use' is greater than 2 
alc <- mutate(alc, high_use = alc_use > 2)
str(alc)
glimpse(alc)
dim(alc)
# [1] 382  35

write.csv(alc,"C:/Users/Heli/Heli/HY/Introduction to Open Data Science/Projects/IODS-project/data\\alc.csv", row.names = FALSE)
Newalc <- read.csv("C:/Users/Heli/Heli/HY/Introduction to Open Data Science/Projects/IODS-project/data\\alc.csv", sep=",", dec = ".", quote="", header=TRUE)
dim(Newalc)

