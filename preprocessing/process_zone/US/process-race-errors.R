raceNames <- c("white","black/aa","a.ind./nat.ak","asian",
               "nat.hi/pt.isl","other","two+")
race <- read.csv("census_data/us_census_data/census_block_group_data/ACSDT5Y_race.csv",stringsAsFactors = FALSE)

even_indexes<-seq(1,100,2)
race <- race[-c(1,2,3,4,even_indexes)]
race <- race[-c(8,9)]
race<- race[-1,]
colnames(race) <-raceNames
head(race)


write.csv(race, "preprocessing/processed/processed_race_error.csv", row.names = F)