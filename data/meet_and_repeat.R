# Read the BPRS data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt",sep  =" ", header = T)
# Read the RATS data
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep  ="", header = T)
names(BPRS)
# The variable names are:  "treatment" "subject"   "week0"     "week1"     "week2"     "week3"     "week4"     "week5"     "week6"    
#  "week7"     "week8"  
names(RATS)
# The variable names are:  "ID"    "Group" "WD1"   "WD8"   "WD15"  "WD22"  "WD29"  "WD36"  "WD43"  "WD44"  "WD50"  "WD57"  "WD64" 
dim(BPRS)
# There are 40 observations and 11 variables in the dataset.
dim(RATS)
# There are 16 observations and 13 variables in the dataset.
str(BPRS)
# 'data.frame':	40 obs. of  11 variables:
# $ treatment: int  1 1 1 1 1 1 1 1 1 1 ...
# $ subject  : int  1 2 3 4 5 6 7 8 9 10 ...
# $ week0    : int  42 58 54 55 72 48 71 30 41 57 ...
# $ week1    : int  36 68 55 77 75 43 61 36 43 51 ...
# $ week2    : int  36 61 41 49 72 41 47 38 39 51 ...
# $ week3    : int  43 55 38 54 65 38 30 38 35 55 ...
# $ week4    : int  41 43 43 56 50 36 27 31 28 53 ...
# $ week5    : int  40 34 28 50 39 29 40 26 22 43 ...
# $ week6    : int  38 28 29 47 32 33 30 26 20 43 ...
# $ week7    : int  47 28 25 42 38 27 31 25 23 39 ...
# $ week8    : int  51 28 24 46 32 25 31 24 21 32 ...
# all variables are of type int.
str(RATS)
# 'data.frame':	16 obs. of  13 variables:
#  $ ID   : int  1 2 3 4 5 6 7 8 9 10 ...
# $ Group: int  1 1 1 1 1 1 1 1 2 2 ...
# $ WD1  : int  240 225 245 260 255 260 275 245 410 405 ...
# $ WD8  : int  250 230 250 255 260 265 275 255 415 420 ...
# $ WD15 : int  255 230 250 255 255 270 260 260 425 430 ...
# $ WD22 : int  260 232 255 265 270 275 270 268 428 440 ...
# $ WD29 : int  262 240 262 265 270 275 273 270 438 448 ...
# $ WD36 : int  258 240 265 268 273 277 274 265 443 460 ...
# $ WD43 : int  266 243 267 270 274 278 276 265 442 458 ...
# $ WD44 : int  266 244 267 272 273 278 271 267 446 464 ...
# $ WD50 : int  265 238 264 274 276 284 282 273 456 475 ...
# $ WD57 : int  272 247 268 273 278 279 281 274 468 484 ...
# $ WD64 : int  278 245 269 275 280 281 284 278 478 496 ...
# all variables are of type int.
summary(BPRS)
summary(RATS)
tail(BPRS)
# treatment subject week0 week1 week2 week3 week4 week5 week6 week7 week8
# 35         2      15    40    36    55    55    42    30    26    30    37
# 36         2      16    54    45    35    27    25    22    22    22    22
# 37         2      17    33    41    30    32    46    43    43    43    43
# 38         2      18    28    30    29    33    30    26    36    33    30
# 39         2      19    52    43    26    27    24    32    21    21    21
# 40         2      20    47    36    32    29    25    23    23    23    23
head(RATS)
# ID Group WD1 WD8 WD15 WD22 WD29 WD36 WD43 WD44 WD50 WD57 WD64
# 1  1     1 240 250  255  260  262  258  266  266  265  272  278
# 2  2     1 225 230  230  232  240  240  243  244  238  247  245
# 3  3     1 245 250  250  255  262  265  267  267  264  268  269
# 4  4     1 260 255  255  265  265  268  270  272  274  273  275
# 5  5     1 255 260  255  270  270  273  274  273  276  278  280
# 6  6     1 260 265  270  275  275  277  278  278  284  279  281
# Convert the categorical variables of both data sets to factors.

library(tidyr)
library(dplyr)
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
RATS$Group <- factor(RATS$Group)
RATS$ID <- factor(RATS$ID)
str(BPRS)
#  $ treatment: Factor w/ 2 levels "1","2": 1 1 1 1 1 1 1 1 1 1 ...
# $ subject  : Factor w/ 20 levels "1","2","3","4",..: 1 2 3 4 5 6 7 8 9 10 ...
str(RATS)
# Group: Factor w/ 3 levels "1","2","3": 1 1 1 1 1 1 1 1 2 2 ...

glimpse(RATS)

# Convert the data sets to long form. Add a week variable to BPRS and a Time variable to RATS.
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject) %>% mutate(week = as.integer(substr(weeks,5,5)))
RATSL <- RATS %>% gather(key = WD, value = Weight, -ID, -Group) %>% mutate(Time = as.integer(substr(WD,3,4))) 
glimpse(BPRSL)
glimpse(RATSL)
# Take a serious look at the new data sets and compare them with their wide form versions
names(BPRS)
# "treatment" "subject"   "week0"     "week1"     "week2"     "week3"     "week4"     "week5"     "week6"    
# "week7"     "week8"  
names(BPRSL)
# "treatment" "subject"   "weeks"     "bprs"      "week"  
glimpse(BPRS)
glimpse(BPRSL)
str(BPRS)
# 'data.frame':	40 obs. of  11 variables:
#   $ treatment: Factor w/ 2 levels "1","2": 1 1 1 1 1 1 1 1 1 1 ...
# $ subject  : Factor w/ 20 levels "1","2","3","4",..: 1 2 3 4 5 6 7 8 9 10 ...
# $ week0    : int  42 58 54 55 72 48 71 30 41 57 ...
# $ week1    : int  36 68 55 77 75 43 61 36 43 51 ...
# $ week2    : int  36 61 41 49 72 41 47 38 39 51 ...
# $ week3    : int  43 55 38 54 65 38 30 38 35 55 ...
# $ week4    : int  41 43 43 56 50 36 27 31 28 53 ...
# $ week5    : int  40 34 28 50 39 29 40 26 22 43 ...
# $ week6    : int  38 28 29 47 32 33 30 26 20 43 ...
# $ week7    : int  47 28 25 42 38 27 31 25 23 39 ...
# $ week8    : int  51 28 24 46 32 25 31 24 21 32 ...
str(BPRSL)
# 'data.frame':	360 obs. of  5 variables:
#   $ treatment: Factor w/ 2 levels "1","2": 1 1 1 1 1 1 1 1 1 1 ...
# $ subject  : Factor w/ 20 levels "1","2","3","4",..: 1 2 3 4 5 6 7 8 9 10 ...
# $ weeks    : chr  "week0" "week0" "week0" "week0" ...
# $ bprs     : int  42 58 54 55 72 48 71 30 41 57 ...
# $ week     : int  0 0 0 0 0 0 0 0 0 0 ...
summary(BPRS)
summary(BPRSL)
names(RATS)
# "ID"    "Group" "WD1"   "WD8"   "WD15"  "WD22"  "WD29"  "WD36"  "WD43"  "WD44"  "WD50"  "WD57"  "WD64" 
names(RATSL)
# "ID"     "Group"  "WD"     "Weight" "Time" 
str(RATS)
str(RATSL)
summary(RATS)
summary(RATSL)

dim(RATSL)
write.csv(BPRS,"C:/Users/Heli/Heli/HY/Introduction to Open Data Science/Projects/IODS-project/data\\BPRS.csv", row.names = TRUE)
write.csv(BPRSL,"C:/Users/Heli/Heli/HY/Introduction to Open Data Science/Projects/IODS-project/data\\BPRSL.csv", row.names = TRUE)

write.csv(RATS,"C:/Users/Heli/Heli/HY/Introduction to Open Data Science/Projects/IODS-project/data\\RATS.csv", row.names = TRUE)
write.csv(RATSL,"C:/Users/Heli/Heli/HY/Introduction to Open Data Science/Projects/IODS-project/data\\RATSL.csv", row.names = TRUE)

# write.table(BPRSL, file = "C:/Users/Heli/Heli/HY/Introduction to Open Data Science/Projects/IODS-project/data\\BPRSL.txt", sep="\t", row.names=TRUE)

