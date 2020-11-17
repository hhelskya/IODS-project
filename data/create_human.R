
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
Testcsv <- read.csv("C:/Users/Heli/Heli/HY/Introduction to Open Data Science/Projects/IODS-project/data\\human.csv", sep=",", dec = ".", header=TRUE)
dim(Testcsv)
