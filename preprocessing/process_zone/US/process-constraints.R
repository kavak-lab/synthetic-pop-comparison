conNames <- c("m0_9", "m10_19", "m20_29", "m30_39", "m40_49", "m50_59","m60_69","m70_79","m80_89",
              "f0_9", "f10_19", "f20_29", "f30_39", "f40_49", "f50_59","f60_69","f70_79","f80_89","m","f")

age <- read.csv("../preprocessing/processed/processed_sex_age.csv",stringsAsFactors = FALSE)
race <- read.csv("../preprocessing/processed/processed_race.csv",stringsAsFactors = FALSE)

geo_type <- commandArgs(trailingOnly = TRUE)
file_name <- paste(paste("../census_data/Raw/US/", geo_type, sep=""), "/ACSDT5Y_total_population.csv",sep="")
population <- read.csv(file_name,stringsAsFactors = FALSE)


population <- population[-c(4)]
population <- population[-1,]
#tract_name
colnames(population) <- c("geo_id","block_group_name","population")

con <- age
con$m <- age$m0_9+age$m10_19+age$m20_29+age$m30_39+age$m40_49+age$m50_59+age$m60_69+age$m70_79+age$m80_89
con$f <- age$f0_9+age$f10_19+age$f20_29+age$f30_39+age$f40_49+age$f50_59+age$f60_69+age$f70_79+age$f80_89
colnames(con) <- conNames

con <- cbind(con,race)
con <- cbind(population,con)

if (geo_type == "CBG"){
    hisp <- read.csv("../preprocessing/processed/processed_hispanic.csv",stringsAsFactors = FALSE)
    #hh <- read.csv("../preprocessing/processed/processed_household.csv",stringsAsFactors = FALSE)
    con <- cbind(con, hisp)
    #con <- cbind(con, hh)
    file_out <- "../census_data/Processed/US/CBG/cons_us_cbg.csv"
    write.csv(con, file_out, row.names = F)
} else {
    file_out <- "../census_data/Processed/US/CT/cons_us_ct.csv"
    write.csv(con, file_out, row.names = F)
}
