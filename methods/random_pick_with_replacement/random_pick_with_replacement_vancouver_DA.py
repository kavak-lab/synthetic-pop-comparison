import pandas as pd
import numpy as np
import scipy.constants as sp
import time
from collections import Counter
from pandas import DataFrame
import sys

cons = pd.read_csv(sys.argv[1])
indsz = pd.read_csv(sys.argv[2])

cons = cons.loc[:,'population':'oo'].astype('int64')
inds = indsz

#RANDOM PICK WITH REPLACEMENT

num_cbg = len(cons)
sample_num = len(inds)

np.random.seed(60)
seeds = np.random.choice(num_cbg,num_cbg)

for i in range(0,num_cbg):
    population_num = cons['population'][i]
    np.random.seed(seeds[i])
    orig_solution = np.random.choice(sample_num,population_num)
    ans = inds.loc[orig_solution,:]
    ans.to_csv('../synthetic_data/Canada/DA/random_pick_with_replacement/{num}.csv'.format(num=str(i+1)),index=False)
    #print(str(i+1)+"/"+str(num_cbg)+" completed")
