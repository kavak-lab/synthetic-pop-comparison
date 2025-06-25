raceNames <- c("white","black/aa","a.ind./nat.ak","asian",
               "nat.hi/pt.isl","other","two+")

geo_type <- commandArgs(trailingOnly = TRUE)
file_name <- paste(paste("../census_data/Raw/US/", geo_type, sep=""), "/ACSDT5Y_race.csv",sep="")
race <- read.csv(file_name,stringsAsFactors = FALSE)

even_indexes<-seq(2,100,2)
race <- race[-c(1,3,even_indexes)]
race<- race[-1,]
race <- race[-c(8,9)]


colnames(race) <-raceNames

write.csv(race, "../preprocessing/processed/processed_race.csv", row.names = F)

