import pandas as pd
import numpy as np

cons = pd.read_csv("../census_data/Processed/Canada/DA/cons_canada_da.csv")

lang = pd.read_csv("../census_data/Raw/Canada/DA/language/fTFRzPdmj_data.csv")

official_lang = []
no_official_lang = []
counter= 0
for index, row in lang.iterrows():
    if row['COL0'] in cons['geo_id'].to_list():
        b = int(row['COL2'])+int(row['COL4'])
        c = cons.iloc[counter]['population']-b
        if c <= 0: c = 0
        official_lang.append(b)
        no_official_lang.append(c)
        counter+=1
official_lang = pd.Series(official_lang)
no_official_lang = pd.Series(no_official_lang)
cons['official_lang'] = official_lang
cons['no.official_lang'] = no_official_lang

work_lang = pd.read_csv("../census_data/Raw/Canada/DA/language_of_work/7KNwCwQjF_data.csv")

work_official_lang = []
work_no_official_lang = []
counter= 0
for index, row in work_lang.iterrows():
    if row['COL0'] in cons['geo_id'].to_list():
        b = int(row['COL3'])
        c = cons.iloc[counter]['population']-b
        if c <= 0: c = 0
        work_official_lang.append(b)
        work_no_official_lang.append(c)
        counter+=1
work_official_lang = pd.Series(work_official_lang)
work_no_official_lang = pd.Series(work_no_official_lang)
cons['work.official_lang'] = work_official_lang
cons['work.no.official_lang'] = work_no_official_lang

marital_status = pd.read_csv("../census_data/Raw/Canada/DA/marital_status/BtslVkdRzd_data.csv")

never_married = []
married = []
living_common_law = []
separated = []
divorced = []
widowed = []
counter = 0
for index, row in marital_status.iterrows():
    if row['COL0'] in cons['geo_id'].to_list():
        b = int(row['COL3'])
        c = int(row['COL4'])
        d = int(row['COL7'])
        e = int(row['COL8'])
        f = int(row['COL9'])
        a = cons.iloc[counter]['population']-(b+c+d+e+f)
        never_married.append(a)
        married.append(b)
        living_common_law.append(c)
        separated.append(d)
        divorced.append(e)
        widowed.append(f)
        counter+=1
never_married = pd.Series(never_married)
married = pd.Series(married)
living_common_law = pd.Series(living_common_law)
separated = pd.Series(separated)
divorced = pd.Series(divorced)
widowed = pd.Series(widowed)
cons['no.married'] = never_married
cons['married'] = married
cons['living.common.law'] = living_common_law
cons['separated'] = separated
cons['divorced'] = divorced
cons['widowed'] = widowed


dwelling_type = pd.read_csv("../census_data/Raw/Canada/DA/dwelling_type/dtDB1korKk_data.csv")

s_d_house = []
apartment = []
other = []
counter = 0
for index, row in dwelling_type.iterrows():
    if row['COL0'] in cons['geo_id'].to_list():
        b = int(row['COL2'])
        c = int(row['COL3'])
        a = cons.iloc[counter]['population']-(b+c)
        s_d_house.append(b)
        apartment.append(c)
        other.append(a)
        counter+=1
s_d_house = pd.Series(s_d_house)
apartment = pd.Series(apartment)
other = pd.Series(other)
cons['single.detached.house'] = s_d_house
cons['apartment'] = apartment
cons['other.attached'] = other

mobility = pd.read_csv("../census_data/Raw/Canada/DA/mobility/pjDaFmOQlc0_data.csv")

non_movers = []
nonmigrants_movers = []
interprovincial_movers = []
external_movers = []
other_movers = []
counter = 0
for index, row in mobility.iterrows():
    if row['COL0'] in cons['geo_id'].to_list():
        a = int(row['COL2'])
        b = int(row['COL4'])
        c = int(row['COL8'])
        d = int(row['COL9'])
        e = cons.iloc[counter]['population']-(a+b+c+d)
        if e < 0:
            a = a+e
            e = 0
        non_movers.append(a)
        nonmigrants_movers.append(b)
        interprovincial_movers.append(c)
        external_movers.append(d)
        other_movers.append(e)
        counter+=1
non_movers = pd.Series(non_movers)
nonmigrants_movers = pd.Series(nonmigrants_movers)
interprovincial_movers = pd.Series(interprovincial_movers)
external_movers = pd.Series(external_movers)
other_movers = pd.Series(other_movers)

cons['non.movers'] = non_movers
cons['nonmigrants.movers'] = nonmigrants_movers
cons['interprovincial.movers'] = interprovincial_movers
cons['external.movers'] = external_movers
cons['other.movers'] = other_movers

cons.to_csv("../census_data/Processed/Canada/DA_ADD/cons_canada_da_add.csv", index=False)