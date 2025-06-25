#!/bin/bash

#Constraint Files
cons_canada_ct="../census_data/Processed/Canada/CT/cons_canada_ct.csv"
cons_canada_da="../census_data/Processed/Canada/DA/cons_canada_da.csv"
cons_canada_da_add="../census_data/Processed/Canada/DA_ADD/cons_canada_da_add.csv"

cons_us_cbg="../census_data/Processed/US/CBG/cons_us_cbg.csv"
cons_us_ct="../census_data/Processed/US/CT/cons_us_ct.csv"


#Ind Files
inds_canada_ct="../census_data/Processed/Canada/CT/inds_canada_ct.csv"
inds_canada_da="../census_data/Processed/Canada/DA/inds_canada_da.csv"
inds_canada_da_add="../census_data/Processed/Canada/DA_ADD/inds_canada_da_add.csv"

inds_us_cbg="../census_data/Processed/US/CBG/inds_us_cbg.csv"
inds_us_ct="../census_data/Processed/US/CT/inds_us_ct.csv"


#CONDITIONAL PROBABILITY
echo -n "Running Conditional Probability..."
#US CBG
python3 ../methods/conditional_probability/conditional_probability_fairfax_CBG.py $cons_us_cbg $inds_us_cbg
#US CT
python3 ../methods/conditional_probability/conditional_probability_fairfax_CT.py $cons_us_ct $inds_us_ct
#Canada DA
python3 ../methods/conditional_probability/conditional_probability_vancouver_DA.py $cons_canada_da $inds_canada_da
#Canada CT
python3 ../methods/conditional_probability/conditional_probability_vancouver_CT.py $cons_canada_ct $inds_canada_ct
#Canada DA Add
python3 ../methods/conditional_probability/conditional_probability_vancouver_DA_add.py $cons_canada_da_add $inds_canada_da_add
echo "Finished"

#ITERATIVE PROPORTIONAL FITTING
echo -n "Running Iterative Proportional Fitting..."
#US CBG
Rscript ../methods/iterative_proportional_fitting/ipf_fairfax_CBG.R $cons_us_cbg $inds_us_cbg
#US CT
Rscript ../methods/iterative_proportional_fitting/ipf_fairfax_CT.R $cons_us_ct $inds_us_ct
#Canada DA
Rscript ../methods/iterative_proportional_fitting/ipf_vancouver_DA.R $cons_canada_da $inds_canada_da
#Canada CT
Rscript ../methods/iterative_proportional_fitting/ipf_vancouver_CT.R $cons_canada_ct $inds_canada_ct
#Canada DA Add
Rscript ../methods/iterative_proportional_fitting/ipf_vancouver_DA_add.R $cons_canada_da_add $inds_canada_da_add
echo "Finished"

#HILL CLIMBING
echo -n "Running Hill Climbing..."
#US CBG
python3 ../methods/hill_climbing/hill_climbing_fairfax_CBG.py $cons_us_cbg $inds_us_cbg
#US CT
python3 ../methods/hill_climbing/hill_climbing_fairfax_CT.py $cons_us_ct $inds_us_ct
#Canada DA
python3 ../methods/hill_climbing/hill_climbing_vancouver_DA.py $cons_canada_da $inds_canada_da
#Canada CT
python3 ../methods/hill_climbing/hill_climbing_vancouver_CT.py $cons_canada_ct $inds_canada_ct
#Canada DA Add
python3 ../methods/hill_climbing/hill_climbing_vancouver_DA_add.py $cons_canada_da_add $inds_canada_da_add
echo "Finished"

#SIMULATED ANNEALING
echo -n "Running Simulated Annealing..."
#US CBG
python3 ../methods/simulated_annealing/simulated_annealing_fairfax_CBG.py $cons_us_cbg $inds_us_cbg
#US CT
python3 ../methods/simulated_annealing/simulated_annealing_fairfax_CT.py $cons_us_ct $inds_us_ct
#Canada DA
python3 ../methods/simulated_annealing/simulated_annealing_vancouver_DA.py $cons_canada_da $inds_canada_da
#Canada CT
python3 ../methods/simulated_annealing/simulated_annealing_vancouver_CT.py $cons_canada_ct $inds_canada_ct
#Canada DA Add
python3 ../methods/simulated_annealing/simulated_annealing_vancouver_DA_add.py $cons_canada_da_add $inds_canada_da_add
echo "Finished"

#RANDOM PICK WITH REPLACEMENT
echo -n "Running Random Pick With Replacement..."
#US CBG
python3 ../methods/random_pick_with_replacement/random_pick_with_replacement_fairfax_CBG.py $cons_us_cbg $inds_us_cbg
#US CT
python3 ../methods/random_pick_with_replacement/random_pick_with_replacement_fairfax_CT.py $cons_us_ct $inds_us_ct
#Canada DA
python3 ../methods/random_pick_with_replacement/random_pick_with_replacement_vancouver_DA.py $cons_canada_da $inds_canada_da
#Canada CT
python3 ../methods/random_pick_with_replacement/random_pick_with_replacement_vancouver_CT.py $cons_canada_ct $inds_canada_ct
#Canada DA Add
python3 ../methods/random_pick_with_replacement/random_pick_with_replacement_vancouver_DA_add.py $cons_canada_da_add $inds_canada_da_add
echo "Finished"

