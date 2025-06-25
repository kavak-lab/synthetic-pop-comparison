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

cons = cons.loc[:,'population':'white'].astype('int64')

num_ct = len(cons)

for i in range(0,num_ct):
    population_num = cons['population'][i]
    List = []
    for j in range (0, population_num):
        sex = 'default'
        age = 'default'
        race = 'default'
        emp = 'default'
        mob = 'default'
        inc = 'default'
        cit = 'default'
        mar = 'default'
        sch = 'default'
        dis = 'default'
        wrk = 'default'
        ins = 'default'
        
        total = cons['f'][i] + cons['m'][i]
        
        per_F = cons['f'][i] / total * 100
        per_M = cons['m'][i] / total * 100
        
        random.seed((i+1)*(j+1)*1)
        dice_roll = random.random()*100
        
        if (dice_roll<=per_M):
            sex = 'm'
        if (dice_roll>per_M):
            sex = 'f'
        
        total = cons['0_9'][i]+cons['10_19'][i]+cons['20_29'][i]+cons['30_39'][i]+cons['40_49'][i]+cons['50_59'][i]+cons['60_69'][i]+cons['70_79'][i]+cons['80_89'][i]

        per09 = cons['0_9'][i] / total * 100
        per1019 = cons['10_19'][i] / total * 100
        per2029 = cons['20_29'][i] / total * 100
        per3039 = cons['30_39'][i] / total * 100
        per4049 = cons['40_49'][i] / total * 100
        per5059 = cons['50_59'][i] / total * 100
        per6069 = cons['60_69'][i] / total * 100
        per7079 = cons['70_79'][i] / total * 100
        per8089 = cons['80_89'][i] / total * 100

        chance_cat1 = per09
        chance_cat2 = chance_cat1+per1019
        chance_cat3 = chance_cat2+per2029
        chance_cat4 = chance_cat3+per3039
        chance_cat5 = chance_cat4+per4049
        chance_cat6 = chance_cat5+per5059
        chance_cat7 = chance_cat6+per6069
        chance_cat8 = chance_cat7+per7079
        chance_cat9 = chance_cat8+per8089

        random.seed((i+1)*(j+1)*2)
        dice_roll = random.random()*100

        if dice_roll < chance_cat1:
            age = '0_9'
        elif dice_roll < chance_cat2:
            age = '10_19'
        elif dice_roll < chance_cat3:
            age = '20_29'
        elif dice_roll < chance_cat4:
            age = '30_39'
        elif dice_roll < chance_cat5:
            age = '40_49'
        elif dice_roll < chance_cat6:
            age = '50_59'
        elif dice_roll < chance_cat7:
            age = '60_69'
        elif dice_roll < chance_cat8:
            age = '70_79'
        else:
            age = '80_89'

        total = cons['armed.forces'][i] + cons['civilian.employed'][i] + cons['not.in.labor.force'][i] + cons['unemployed'][i]

        per_af = cons['armed.forces'][i] / total * 100
        per_ce = cons['civilian.employed'][i] / total * 100
        per_nilf = cons['not.in.labor.force'][i] / total * 100
        per_u = cons['unemployed'][i] / total * 100

        chance_cat1 = per_af
        chance_cat2 = chance_cat1+per_ce
        chance_cat3 = chance_cat2+per_nilf
        chance_cat4 = chance_cat3+per_u

        random.seed((i+1)*(j+1)*3)
        dice_roll = random.random()*100

        if dice_roll < chance_cat1:
            emp = 'armed.forces'
        elif dice_roll < chance_cat2:
            emp = 'civilian.employed'
        elif dice_roll < chance_cat3:
            emp = 'not.in.labor.force'
        else:
            emp = 'unemployed'

        total = cons['abroad.house'][i] + cons['diff.us.house'][i] + cons['same.house'][i]

        per_ah = cons['abroad.house'][i] / total * 100
        per_duh = cons['diff.us.house'][i] / total * 100
        per_sh = cons['same.house'][i] / total * 100

        chance_cat1 = per_ah
        chance_cat2 = chance_cat1+per_duh
        chance_cat3 = chance_cat2+per_sh

        random.seed((i+1)*(j+1)*4)
        dice_roll = random.random()*100

        if dice_roll < chance_cat1:
            mob = 'abroad.house'
        elif dice_roll < chance_cat2:
            mob = 'diff.us.house'
        else:
            mob = 'same.house'

        total = cons['i.0.9999'][i] + cons['i.10000.14999'][i] + cons['i.15000.24999'][i] + cons['i.25000.34999'][i] + cons['i.35000.49999'][i] + cons['i.50000.64999'][i] + cons['i.65000.74999'][i] + cons['i.75000.99999'][i]

        per09999 = cons['i.0.9999'][i] / total * 100
        per10000 = cons['i.10000.14999'][i] / total * 100
        per15000 = cons['i.15000.24999'][i] / total * 100
        per25000 = cons['i.25000.34999'][i] / total * 100
        per35000 = cons['i.35000.49999'][i] / total * 100
        per50000 = cons['i.50000.64999'][i] / total * 100
        per65000 = cons['i.65000.74999'][i] / total * 100
        per75000 = cons['i.75000.99999'][i] / total * 100

        chance_cat1 = per09999
        chance_cat2 = chance_cat1+per10000
        chance_cat3 = chance_cat2+per15000
        chance_cat4 = chance_cat3+per25000
        chance_cat5 = chance_cat4+per35000
        chance_cat6 = chance_cat5+per50000
        chance_cat7 = chance_cat6+per65000
        chance_cat8 = chance_cat7+per75000

        random.seed((i+1)*(j+1)*5)
        dice_roll = random.random()*100

        if dice_roll < chance_cat1:
            inc = 'i.0.9999'
        elif dice_roll < chance_cat2:
            inc = 'i.10000.14999'
        elif dice_roll < chance_cat3:
            inc = 'i.15000.24999'
        elif dice_roll < chance_cat4:
            inc = 'i.25000.34999'
        elif dice_roll < chance_cat5:
            inc = 'i.35000.49999'
        elif dice_roll < chance_cat6:
            inc = 'i.50000.64999'
        elif dice_roll < chance_cat7:
            inc = 'i.65000.74999'
        else:
            inc = 'i.75000.99999'

        total = cons['abroad.born'][i] + cons['naturalization'][i] + cons['not.citizen'][i] + cons['puerto.rico.born'][i] + cons['us.born'][i]
        
        per_ab = cons['abroad.born'][i] / total * 100
        per_n = cons['naturalization'][i] / total * 100
        per_nc = cons['not.citizen'][i] / total * 100
        per_prb = cons['puerto.rico.born'][i] / total * 100
        per_ub = cons['us.born'][i] / total * 100

        chance_cat1 = per_ab
        chance_cat2 = chance_cat1+per_n
        chance_cat3 = chance_cat2+per_nc
        chance_cat4 = chance_cat3+per_prb
        chance_cat5 = chance_cat4+per_ub

        random.seed((i+1)*(j+1)*6)
        dice_roll = random.random()*100

        if dice_roll < chance_cat1:
            cit = 'abroad.born'
        elif dice_roll < chance_cat2:
            cit = 'naturalization'
        elif dice_roll < chance_cat3:
            cit = 'not.citizen'
        elif dice_roll < chance_cat4:
            cit = 'puerto.rico.born'
        else:
            cit = 'us.born'

        total = cons['divorced'][i] + cons['married'][i] + cons['never'][i] + cons['separated'][i] + cons['widowed'][i]

        per_d = cons['divorced'][i] / total * 100
        per_m = cons['married'][i] / total * 100
        per_n = cons['never'][i] / total * 100
        per_s = cons['separated'][i] / total * 100
        per_w = cons['widowed'][i] / total * 100

        chance_cat1 = per_d
        chance_cat2 = chance_cat1+per_m
        chance_cat3 = chance_cat2+per_n
        chance_cat4 = chance_cat3+per_s
        chance_cat5 = chance_cat4+per_w

        random.seed((i+1)*(j+1)*7)
        dice_roll = random.random()*100

        if dice_roll < chance_cat1:
            mar = 'divorced'
        elif dice_roll < chance_cat2:
            mar = 'married'
        elif dice_roll < chance_cat3:
            mar = 'never'
        elif dice_roll < chance_cat4:
            mar = 'separated'
        else:
            mar = 'widowed'

        total = cons['no.schooling'][i] + cons['private'][i] + cons['public'][i]

        per_ns = cons['no.schooling'][i] / total * 100
        per_p = cons['private'][i] / total * 100
        per_pu = cons['public'][i] / total * 100

        chance_cat1 = per_ns
        chance_cat2 = chance_cat1+per_p
        chance_cat3 = chance_cat2+per_pu

        random.seed((i+1)*(j+1)*8)
        dice_roll = random.random()*100

        if dice_roll < chance_cat1:
            sch = 'no.schooling'
        elif dice_roll < chance_cat2:
            sch = 'private'
        else:
            sch = 'public'
        
        total = cons['with.disability'][i] + cons['without.disability'][i]

        per_wd = cons['with.disability'][i] / total * 100
        per_wod = cons['without.disability'][i] / total * 100

        chance_cat1 = per_wd
        chance_cat2 = chance_cat1+per_wod

        random.seed((i+1)*(j+1)*9)
        dice_roll = random.random()*100

        if dice_roll < chance_cat1:
            dis = 'with.disability'
        else:
            dis = 'without.disability'
        
        total = cons['federal'][i] + cons['local'][i] + cons['not.working'][i] + cons['private.no.profit'][i] + cons['private.profit'][i] + cons['self.employed.corp'][i] + cons['self.employed.no.corp'][i] + cons['state'][i]

        per_f = cons['federal'][i] / total * 100
        per_l = cons['local'][i] / total * 100
        per_nw = cons['not.working'][i] / total * 100
        per_pnp = cons['private.no.profit'][i] / total * 100
        per_pp = cons['private.profit'][i] / total * 100
        per_sec = cons['self.employed.corp'][i] / total * 100
        per_senc = cons['self.employed.no.corp'][i] / total * 100
        per_s = cons['state'][i] / total * 100

        chance_cat1 = per_f
        chance_cat2 = chance_cat1+per_l
        chance_cat3 = chance_cat2+per_nw
        chance_cat4 = chance_cat3+per_pnp
        chance_cat5 = chance_cat4+per_pp
        chance_cat6 = chance_cat5+per_sec
        chance_cat7 = chance_cat6+per_senc
        chance_cat8 = chance_cat7+per_s

        random.seed((i+1)*(j+1)*10)
        dice_roll = random.random()*100

        if dice_roll < chance_cat1:
            wrk = 'federal'
        elif dice_roll < chance_cat2:
            wrk = 'local'
        elif dice_roll < chance_cat3:
            wrk = 'not.working'
        elif dice_roll < chance_cat4:
            wrk = 'private.no.profit'
        elif dice_roll < chance_cat5:
            wrk = 'private.profit'
        elif dice_roll < chance_cat6:
            wrk = 'self.employed.corp'
        elif dice_roll < chance_cat7:
            wrk = 'self.employed.no.corp'
        else:
            wrk = 'state'

        total = cons['with.insurance'][i] + cons['without.insurance'][i]

        per_wi = cons['with.insurance'][i] / total * 100
        per_woi = cons['without.insurance'][i] / total * 100

        chance_cat1 = per_wi
        chance_cat2 = chance_cat1+per_woi

        random.seed((i+1)*(j+1)*11)
        dice_roll = random.random()*100

        if dice_roll < chance_cat1:
            ins = 'with.insurance'
        else:
            ins = 'without.insurance'

        total = cons['white'][i] + cons['black'][i] + cons['asian'][i] + cons['other'][i] + cons['two.'][i]                                    

        per_white = cons['white'][i] / total * 100
        per_black = cons['black'][i] / total * 100
        per_asian = cons['asian'][i] / total * 100
        per_other = cons['other'][i] / total * 100
        per_two = cons['two.'][i] / total * 100
        
        chance_cat1 = per_white
        chance_cat2 = chance_cat1+per_black
        chance_cat3 = chance_cat2+per_asian
        chance_cat4 = chance_cat3+per_other
        chance_cat5 = chance_cat4+per_two
        
        random.seed((i+1)*(j+1)*12)
        dice_roll = random.random()*100
    
        if dice_roll < chance_cat1:
            race = 'white'
        elif dice_roll < chance_cat2:
            race = 'black'
        elif dice_roll < chance_cat3:
            race = 'asian'
        elif dice_roll < chance_cat4:
            race = 'other'
        else:
            race = 'two.'
        

        ind=['NA', 'NA', age, sex, emp, mob, inc, cit, mar, sch, dis, wrk, ins, race]
        List.append(ind)
    if(len(List)==0):
        df = pd.DataFrame(columns = ['NA','NA','AGE','SEX','EMP','MOB','INC','CIT','MAR','SCH','DIS','WRK','INS','RACE'])
    else:    
        df = pd.DataFrame(List)

        df.columns =['NA','NA','AGE','SEX','EMP','MOB','INC','CIT','MAR','SCH','DIS','WRK','INS','RACE']
        del df['NA']
        df.insert(0, 'REGION', inds['REGION'])
        df.insert(0, 'PUMA', inds['PUMA'])
        df.insert(0, 'SPORDER', inds['SPORDER'])
        df.insert(0, 'DVISION', inds['DVISION'])
        df.insert(0, 'SERIALNO', inds['SERIALNO'])
        columns_titles = ["SERIALNO","DVISION","SPORDER","PUMA","REGION","AGE","SEX","EMP","MOB","INC","CIT","MAR","SCH","DIS","WRK","INS","RACE"]
    #df.to_csv('Unmerged_data/GeneratedPop/Vancouver2/{num}.csv'.format(num=str(i+1)),index=False)
    df.to_csv('../synthetic_data/US/CT/conditional_probability/{num}.csv'.format(num=str(i+1)),index=False)
    