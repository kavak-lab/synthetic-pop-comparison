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

cons = cons.loc[:,'population':'oo'].astype('int64')

num_ct = len(cons)


for i in range(0,num_ct):
    population_num = cons['population'][i]
    List = []
    for j in range (0, population_num):
        sex = 'default'
        age_group = 'default'
        ethnic_origin = 'default'
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
        
        total = cons['a0_4'][i] + cons['a5_9'][i] + cons['a10_14'][i] + cons['a15_19'][i] + cons['a20_24'][i] + cons['a25_29'][i] + cons['a30_34'][i] +cons['a35_39'][i] +cons['a40_44'][i] +cons['a45_49'][i] +cons['a50_54'][i] + cons['a55_59'][i] +cons['a60_64'][i] +cons['a65_69'][i] +cons['a70_74'][i] +cons['a75_79'][i] +cons['a80_84'][i] + cons['a85_'][i]
        if (total==0):
            print(i)
            print("age")
        
        per_a0_4 = cons['a0_4'][i] / total * 100;
        per_a5_9 = cons['a5_9'][i] / total * 100;
        per_a10_14 = cons['a10_14'][i] / total * 100;
        per_a15_19 = cons['a15_19'][i] / total * 100;
        per_a20_24 = cons['a20_24'][i] / total * 100;
        per_a25_29 = cons['a25_29'][i] / total * 100;
        per_a30_34 = cons['a30_34'][i] / total * 100;
        per_a35_39 = cons['a35_39'][i] / total * 100;
        per_a40_44 = cons['a40_44'][i] / total * 100;
        per_a45_49 = cons['a45_49'][i] / total * 100;
        per_a50_54 = cons['a50_54'][i] / total * 100;
        per_a55_59 = cons['a55_59'][i] / total * 100;
        per_a60_64 = cons['a60_64'][i] / total * 100;
        per_a65_69 = cons['a65_69'][i] / total * 100;
        per_a70_74 = cons['a70_74'][i] / total * 100;
        per_a75_79 = cons['a75_79'][i] / total * 100;
        per_a80_84 = cons['a80_84'][i] / total * 100;
        per_a85_ = cons['a85_'][i] / total * 100;
    
        chance_cat1 = per_a0_4;
        chance_cat2 = chance_cat1 + per_a5_9;
        chance_cat3 = chance_cat2 + per_a10_14;
        chance_cat4 = chance_cat3 + per_a15_19;
        chance_cat5 = chance_cat4 + per_a20_24;
        chance_cat6 = chance_cat5 + per_a25_29;
        chance_cat7 = chance_cat6 + per_a30_34;
        chance_cat8 = chance_cat7 + per_a35_39;
        chance_cat9 = chance_cat8 + per_a40_44;
        chance_cat10 = chance_cat9 + per_a45_49;
        chance_cat11 = chance_cat10 + per_a50_54;
        chance_cat12 = chance_cat11 + per_a55_59;
        chance_cat13 = chance_cat12 + per_a60_64;
        chance_cat14 = chance_cat13 + per_a65_69;
        chance_cat15 = chance_cat14 + per_a70_74;
        chance_cat16 = chance_cat15 + per_a75_79;
        chance_cat17 = chance_cat16 + per_a80_84;
        
        random.seed((i+1)*(j+1)*2)
        dice_roll = random.random()*100
        
        if (dice_roll < chance_cat1):
            age_group = 'a0_4'
        if (dice_roll >= chance_cat1 and dice_roll <= chance_cat2):
            age_group = 'a5_9'
        if (dice_roll > chance_cat2 and dice_roll <= chance_cat3):
            age_group = 'a10_14'
        if (dice_roll > chance_cat3 and dice_roll <= chance_cat4):
            age_group = 'a15_19'
        if (dice_roll > chance_cat4 and dice_roll <= chance_cat5):
            age_group = 'a20_24'
        if (dice_roll > chance_cat5 and dice_roll <= chance_cat6):
            age_group = 'a25_29'
        if (dice_roll > chance_cat6 and dice_roll <= chance_cat7):
            age_group = 'a30_34'
        if (dice_roll > chance_cat7 and dice_roll <= chance_cat8):
            age_group = 'a35_39'
        if (dice_roll > chance_cat8 and dice_roll <= chance_cat9):
            age_group = 'a40_44'
        if (dice_roll > chance_cat9 and dice_roll <= chance_cat10):
            age_group = 'a45_49'
        if (dice_roll > chance_cat10 and dice_roll <= chance_cat11):
            age_group = 'a50_54'
        if (dice_roll > chance_cat11 and dice_roll <= chance_cat12):
            age_group = 'a55_59'
        if (dice_roll > chance_cat12 and dice_roll <= chance_cat13):
            age_group = 'a60_64'
        if (dice_roll > chance_cat13 and dice_roll <= chance_cat14):
            age_group = 'a65_69'
        if (dice_roll > chance_cat14 and dice_roll <= chance_cat15):
            age_group = 'a70_74'
        if (dice_roll > chance_cat15 and dice_roll <= chance_cat16):
            age_group = 'a75_79'
        if (dice_roll > chance_cat16 and dice_roll <= chance_cat17):
            age_group = 'a80_84'
        if (dice_roll > chance_cat17):
            age_group = 'a85_'
        
        
        
        total = cons['naao'][i] + cons['onao_Canadian'][i]+ cons['onao'][i] + cons['eo_bio_English'][i] + cons['eo_bio_Irish'][i] + cons['eo_bio_Scottish'][i] + cons['eo_obio'][i] + cons['eo_fo'][i] +cons['eo_weo_Dutch'][i] + cons['eo_weo_German'][i] + cons['eo_oweo'][i] + cons['eo_neo'][i] + cons['eo_eeo_Hungarian'][i] + cons['eo_eeo_Polish'][i] + cons['eo_eeo_Russian'][i] + cons['eo_eeo_Ukrainian'][i] +cons['eo_oeeo'][i] + cons['eo_seo_Greek'][i] + cons['eo_seo_Italian'][i] + cons['eo_seo_Portuguese'][i] + cons['eo_seo_Spanish'][i] + cons['eo_oseo'][i] + cons['eo_oeo'][i] + cons['co_Jamaican'][i] + cons['oco'][i] + cons['lcsao'][i] + cons['ao'][i] + cons['ao_wcameo'][i] + cons['ao_sao_ei'][i] + cons['ao_osao'][i] + cons['ao_esao_Chinese'][i] + cons['ao_esao_Filipino'][i] + cons['ao_oesao'][i] + cons['oo'][i]
        if (total == 0):
            print(i)
            print("eth")                                      

        
        per_naao = cons['naao'][i] / total * 100;
        per_onao_Canad = cons['onao_Canadian'][i] / total * 100;
        per_onao = cons['onao'][i] / total * 100;
        per_eo_bio_Eng = cons['eo_bio_English'][i] / total * 100;
        per_eo_bio_Iri = cons['eo_bio_Irish'][i] / total * 100;
        per_eo_bio_Sco = cons['eo_bio_Scottish'][i] / total * 100;
        per_eo_obio = cons['eo_obio'][i] / total * 100;
        per_eo_fo = cons['eo_fo'][i] / total * 100;
        per_eo_weo_Dut = cons['eo_weo_Dutch'][i] / total * 100;
        per_eo_weo_Ger = cons['eo_weo_German'][i] / total * 100;
        per_eo_oweo = cons['eo_oweo'][i] / total * 100;
        per_eo_neo = cons['eo_neo'][i] / total * 100;
        per_eo_eeo_Hun = cons['eo_eeo_Hungarian'][i] / total * 100;
        per_eo_eeo_Pol = cons['eo_eeo_Polish'][i] / total * 100;
        per_eo_eeo_Rus = cons['eo_eeo_Russian'][i] / total * 100;
        per_eo_eeo_Ukr = cons['eo_eeo_Ukrainian'][i] / total * 100;
        per_eo_oeeo = cons['eo_oeeo'][i] / total * 100;
        per_eo_seo_Gre = cons['eo_seo_Greek'][i] / total * 100;
        per_eo_seo_Ita = cons['eo_seo_Italian'][i] / total * 100;
        per_eo_seo_Por = cons['eo_seo_Portuguese'][i] / total * 100;
        per_eo_seo_Spa = cons['eo_seo_Spanish'][i] / total * 100;
        per_eo_oseo = cons['eo_oseo'][i] / total * 100;
        per_eo_oeo = cons['eo_oeo'][i] / total * 100;
        per_co_Jamaica = cons['co_Jamaican'][i] / total * 100;
        per_oco = cons['oco'][i] / total * 100;
        per_lcsao = cons['lcsao'][i] / total * 100;
        per_ao = cons['ao'][i] / total * 100;
        per_ao_wcameo = cons['ao_wcameo'][i] / total * 100;
        per_ao_sao_ei = cons['ao_sao_ei'][i] / total * 100;
        per_ao_osao = cons['ao_osao'][i] / total * 100;
        per_ao_esao_Ch = cons['ao_esao_Chinese'][i] / total * 100;
        per_ao_esao_Fi = cons['ao_esao_Filipino'][i] / total * 100;
        per_ao_oesao = cons['ao_oesao'][i] / total * 100;
        per_oo = cons['oo'][i] / total * 100;

        chance_cat1 = per_naao;
        chance_cat2 = chance_cat1 + per_onao_Canad;
        chance_cat3 = chance_cat2 + per_onao;
        chance_cat4 = chance_cat3 + per_eo_bio_Eng;
        chance_cat5 = chance_cat4 + per_eo_bio_Iri;
        chance_cat6 = chance_cat5 + per_eo_bio_Sco;
        chance_cat7 = chance_cat6 + per_eo_obio;
        chance_cat8 = chance_cat7 + per_eo_fo;
        chance_cat9 = chance_cat8 + per_eo_weo_Dut;
        chance_cat10 = chance_cat9 + per_eo_weo_Ger;
        chance_cat11 = chance_cat10 + per_eo_oweo;
        chance_cat12 = chance_cat11 + per_eo_neo;
        chance_cat13 = chance_cat12 + per_eo_eeo_Hun;
        chance_cat14 = chance_cat13 + per_eo_eeo_Pol;
        chance_cat15 = chance_cat14 + per_eo_eeo_Rus;
        chance_cat16 = chance_cat15 + per_eo_eeo_Ukr;
        chance_cat17 = chance_cat16 + per_eo_oeeo;
        chance_cat18 = chance_cat17 + per_eo_seo_Gre;
        chance_cat19 = chance_cat18 + per_eo_seo_Ita;
        chance_cat20 = chance_cat19 + per_eo_seo_Por;
        chance_cat21 = chance_cat20 + per_eo_seo_Spa;
        chance_cat22 = chance_cat21 + per_eo_oseo;
        chance_cat23 = chance_cat22 + per_eo_oeo;
        chance_cat24 = chance_cat23 + per_co_Jamaica;
        chance_cat25 = chance_cat24 + per_oco;
        chance_cat26 = chance_cat25 + per_lcsao;
        chance_cat27 = chance_cat26 + per_ao;
        chance_cat28 = chance_cat27 + per_ao_wcameo;
        chance_cat29 = chance_cat28 + per_ao_sao_ei;
        chance_cat30 = chance_cat29 + per_ao_osao;
        chance_cat31 = chance_cat30 + per_ao_esao_Ch;
        chance_cat32 = chance_cat31 + per_ao_esao_Fi;
        chance_cat33 = chance_cat32 + per_ao_oesao;
        
        random.seed((i+1)*(j+1)*3)
        dice_roll = random.random()*100
    
        if (dice_roll < chance_cat1):
            ethnic_origin = 'naao'
        if (dice_roll >= chance_cat1 and dice_roll <= chance_cat2):
            ethnic_origin = 'onao_Canadian'
        if (dice_roll > chance_cat2 and dice_roll <= chance_cat3):
            ethnic_origin = 'onao'
        if (dice_roll > chance_cat3 and dice_roll <= chance_cat4):
            ethnic_origin = 'eo_bio_English'
        if (dice_roll > chance_cat4 and dice_roll <= chance_cat5):
            ethnic_origin = 'eo_bio_Irish'
        if (dice_roll > chance_cat5 and dice_roll <= chance_cat6):
            ethnic_origin = 'eo_bio_Scottish'
        if (dice_roll > chance_cat6 and dice_roll <= chance_cat7):
            ethnic_origin = 'eo_obio'
        if (dice_roll > chance_cat7 and dice_roll <= chance_cat8):
            ethnic_origin = 'eo_fo'
        if (dice_roll > chance_cat8 and dice_roll <= chance_cat9):
            ethnic_origin = 'eo_weo_Dutch'
        if (dice_roll > chance_cat9 and dice_roll <= chance_cat10):
            ethnic_origin = 'eo_weo_German'
        if (dice_roll > chance_cat10 and dice_roll <= chance_cat11):
            ethnic_origin = 'eo_oweo'
        if (dice_roll > chance_cat11 and dice_roll <= chance_cat12):
            ethnic_origin = 'eo_neo'
        if (dice_roll > chance_cat12 and dice_roll <= chance_cat13):
            ethnic_origin = 'eo_eeo_Hungarian'
        if (dice_roll > chance_cat13 and dice_roll <= chance_cat14):
            ethnic_origin = 'eo_eeo_Polish'
        if (dice_roll > chance_cat14 and dice_roll <= chance_cat15):
            ethnic_origin = 'eo_eeo_Russian'
        if (dice_roll > chance_cat15 and dice_roll <= chance_cat16):
            ethnic_origin = 'eo_eeo_Ukrainian'
        if (dice_roll > chance_cat16 and dice_roll <= chance_cat17):
            ethnic_origin = 'eo_oeeo'
        if (dice_roll > chance_cat17 and dice_roll <= chance_cat18):
            ethnic_origin = 'eo_seo_Greek'
        if (dice_roll > chance_cat18 and dice_roll <= chance_cat19):
            ethnic_origin = 'eo_seo_Italian'
        if (dice_roll > chance_cat19 and dice_roll <= chance_cat20):
            ethnic_origin = 'eo_seo_Portuguese'
        if (dice_roll > chance_cat20 and dice_roll <= chance_cat21):
            ethnic_origin = 'eo_seo_Spanish'
        if (dice_roll > chance_cat21 and dice_roll <= chance_cat22):
            ethnic_origin = 'eo_oseo'
        if (dice_roll > chance_cat22 and dice_roll <= chance_cat23):
            ethnic_origin = 'eo_oeo'
        if (dice_roll > chance_cat23 and dice_roll <= chance_cat24):
            ethnic_origin = 'co_Jamaican'
        if (dice_roll > chance_cat24 and dice_roll <= chance_cat25):
            ethnic_origin = 'oco'
        if (dice_roll > chance_cat25 and dice_roll <= chance_cat26):
            ethnic_origin = 'lcsao'
        if (dice_roll > chance_cat26 and dice_roll <= chance_cat27):
            ethnic_origin = 'ao'
        if (dice_roll > chance_cat27 and dice_roll <= chance_cat28):
            ethnic_origin = 'ao_wcameo'
        if (dice_roll > chance_cat28 and dice_roll <= chance_cat29):
            ethnic_origin = 'ao_sao_ei'
        if (dice_roll > chance_cat29 and dice_roll <= chance_cat30):
            ethnic_origin = 'ao_osao'
        if (dice_roll > chance_cat30 and dice_roll <= chance_cat31):
            ethnic_origin = 'ao_esao_Chinese'
        if (dice_roll > chance_cat31 and dice_roll <= chance_cat32):
            ethnic_origin = 'ao_esao_Filipino'
        if (dice_roll > chance_cat32 and dice_roll <= chance_cat33):
            ethnic_origin = 'ao_oesao'
        if (dice_roll > chance_cat33):
            ethnic_origin = 'oo'
        
        '''
        total = cons['official_lang'][i] + cons['no.official_lang'][i]
        if (total==0):
            print(i)
            print("off")
        
        per_O_L = cons['official_lang'][i] / total * 100
        per_nO_L = cons['no.official_lang'][i] / total * 100
        
        random.seed((i+1)*(j+1)*4)
        dice_roll = random.random()*100
        
        if (dice_roll<=per_nO_L):
            official_lang = 'no.official_lang'
        if (dice_roll>per_nO_L):
            official_lang = 'official_lang'
            
        total = cons['work.official_lang'][i] + cons['work.no.official_lang'][i]
        if (total==0):
            print(i)
            print("work")
        
        per_W_O_L = cons['work.official_lang'][i] / total * 100
        per_W_nO_L = cons['work.no.official_lang'][i] / total * 100
        
        random.seed((i+1)*(j+1)*5)
        dice_roll = random.random()*100
        
        if (dice_roll<=per_W_nO_L):
            work_official_lang = 'work.no.official_lang'
        if (dice_roll>per_W_nO_L):
            work_official_lang = 'work.official_lang'
        '''
        #ind=['NA', 933, sex, age_group, ethnic_origin, official_lang, work_official_lang]
        ind=['NA', 933, sex, age_group, ethnic_origin]
        List.append(ind)
        
    df = pd.DataFrame(List)
    #df.columns =['PPSORT', 'CMA', 'AGE', 'SEX', 'RACE', 'OFFICIAL_LANGUAGE', 'WORK_OFFICIAL_LANGUAGE']
    df.columns =['PPSORT', 'CMA', 'AGE', 'SEX', 'RACE']
    df['PPSORT'] = inds['PPSORT']
    #df.to_csv('Unmerged_data/GeneratedPop/Vancouver2/{num}.csv'.format(num=str(i+1)),index=False)
    df.to_csv('../synthetic_data/Canada/CT/conditional_probability/{num}.csv'.format(num=str(i+1)),index=False)
    #print(df)