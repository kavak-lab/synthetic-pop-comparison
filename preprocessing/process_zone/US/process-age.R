ageNames <- c("m0_9", "m10_19", "m20_29", "m30_39", "m40_49", "m50_59","m60_69","m70_79","m80_89",
              "f0_9", "f10_19", "f20_29", "f30_39", "f40_49", "f50_59","f60_69","f70_79","f80_89") # the output we want

geo_type <- commandArgs(trailingOnly = TRUE)
file_name <- paste(paste("../census_data/Raw/US/", geo_type, sep=""), "/ACSDT5Y_sex_by_age.csv",sep="")
age <- read.csv(file_name,stringsAsFactors = FALSE)
even_indexes<-seq(2,100,2)
age <- age[-c(1,even_indexes)]
age <- age[-c(1,2,26)]
age <- age[-1,]

rawNames <- age[1,]

cols <- seq(1,46)
colnames(age) <- cols

#head(age)

age<-cbind(age,rowSums(sapply(age[,c(1,2)],as.numeric)))
age<-cbind(age,rowSums(sapply(age[,c(3,4,5)],as.numeric)))
age<-cbind(age,rowSums(sapply(age[,c(6,7,8,9)],as.numeric)))
age<-cbind(age,rowSums(sapply(age[,c(10,11)],as.numeric)))
age<-cbind(age,rowSums(sapply(age[,c(12,13)],as.numeric)))
age<-cbind(age,rowSums(sapply(age[,c(14,15)],as.numeric)))
age<-cbind(age,rowSums(sapply(age[,c(16,17,18,19)],as.numeric)))
age<-cbind(age,rowSums(sapply(age[,c(20,21)],as.numeric)))
age<-cbind(age,rowSums(sapply(age[,c(22,23)],as.numeric)))

age<-cbind(age,rowSums(sapply(age[,c(24,25)],as.numeric)))
age<-cbind(age,rowSums(sapply(age[,c(26,27,28)],as.numeric)))
age<-cbind(age,rowSums(sapply(age[,c(29,30,31,32)],as.numeric)))
age<-cbind(age,rowSums(sapply(age[,c(33,34)],as.numeric)))
age<-cbind(age,rowSums(sapply(age[,c(35,36)],as.numeric)))
age<-cbind(age,rowSums(sapply(age[,c(37,38)],as.numeric)))
age<-cbind(age,rowSums(sapply(age[,c(39,40,41,42)],as.numeric)))
age<-cbind(age,rowSums(sapply(age[,c(43,44)],as.numeric)))
age<-cbind(age,rowSums(sapply(age[,c(45,46)],as.numeric)))


age<-age[,-c(1:46)]
colnames(age) <- ageNames

write.csv(age, "../preprocessing/processed/processed_sex_age.csv", row.names = F)

