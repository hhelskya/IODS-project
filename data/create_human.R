# Data Source: http://hdr.undp.org/en/content/human-development-index-hdi
library(stringr)
library(tidyr)
library(tidyverse)

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")
str(hd)
dim(hd)
# [1] 195   8
summary(hd)
str(gii)
dim(gii)
# [1] 195  10
summary(gii)
colnames(hd)
# [1] "HDI.Rank"                               "Country"                               
# [3] "Human.Development.Index..HDI."          "Life.Expectancy.at.Birth"              
# [5] "Expected.Years.of.Education"            "Mean.Years.of.Education"               
# [7] "Gross.National.Income..GNI..per.Capita" "GNI.per.Capita.Rank.Minus.HDI.Rank" 
names(hd) <- c("Rank", "Country","HDI", "LifeExpect", "ExpectYrsEd",  "MeanYrsEd","GNIperCapita", "GNIperCapitaRankMinusHDIRank")
names(hd)
names(gii)
# [1] "GII.Rank"                                     "Country"                                     
# [3] "Gender.Inequality.Index..GII."                "Maternal.Mortality.Ratio"                    
# [5] "Adolescent.Birth.Rate"                        "Percent.Representation.in.Parliament"        
# [7] "Population.with.Secondary.Education..Female." "Population.with.Secondary.Education..Male."  
# [9] "Labour.Force.Participation.Rate..Female."     "Labour.Force.Participation.Rate..Male." 
names(gii) <- c( "GIIRank","Country","GII","MMRatio", "BirthRate", "PercRepresinParliament","edu2F", "edu2M","labF", "labM") 
names(gii)
gii <- gii %>% mutate(ratioedu2FM = edu2F / edu2M, ratiolabFM = labF / labM)
names(gii)
# [1] "GIIRank"                "Country"                "GII"                    "MMRatio"               
# [5] "BirthRate"              "PercRepresinParliament" "edu2F"                  "edu2M"                 
# [9] "labF"                   "labM"                   "ratioedu2FM"            "ratiolabFM"    

human <- 	merge (hd, gii, by.hd="country", by.gii="country")
dim(human)
# [1] 195  19
write.csv(human,"C:/Users/Heli/Heli/HY/Introduction to Open Data Science/Projects/IODS-project/data\\human.csv", row.names = FALSE)
# Load the data
human <- read.csv("C:/Users/Heli/Heli/HY/Introduction to Open Data Science/Projects/IODS-project/data\\human.csv", sep=",", dec = ".", header=TRUE)
dim(human)
# [1] 195  19
# There are 195 rows and 19 variables.
str(human)
# $ Country                     : chr  "Afghanistan" "Albania" "Algeria" "Andorra" ...
# $ Rank                        : int  171 85 83 34 149 58 NA 40 85 2 ...
# $ HDI                         : num  0.465 0.733 0.736 0.845 0.532 0.783 0.686 0.836 0.733 0.935 ...
# $ LifeExpect                  : num  60.4 77.8 74.8 81.3 52.3 76.1 70.6 76.3 74.7 82.4 ...
# $ ExpectYrsEd                 : num  9.3 11.8 14 13.5 11.4 14 12 17.9 12.3 20.2 ...
# $ MeanYrsEd                   : num  3.2 9.3 7.6 9.6 4.7 9.2 6.4 9.8 10.9 13 ...
# $ GNIperCapita                : chr  "1,885" "9,943" "13,054" "43,978" ...
# $ GNIperCapitaRankMinusHDIRank: int  -7 14 -1 -18 -30 -1 NA 11 22 17 ...
# $ GIIRank                     : int  171 85 83 34 149 58 NA 40 85 2 ...
# $ GII                         : num  0.693 0.217 0.413 NA NA NA 0.537 0.376 0.318 0.11 ...
# $ MMRatio                     : int  400 21 89 NA 460 NA 155 69 29 6 ...
# $ BirthRate                   : num  86.8 15.3 10 NA 170.2 ...
# $ PercRepresinParliament      : num  27.6 20.7 25.7 50 36.8 25.7 14 36.8 10.7 30.5 ...
# $ edu2F                       : num  5.9 81.8 26.7 49.5 NA NA 34.7 56.3 94 94.3 ...
# $ edu2M                       : num  29.8 87.9 31 49.3 NA NA 47.6 57.6 95 94.6 ...
# $ labF                        : num  15.8 44.9 15.2 NA 63.3 NA 23.2 47.5 54.2 58.8 ...
# $ labM                        : num  79.5 65.5 72.2 NA 76.9 NA 75.3 75 72.6 71.8 ...
# $ ratioedu2FM                 : num  0.198 0.931 0.861 1.004 NA ...
# $ ratiolabFM                  : num  0.199 0.685 0.211 NA 0.823 ...
# A short decription
# Country, and GNIperCapit are of type chr. Rank, GNIperCapitaRankMinusHDIRank, GIIRank, and MMRatio are of type int. The rest of the variables are of type num.
# The data has been described here: http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf
names(human)
# Remove commas from the data of GNIperCapita and transform it to num
GNIperCapita_num <- str_replace(human$GNIperCapita, pattern=",", replace ="") %>% as.numeric
human <- human %>% mutate(GNIperCapita=GNIperCapita_num)
str(human)
# $ GNIperCapita                : num  1885 9943 13054 43978 6822 ...
# columns to keep
keep <- c("Country", "edu2F", "labM", "LifeExpect", "ExpectYrsEd", "GNIperCapita", "MMRatio", "BirthRate", "PercRepresinParliament")
human <- select(human, one_of(keep))
str(human)
# print out a completeness indicator of the 'human' data
complete.cases(human)
# renove all rown having null values
human_ <- filter(human, complete.cases(human)==TRUE)
dim(human_)
str(human_)
# Remove the observations which relate to regions instead of countries
rownames(human_) <- human_$Country
human_
human_ <- filter(human_, Country!="Latin America and the Caribbean")
human_ <- filter(human_, Country!="Europe and Central Asia")
human_ <- filter(human_, Country!="East Asia and the Pacific")
human_ <- filter(human_, Country!="World")
human_ <- filter(human_, Country!="South Asia")
human_ <- filter(human_, Country!="Sub-Saharan Africa")
human_ <- filter(human_, Country!="Arab States")
dim(human_)
human_ <- select(human_, -Country)
dim(human_)
# [1] 155   8
write.csv(human_,"C:/Users/Heli/Heli/HY/Introduction to Open Data Science/Projects/IODS-project/data\\human2.csv", row.names = TRUE)

