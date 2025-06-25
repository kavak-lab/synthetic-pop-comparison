hispNames <- c("not hisp/latino","hisp/latino")


hisp <- read.csv("../census_data/Raw/US/CBG/ACSDT5Y_hispanic.csv",stringsAsFactors = FALSE)

even_indexes<-seq(2,100,2)
hisp <- hisp[-c(1,even_indexes)]
hisp <- hisp[-1,]
hisp <- hisp[c(2,3)]

colnames(hisp) <- hispNames

write.csv(hisp, "../preprocessing/processed/processed_hispanic.csv", row.names = F)
