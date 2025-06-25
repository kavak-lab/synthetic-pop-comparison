#!/bin/bash

#Constraint Files
cons_canada_ct="../census_data/Processed/Canada/CT/cons_canada_ct.csv"
cons_canada_da="../census_data/Processed/Canada/DA/cons_canada_da.csv"
cons_canada_da_add="../census_data/Processed/Canada/DA_ADD/cons_canada_da_add.csv"

cons_us_cbg="../census_data/Processed/US/CBG/cons_us_cbg.csv"
cons_us_ct="../census_data/Processed/US/CT/cons_us_ct.csv"


#US CBG
echo -n "Aggregating all US CBG..."
us_cbg_path="../synthetic_data/US/CBG"
Rscript ../preprocessing/zone_to_aggregate/zonewise_to_aggregate_us_cbg.R $us_cbg_path "conditional_probability" $cons_us_cbg "CP"
Rscript ../preprocessing/zone_to_aggregate/zonewise_to_aggregate_us_cbg.R $us_cbg_path "hill_climbing" $cons_us_cbg "HC"
Rscript ../preprocessing/zone_to_aggregate/zonewise_to_aggregate_us_cbg.R $us_cbg_path "simulated_annealing" $cons_us_cbg "SA"
Rscript ../preprocessing/zone_to_aggregate/zonewise_to_aggregate_us_cbg.R $us_cbg_path "random_pick_with_replacement" $cons_us_cbg "RPWR"
Rscript ../preprocessing/zone_to_aggregate/zonewise_to_aggregate_us_cbg.R $us_cbg_path "ipf" $cons_us_cbg "IPF"
echo "Finished"

#US CT
echo -n "Aggregating all US CT..."
us_ct_path="../synthetic_data/US/CT"
Rscript ../preprocessing/zone_to_aggregate/zonewise_to_aggregate_us_ct.R $us_ct_path "conditional_probability" $cons_us_ct "CP"
Rscript ../preprocessing/zone_to_aggregate/zonewise_to_aggregate_us_ct.R $us_ct_path "hill_climbing" $cons_us_ct "HC"
Rscript ../preprocessing/zone_to_aggregate/zonewise_to_aggregate_us_ct.R $us_ct_path "simulated_annealing" $cons_us_ct "SA"
Rscript ../preprocessing/zone_to_aggregate/zonewise_to_aggregate_us_ct.R $us_ct_path "random_pick_with_replacement" $cons_us_ct "RPWR"
Rscript ../preprocessing/zone_to_aggregate/zonewise_to_aggregate_us_ct.R $us_ct_path "ipf" $cons_us_ct "IPF"
echo "Finished"

#Canada DA
echo -n "Aggregating all Canada DA..."
canada_da_path="../synthetic_data/Canada/DA"
Rscript ../preprocessing/zone_to_aggregate/zonewise_to_aggregate_canada_da.R $canada_da_path "conditional_probability" $cons_canada_da "CP"
Rscript ../preprocessing/zone_to_aggregate/zonewise_to_aggregate_canada_da.R $canada_da_path "hill_climbing" $cons_canada_da "HC"
Rscript ../preprocessing/zone_to_aggregate/zonewise_to_aggregate_canada_da.R $canada_da_path "simulated_annealing" $cons_canada_da "SA"
Rscript ../preprocessing/zone_to_aggregate/zonewise_to_aggregate_canada_da.R $canada_da_path "random_pick_with_replacement" $cons_canada_da "RPWR"
Rscript ../preprocessing/zone_to_aggregate/zonewise_to_aggregate_canada_da.R $canada_da_path "ipf" $cons_canada_da "IPF"
echo "Finished"

#Canada CT
echo -n "Aggregating all Canada CT..."
canada_ct_path="../synthetic_data/Canada/CT"
Rscript ../preprocessing/zone_to_aggregate/zonewise_to_aggregate_canada_ct.R $canada_ct_path "conditional_probability" $cons_canada_ct "CP"
Rscript ../preprocessing/zone_to_aggregate/zonewise_to_aggregate_canada_ct.R $canada_ct_path "hill_climbing" $cons_canada_ct "HC"
Rscript ../preprocessing/zone_to_aggregate/zonewise_to_aggregate_canada_ct.R $canada_ct_path "simulated_annealing" $cons_canada_ct "SA"
Rscript ../preprocessing/zone_to_aggregate/zonewise_to_aggregate_canada_ct.R $canada_ct_path "random_pick_with_replacement" $cons_canada_ct "RPWR"
Rscript ../preprocessing/zone_to_aggregate/zonewise_to_aggregate_canada_ct.R $canada_ct_path "ipf" $cons_canada_ct "IPF"
echo "Finished"

#Canada DA Add
echo -n "Aggregating all Canada DA_ADD..."
canada_da_add_path="../synthetic_data/Canada/DA_ADD"
Rscript ../preprocessing/zone_to_aggregate/zonewise_to_aggregate_canada_da_add.R $canada_da_add_path "conditional_probability" $cons_canada_da_add "CP"
Rscript ../preprocessing/zone_to_aggregate/zonewise_to_aggregate_canada_da_add.R $canada_da_add_path "hill_climbing" $cons_canada_da_add "HC"
Rscript ../preprocessing/zone_to_aggregate/zonewise_to_aggregate_canada_da_add.R $canada_da_add_path "simulated_annealing" $cons_canada_da_add "SA"
Rscript ../preprocessing/zone_to_aggregate/zonewise_to_aggregate_canada_da_add.R $canada_da_add_path "random_pick_with_replacement" $cons_canada_da_add "RPWR"
Rscript ../preprocessing/zone_to_aggregate/zonewise_to_aggregate_canada_da_add.R $canada_da_add_path "ipf" $cons_canada_da_add "IPF"
echo "Finished"