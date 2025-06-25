import pandas as pd
import numpy as np
import scipy.constants as sp
import time
from collections import Counter
from pandas import DataFrame
import random
import sys

cons = pd.read_csv(sys.argv[1])
inds = pd.read_csv(sys.argv[2]) #only used for formatting, not algorithm

cons = cons.loc[:,'population':'hisp.latino'].astype('int64')

num_cbg = len(cons)

for i in range(0,num_cbg):
    population_num = cons['population'][i]
    List = []
    for j in range (0, population_num):
        sex = 'default'
        age_group = 'default'
        race = 'default'
        ethnicity = 'default'
        #official_lang = 'default'
        #work_official_lang = 'default'
        
        
        total = cons['f'][i] + cons['m'][i]
        if (total==0):
            print(i)
            print("sx")
        
        per_F = cons['f'][i] / total * 100
        per_M = cons['m'][i] / total * 100
        
        random.seed((i+1)*(j+1)*1)
        dice_roll = random.random()*100
        
        if (dice_roll<=per_M):
            sex = 'm'
        if (dice_roll>per_M):
            sex = 'f'
        
        
        total = cons['0_9'][i] + cons['10_19'][i] + cons['20_29'][i] + cons['30_39'][i] + cons['40_49'][i] + cons['50_59'][i] + cons['60_69'][i] +cons['70_79'][i] +cons['80_89'][i] 
        if (total==0):
            print(i)
            print("age")
        
        per_m0_9 = cons['0_9'][i] / total * 100
        per_m10_19 = cons['10_19'][i] / total * 100
        per_m20_29 = cons['20_29'][i] / total * 100
        per_m30_39 = cons['30_39'][i] / total * 100
        per_m40_49 = cons['40_49'][i] / total * 100
        per_m50_59 = cons['50_59'][i] / total * 100
        per_m60_69 = cons['60_69'][i] / total * 100
        per_m70_79 = cons['70_79'][i] / total * 100
        per_m80_89 = cons['80_89'][i] / total * 100
    
        chance_cat1 = per_m0_9
        chance_cat2 = chance_cat1 + per_m10_19
        chance_cat3 = chance_cat2 + per_m20_29
        chance_cat4 = chance_cat3 + per_m30_39
        chance_cat5 = chance_cat4 + per_m40_49
        chance_cat6 = chance_cat5 + per_m50_59
        chance_cat7 = chance_cat6 + per_m60_69
        chance_cat8 = chance_cat7 + per_m70_79
        chance_cat9 = chance_cat8 + per_m80_89
        
        random.seed((i+1)*(j+1)*2)
        dice_roll = random.random()*100
        
        if (dice_roll < chance_cat1):
            age_group = '0_9'
        if (dice_roll >= chance_cat1 and dice_roll <= chance_cat2):
            age_group = '10_19'
        if (dice_roll > chance_cat2 and dice_roll <= chance_cat3):
            age_group = '20_29'
        if (dice_roll > chance_cat3 and dice_roll <= chance_cat4):
            age_group = '30_39'
        if (dice_roll > chance_cat4 and dice_roll <= chance_cat5):
            age_group = '40_49'
        if (dice_roll > chance_cat5 and dice_roll <= chance_cat6):
            age_group = '50_59'
        if (dice_roll > chance_cat6 and dice_roll <= chance_cat7):
            age_group = '60_69'
        if (dice_roll > chance_cat7 and dice_roll <= chance_cat8):
            age_group = '70_79'
        if (dice_roll > chance_cat8 and dice_roll <= chance_cat9):
            age_group = '80_89'

        total = cons['white'][i] + cons['black.aa'][i]+ cons['a.ind..nat.ak'][i] + cons['asian'][i] + cons['nat.hi.pt.isl'][i] + cons['other'][i] + cons['two.'][i]
        if (total == 0):
            print(i)
            print("rc")                                      

        
        per_white = cons['white'][i] / total * 100
        per_black_aa = cons['black.aa'][i] / total * 100
        per_a_ind_nat_ak = cons['a.ind..nat.ak'][i] / total * 100
        per_asian = cons['asian'][i] / total * 100
        per_nat_hi_pt_isl = cons['nat.hi.pt.isl'][i] / total * 100
        per_other = cons['other'][i] / total * 100
        per_two = cons['two.'][i] / total * 100

        chance_cat1 = per_white
        chance_cat2 = chance_cat1 + per_black_aa
        chance_cat3 = chance_cat2 + per_a_ind_nat_ak
        chance_cat4 = chance_cat3 + per_asian
        chance_cat5 = chance_cat4 + per_nat_hi_pt_isl
        chance_cat6 = chance_cat5 + per_other
        chance_cat7 = chance_cat6 + per_two
        
        
        random.seed((i+1)*(j+1)*3)
        dice_roll = random.random()*100
    
        if (dice_roll < chance_cat1):
            race = 'white'
        if (dice_roll >= chance_cat1 and dice_roll <= chance_cat2):
            race = 'black.aa'
        if (dice_roll > chance_cat2 and dice_roll <= chance_cat3):
            race = 'a.ind..nat.ak'
        if (dice_roll > chance_cat3 and dice_roll <= chance_cat4):
            race = 'asian'
        if (dice_roll > chance_cat4 and dice_roll <= chance_cat5):
            race = 'nat.hi.pt.isl'
        if (dice_roll > chance_cat5 and dice_roll <= chance_cat6):
            race = 'other'
        if (dice_roll > chance_cat6):
            race = 'two.'
            
        
        
        #not.hisp.latino	hisp.latino
        
            
        total = cons['not.hisp.latino'][i] + cons['hisp.latino'][i]
        if (total==0):
            print(i)
            print("eth")
        
        per_not_hisp_latino = cons['not.hisp.latino'][i] / total * 100
        per_hisp_latino = cons['hisp.latino'][i] / total * 100
        
        random.seed((i+1)*(j+1)*1)
        dice_roll = random.random()*100
        
        if (dice_roll<=per_hisp_latino):
            ethnicity = 'hisp.latino'
        if (dice_roll>per_hisp_latino):
            ethnicity = 'not.hisp.latino'
            
            
        
        
        ind=['NA', 'NA', age_group, sex, race, ethnicity]
        #ind=['NA', 'NA', age_group, sex, race]
        List.append(ind)
    if(len(List)==0):
        df = pd.DataFrame(columns = ['NA', 'NA', 'AGE', 'SEX', 'RACE', 'HISP'])
    else:    
        df = pd.DataFrame(List)
        #print(df)
        df.columns =['NA', 'NA', 'AGE', 'SEX', 'RACE', 'HISP']
        del df['NA']
        df.insert(0, 'REGION', inds['REGION'])
        df.insert(0, 'PUMA', inds['PUMA'])
        df.insert(0, 'SPORDER', inds['SPORDER'])
        df.insert(0, 'DVISION', inds['DVISION'])
        df.insert(0, 'SERIALNO', inds['SERIALNO'])
        columns_titles = ["SERIALNO","DVISION","SPORDER","PUMA","REGION","AGE","SEX","HISP","RACE"]
        df["PWGTP1"] = inds['PWGTP1']

        #df.columns =['NA', 'NA', 'AGE', 'SEX', 'RACE'].format(num=str(i+1)),index=False)
    df.to_csv('../synthetic_data/US/CBG/conditional_probability/{num}.csv'.format(num=str(i+1)),index=False)
    
