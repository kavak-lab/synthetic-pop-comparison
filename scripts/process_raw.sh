#!/bin/bash

#US DATA
#Create cons for CBG
echo -n "Creating constraint file for US CBG..."
Rscript ../preprocessing/process_zone/US/process-age.R CBG &
Rscript ../preprocessing/process_zone/US/process-race.R CBG &
Rscript ../preprocessing/process_zone/US/process-hispanic.R &
Rscript ../preprocessing/process_zone/US/process-household.R

Rscript ../preprocessing/process_zone/US/process-constraints.R CBG

cbg_path="../census_data/Processed/US/CBG/cons_us_cbg.csv"
python3 ../preprocessing/process_zone/US/refactor-constraints.py $cbg_path "us_cbg" "CBG"

#Remove intermediate files
rm ../preprocessing/processed/processed_hispanic.csv &
rm ../preprocessing/processed/processed_race.csv &
rm ../preprocessing/processed/processed_sex_age.csv &
rm ../preprocessing/processed/processed_household.csv
echo "Finished"

#Create cons for CT
echo -n "Creating constraint file for US CT..."
Rscript ../preprocessing/process_zone/US/process-age.R CT &
Rscript ../preprocessing/process_zone/US/process-race.R CT

Rscript ../preprocessing/process_zone/US/process-constraints.R CT

ct_path="../census_data/Processed/US/CT/cons_us_ct.csv"
python3 ../preprocessing/process_zone/US/refactor-constraints.py $ct_path "us_ct" "CT"
python3 ../preprocessing/process_zone/US/process-US-CT.py

#Remove intermediate files
rm ../preprocessing/processed/processed_race.csv &
rm ../preprocessing/processed/processed_sex_age.csv
echo "Finished"

#Create inds for US
echo -n "Creating individual microdata file for US..."
python3 ../preprocessing/process_zone/US/process-ind.py
python3 ../preprocessing/process_zone/US/process_ind_ct.py
echo "Finished"


#CANADA DATA
#Create cons for DA
echo -n "Creating constraint file for Canada DA..."
Rscript ../preprocessing/process_zone/Canada/process_DA.R
echo "Finished"

#Create cons for CT
echo -n "Creating constraint file for Canada CT..."
Rscript ../preprocessing/process_zone/Canada/process_CT.R
echo "Finished"

#Create cons for DA_add
echo -n "Creating individual microdata file for Canada..."
python3 ../preprocessing/process_zone/Canada/process_DA_add.py
echo "Finished"