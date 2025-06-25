householdNames <- c("total","in.households","in.family.household","householder","m.householder","f.householder","spouse",
               "child","other.relatives","nonrelatives","in.nonfamily.household","non.householder","non.m.householder","non.f.householder",
               "non.nonrelatives")

household <- read.csv("../census_data/Raw/US/CBG/ACSDT5Y_household_type.csv",stringsAsFactors = FALSE)

even_indexes<-seq(2,100,2)
household <- household[-c(1,even_indexes)]
household <- household[-1,]


household <- household[-c(9,10,11,12,13,14,15,16,19,20,21,22,23,27,28,30,31,33,34,35,36,37,38)]

colnames(household) <- householdNames

write.csv(household, "../preprocessing/processed/processed_household.csv", row.names = F)