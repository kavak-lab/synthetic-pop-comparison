population_list = list("population")
age_list = list("0_9", "10_19", "20_29", "30_39", "40_49", "50_59", "60_69", "70_79", "80_89")
gender_list = list("m", "f")
race_list = list("asian","black","other","two.","white")
emp_list = list("armed.forces","civilian.employed","not.in.labor.force","unemployed")
mob_list = list("abroad.house","diff.us.house","same.house")
inc_list = list("i.0.9999","i.10000.14999","i.15000.24999","i.25000.34999","i.35000.49999","i.50000.64999","i.65000.74999","i.75000.99999")
cit_list = list("abroad.born","naturalization","not.citizen","puerto.rico.born","us.born")
mar_list = list("divorced","married","never","separated","widowed")
sch_list = list("no.schooling","private","public")
dis_list = list("with.disability","without.disability")
wrk_list = list("federal","local","not.working","private.no.profit","private.profit","self.employed.corp","self.employed.no.corp","state")
ins_list = list("with.insurance","without.insurance")

total_list_of_names = c(population_list, age_list, gender_list, emp_list, mob_list, inc_list, cit_list, mar_list, sch_list, dis_list, wrk_list, ins_list, race_list)
total_number_of_column = length(population_list) + length(age_list) + length(gender_list) + length(emp_list) + length(mob_list) + length(inc_list) + length(cit_list) + length(mar_list) + length(sch_list) + length(dis_list) + length(wrk_list) + length(ins_list) + length(race_list)

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
  emp_column = synth_block_group$EMP
  mob_column = synth_block_group$MOB
  inc_column = synth_block_group$INC
  cit_column = synth_block_group$CIT
  mar_column = synth_block_group$MAR
  sch_column = synth_block_group$SCH
  dis_column = synth_block_group$DIS
  wrk_column = synth_block_group$WRK
  ins_column = synth_block_group$INS
  race_column = synth_block_group$RACE
  
  aggregate_data = data.frame(matrix(0, ncol = total_number_of_column, nrow = 1))
  names(aggregate_data) = total_list_of_names
  
  counter = 1
  aggregate_data[population_list[[1]]] = population
  while(counter<=population){
    if(age_column[counter] == '90_99'){aggregate_data['80_89'] = aggregate_data['80_89'] + 1}
    else{aggregate_data[age_column[counter]] = aggregate_data[age_column[counter]] + 1}
    
    aggregate_data[gender_column[counter]] = aggregate_data[gender_column[counter]] + 1
    aggregate_data[emp_column[counter]] = aggregate_data[emp_column[counter]] + 1
    aggregate_data[mob_column[counter]] = aggregate_data[mob_column[counter]] + 1
    aggregate_data[inc_column[counter]] = aggregate_data[inc_column[counter]] + 1
    aggregate_data[cit_column[counter]] = aggregate_data[cit_column[counter]] + 1
    aggregate_data[mar_column[counter]] = aggregate_data[mar_column[counter]] + 1
    aggregate_data[sch_column[counter]] = aggregate_data[sch_column[counter]] + 1
    aggregate_data[dis_column[counter]] = aggregate_data[dis_column[counter]] + 1
    aggregate_data[wrk_column[counter]] = aggregate_data[wrk_column[counter]] + 1
    aggregate_data[ins_column[counter]] = aggregate_data[ins_column[counter]] + 1
    aggregate_data[race_column[counter]] = aggregate_data[race_column[counter]] + 1
    
    counter = counter + 1
  }
  global_aggregate_data <- rbind(global_aggregate_data, aggregate_data)
  #print(paste("Completed zone", block_group_counter))
  block_group_counter = block_group_counter + 1
  
}
#print(global_aggregate_data)
write.csv(global_aggregate_data, file = paste0("../synthetic_data/US/CT/synthetic_group_data_",abbrev, ".csv"), row.names = FALSE)