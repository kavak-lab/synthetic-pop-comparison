conNamesE <- c("m0_9", "m10_19", "m20_29", "m30_39", "m40_49", "m50_59","m60_69","m70_79","m80_89",
              "f0_9", "f10_19", "f20_29", "f30_39", "f40_49", "f50_59","f60_69","f70_79","f80_89","m","f")

raceE <- read.csv("preprocessing/processed/processed_race_error.csv", stringsAsFactors = FALSE)
hispE <- read.csv("preprocessing/processed/processed_hispanic_error.csv", stringsAsFactors = FALSE)
ageE <- read.csv("preprocessing/processed/processed_sex_age_error.csv", stringsAsFactors = FALSE)
population <- read.csv("census_data/us_census_data/census_block_group_data/ACSDT5Y_total_population.csv",stringsAsFactors = FALSE)

head(raceE)
head(hispE)
head(age_sexE)

population <- population[-c(4)]
population <- population[-1,]
colnames(population) <- c("geo_id","block_group_name","population")
head(population)

conE <- age
conE$m <- ageE$m0_9+ageE$m10_19+ageE$m20_29+ageE$m30_39+ageE$m40_49+ageE$m50_59+ageE$m60_69+ageE$m70_79+ageE$m80_89
conE$f <- ageE$f0_9+ageE$f10_19+ageE$f20_29+ageE$f30_39+ageE$f40_49+ageE$f50_59+ageE$f60_69+ageE$f70_79+ageE$f80_89
colnames(conE) <- conNamesE

head(conE)

conE <- cbind(conE,raceE)
conE <- cbind(conE,hispE)

conE <- cbind(population,conE)
conE$population <- 0

head(conE)

write.csv(conE, "preprocessing/processed/cons_error.csv", row.names = F)