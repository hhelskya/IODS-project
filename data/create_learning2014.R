
# Loading the data --------------------------------------------------------


# read the data into memory
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)


# Understanding the data --------------------------------------------------


# Let's look at the dimensions of the data
dim(lrn14)
# There are 183 rows and 60 columns in the dataset


# Let's look at the structure of the data
str(lrn14)

# All the attributes are of type int except gender that is of type chr

# lrn14$attitude <- lrn14$Attitude / 10

# The Analyses dataset ----------------------------------------------------
# Access the dplyr library
library(dplyr)

# attitude Aa, Ab, Ac, Ad, Ae, Af
# deep D03+D11+D19+D27, D07+D14+D22+D30, D06+D15+D23+D31
# surf SU02+SU10+SU18+SU26, SU05+SU13+SU21+SU29, SU08+SU16+SU24+SU32
# stra ST01+ST09+ST17+ST25, ST04+ST12+ST20+ST28


# Define the columns to be used for each combiantion variable

attitude_columns <- c("Aa", "Ab", "Ac", "Ad", "Ae", "Af")
deep_columns <- c("D03","D11","D19","D27", "D07","D14","D22","D30","D06","D15","D23","D31")
stra_columns <- c("ST01","ST09","ST17","ST25", "ST04","ST12","ST20","ST28")
surf_columns <- c("SU02","SU10","SU18","SU26","SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")


# Scale all combination variables to the original scales (by taking the mean)

attitude_columns <- select(lrn14, one_of(attitude_columns))
lrn14$attitude <- rowMeans(attitude_columns)

lrn14$attitude
deep_columns <- select(lrn14, one_of(deep_columns))
lrn14$deep <- rowMeans(deep_columns)

stra_columns <- select(lrn14, one_of(stra_columns))
lrn14$stra <- rowMeans(stra_columns)

surf_columns <- select(lrn14, one_of(surf_columns))
lrn14$surf <- rowMeans(surf_columns)

# choose the columns to keep and create a new dataset learning2014
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")
learning2014 <- select(lrn14, one_of(keep_columns))
# str(learning2014)
# dim(learning2014)
# colnames(learning2014)

# Remove the zero values from the dataset
learning2014 <- filter(learning2014, Age != 0)
# dim(learning2014)
learning2014 <- filter(learning2014, attitude != 0)
# dim(learning2014)
learning2014 <- filter(learning2014, deep != 0)
# dim(learning2014)
learning2014 <- filter(learning2014, stra != 0)
# dim(learning2014)
learning2014 <- filter(learning2014, surf != 0)
# dim(learning2014)
learning2014 <- filter(learning2014, Points != 0)
dim(learning2014)

# Save the new dataset into a file and read it
write.csv(learning2014,"C:/Users/Heli/Heli/HY/Introduction to Open Data Science/Projects/IODS-project/data\\learning2014.csv", row.names = FALSE)
Newcsv <- read.csv("C:/Users/Heli/Heli/HY/Introduction to Open Data Science/Projects/IODS-project/data\\learning2014.csv", sep=",", dec = ".", quote="", header=TRUE)

dim(Newcsv)
str(Newcsv)

#write.table(learning2014,"C:/Users/Heli/Heli/HY/Introduction to Open Data Science/Projects/IODS-project/data\\learning2014.txt", row.names = FALSE)
#Newtxt <- read.table("C:/Users/Heli/Heli/HY/Introduction to Open Data Science/Projects/IODS-project/data\\learning2014.txt", sep="\t", dec = ".",quote="",header=TRUE)

