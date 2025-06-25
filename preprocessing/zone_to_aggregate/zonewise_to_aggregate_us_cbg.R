population_list = list("population")
age_list = list("0_9", "10_19", "20_29", "30_39", "40_49", "50_59", "60_69", "70_79", "80_89")
gender_list = list("m", "f")
ethnicity_list = list("not.hisp.latino", "hisp.latino")
race_list = list("white", "black.aa","a.ind..nat.ak", "asian", "nat.hi.pt.isl", "other", "two.")

total_list_of_names = c(population_list, age_list, gender_list, race_list, ethnicity_list)
total_number_of_column = length(population_list) + length(age_list) + length(gender_list) + length(race_list) + length(ethnicity_list)

global_aggregate_data = data.frame(matrix(ncol = total_number_of_column, nrow = 0))
names(global_aggregate_data) = total_list_of_names



block_group_counter = 1
args <- commandArgs(trailingOnly=TRUE)
path <- args[1]
method <- args[2]
cons <- read.csv(args[3], stringsAsFactors = FALSE)
abbrev <- args[4]
whole_path <- paste0(paste0(path, "/", sep=""), method, sep="")
while(block_group_counter<=nrow(cons)){
  synth_block_group <- read.csv(paste0(whole_path, "/", block_group_counter,".csv"),stringsAsFactors = FALSE)
  
  population = nrow(synth_block_group)
  age_column = synth_block_group$AGE
  gender_column = synth_block_group$SEX
  race_column = synth_block_group$RACE
  ethnicity_column = synth_block_group$HISP
  
  
  aggregate_data = data.frame(matrix(0, ncol = total_number_of_column, nrow = 1))
  names(aggregate_data) = total_list_of_names
  
  counter = 1
  aggregate_data[population_list[[1]]] = population
  while(counter<=population){
    if(age_column[counter] == '90_99'){aggregate_data['80_89'] = aggregate_data['80_89'] + 1}
    else{aggregate_data[age_column[counter]] = aggregate_data[age_column[counter]] + 1}
    
    aggregate_data[gender_column[counter]] = aggregate_data[gender_column[counter]] + 1
    aggregate_data[ethnicity_column[counter]] = aggregate_data[ethnicity_column[counter]] + 1
    aggregate_data[race_column[counter]] = aggregate_data[race_column[counter]] + 1
    
    counter = counter + 1
  }
  #print(aggregate_data)
  global_aggregate_data <- rbind(global_aggregate_data, aggregate_data)
  #print(paste("Completed zone", block_group_counter))
  block_group_counter = block_group_counter + 1
  
}
#print(global_aggregate_data)
write.csv(global_aggregate_data, file = paste0("../synthetic_data/US/CBG/synthetic_group_data_",abbrev, ".csv"), row.names = FALSE)