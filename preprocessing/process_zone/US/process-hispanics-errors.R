hispNames <- c("not hisp/latino","hisp/latino")

hisp <- read.csv("census_data/us_census_data/census_block_group_data/ACSDT5Y_hispanic.csv",stringsAsFactors = FALSE)
even_indexes<-seq(1,100,2)
hisp <- hisp[-c(1,even_indexes)]

hisp <- hisp[c(3,4)]
head(hisp)

hisp <- hisp[-1,]
colnames(hisp) <- hispNames

head(hisp)

write.csv(hisp, "preprocessing/processed/processed_hispanic_error.csv", row.names = F)
