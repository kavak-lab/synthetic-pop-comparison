import pandas as pd
import numpy as np
import time
from collections import Counter
import multiprocessing
import sys, os


cons = pd.read_csv(sys.argv[1]) #Fairfax County
indsz = pd.read_csv(sys.argv[2]) #Sample from PUMS

inds_i = []
pumas = [59301, 59302, 59303, 59304, 59305, 59306, 59307, 59308, 59309]  # only pums in fairfax county

# locates individuals only in fairfax county
for i in range(len(indsz)):
    if indsz['PUMA'][i] in pumas and indsz['AGE'][i] != '90_99':  # indsz['PUMA'][i] in pumas and
        inds_i.append(i)

inds = indsz.loc[inds_i, :]
inds.index = range(0, len(inds))

cons = cons.loc[:, 'geo_id':'hisp.latino']
cons = cons.loc[:,'population':'hisp.latino'].astype('int64')



# calculates total absolute difference between each of the variables measured
# returns a tuple containing the difference values between current and actual population, and the absolute tottal
def goodness_fit(sol, sample, constraints):
    '''
    sol - indices of sample population
    sample - sample population pums
    constraint data for cbg
    '''
    df = sample.loc[sol, :]
    dc = Counter(df[['HISP','RACE','SEX']].values.flatten())

    synth_block_group = [len(df), dc['0_9'], dc['10_19'], dc['20_29'], dc['30_39'], dc['40_49'],
                         dc['50_59'], dc['60_69'], dc['70_79'], dc['80_89'], dc['m'], dc['f'], dc['white'],
                         dc['black.aa'], dc['a.ind..nat.ak'], dc['asian'], dc['nat.hi.pt.isl'], dc['other'],
                         dc['two.'], dc['not.hisp.latino'], dc['hisp.latino'] ]

    synth_agg = pd.DataFrame([synth_block_group], columns=constraints.columns)

    diff = constraints.values.flatten() - synth_agg.values.flatten()
    diff = pd.DataFrame([diff], columns=constraints.columns)
    return (diff.abs().values.sum(), diff)


#returns list of sum and also goodness of fit differences
def compare_fit(prev_agg, new_ind, prev_ind,constraints):
    prev_agg[prev_ind['RACE']]+=1
    prev_agg[new_ind['RACE']]-=1
    prev_agg[prev_ind['SEX']]+=1
    prev_agg[new_ind['SEX']]-=1
    prev_agg[prev_ind['HISP']] += 1
    prev_agg[new_ind['HISP']] -= 1


    return [prev_agg.abs().values.sum(),prev_agg]


# HILL CLIMBING
def hill_climbing(i, minute_limit):
    population_num = cons['population'][i]

    # initialize step counts
    t_0 = 1
    step = 0.001
    orig_solution = np.random.choice(sample_num, population_num)

    # calculates initial goodness of fit
    fit0 = goodness_fit(orig_solution, inds, cons.loc[[i]])
    fit = fit0[0]
    cur_time = time.time()
    counter = 0

    # loop to improve goodness of fit
    while t_0 >= 0 and fit0[0] > 0:
        # choosing random person in sample
        random_ind_sol = np.random.randint(0, population_num - 1, size=1)
        random_ind_samp = np.random.randint(0, sample_num - 1, size=1)

        saved_agg = fit0[1].copy()

        # calculate new fit
        fit0 = compare_fit(fit0[1], inds.loc[random_ind_samp[0]], inds.loc[orig_solution[random_ind_sol[0]]],
                           cons.loc[[i]])
        new_fit = fit0[0]

        # if the new fit is better than old
        if fit > new_fit:
            orig_solution[random_ind_sol[0]] = random_ind_samp[0]
            t_0 -= step
            fit = new_fit
            counter = 0
        else:
            fit0[1] = saved_agg
            counter += 1

        if time.time() - cur_time > 60*minute_limit:
            t_0 = -1
    ans = inds.loc[orig_solution, :]
    return ans

def generate_population(i):
    #print("CBG running: ", i+1)
    #sys.stdout.flush()
    ans = hill_climbing(i, 6)
    ans.to_csv('../synthetic_data/US/CBG/hill_climbing/{num}.csv'.format(num=str(i + 1)), index=False)
    #print("CBG complete:", i+1)
    #sys.stdout.flush()

num_cbg = len(cons)
sample_num = len(inds)

if __name__ == '__main__':
    a_pool = multiprocessing.Pool(os.cpu_count())
    #print("Processes", a_pool._processes)
    result = a_pool.map(generate_population, range(num_cbg))