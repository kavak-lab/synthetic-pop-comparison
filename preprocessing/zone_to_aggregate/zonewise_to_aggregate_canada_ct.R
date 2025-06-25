population_list = list("population")
age_list = list('a0_4', 'a5_9', 'a10_14', 'a15_19', 'a20_24', 'a25_29', 'a30_34', 'a35_39', 'a40_44', 'a45_49', 'a50_54', 'a55_59', 'a60_64', 'a65_69', 'a70_74', 'a75_79', 'a80_84', 'a85_')
gender_list = list("f", "m")
race_list = list('naao', 'onao_Canadian', 'onao', 'eo_bio_English', 'eo_bio_Irish', 'eo_bio_Scottish', 'eo_obio', 'eo_fo', 'eo_weo_Dutch', 'eo_weo_German', 'eo_oweo', 'eo_neo', 'eo_eeo_Hungarian', 'eo_eeo_Polish', 'eo_eeo_Russian', 'eo_eeo_Ukrainian','eo_oeeo','eo_seo_Greek','eo_seo_Italian','eo_seo_Portuguese','eo_seo_Spanish','eo_oseo','eo_oeo','co_Jamaican','oco','lcsao','ao','ao_wcameo','ao_sao_ei','ao_osao','ao_esao_Chinese','ao_esao_Filipino','ao_oesao','oo')

total_list_of_names = c(population_list, age_list, gender_list, race_list)
total_number_of_column = length(population_list) + length(age_list) + length(gender_list) + length(race_list)


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
  
  aggregate_data = data.frame(matrix(0, ncol = total_number_of_column, nrow = 1))
  names(aggregate_data) = total_list_of_names
  
  counter = 1
  aggregate_data[population_list[[1]]] = population
  while(counter<=population){
    aggregate_data[age_column[counter]] = aggregate_data[age_column[counter]] + 1
    aggregate_data[gender_column[counter]] = aggregate_data[gender_column[counter]] + 1
    aggregate_data[race_column[counter]] = aggregate_data[race_column[counter]] + 1
    
    counter = counter + 1
  }
  #print(aggregate_data)
  global_aggregate_data <- rbind(global_aggregate_data, aggregate_data)
  #print(paste("Completed zone", block_group_counter))
  block_group_counter = block_group_counter + 1
}

#print(global_aggregate_data)
write.csv(global_aggregate_data, file = paste0("../synthetic_data/Canada/CT/synthetic_group_data_",abbrev, ".csv"), row.names = FALSE)