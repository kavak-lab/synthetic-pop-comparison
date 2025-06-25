import pandas as pd
import numpy as np

ch = {"a.0.9":"0_9","a.10.19":"10_19","a.20.29":"20_29","a.30.39":"30_39","a.40.49":"40_49","a.50.59":"50_59","a.60.69":"60_69","a.70.79":"70_79","a.80.89":"80_89","a.90.99":"90_99", "two":"two."}

ind_raw = pd.read_csv("../census_data/Processed/US/CT/orig_inds.csv")
ind_raw.columns = ['id', 'AGE', 'SEX', 'EMP', 'MOB', 'INC', 'CIT', 'MAR', 'SCH', 'DIS','WRK', 'INS', 'RACE']

raw_label = pd.read_csv("../census_data/Processed/US/CT/orig_labels.csv") 
raw_label = raw_label.iloc[:13053,0:1] 
more_label = pd.read_csv("../census_data/Processed/US/CT/inds_us_ct_sk.csv")     
more_label = more_label.iloc[:13053,1:5]
new_label = pd.concat([raw_label,more_label], axis=1)

for i in range(len(ind_raw)):
    for j in range(len(ind_raw.iloc[i])):
        att = ind_raw.iloc[i,j]
        if att in ch:
            ind_raw.iloc[i,j] = ch[att]
ind_raw = pd.concat([new_label, ind_raw.iloc[:,1:]], axis=1)
ind_raw.to_csv("../census_data/Processed/US/CT/inds_us_ct.csv", index=False)


