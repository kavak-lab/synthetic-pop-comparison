import pandas as pd
import numpy as np
import time
from collections import Counter
import multiprocessing
import sys, os

cons = pd.read_csv(sys.argv[1])
indsz = pd.read_csv(sys.argv[2])

cons = cons.loc[:,'population':'oo'].astype('int64')
inds = indsz



# calculates total absolute difference between each of the variables measured
# returns a tuple containing the difference values between current and actual population, and the absolute tottal
def goodness_fit(sol, sample, constraints):
    df = sample.loc[sol, :]
    dc = Counter(df[['AGE', 'SEX', 'RACE']].values.flatten())

    # print(dc)

    synth_block_group = [len(df), dc['a0_4'], dc['a5_9'],
                         dc['a10_14'], dc['a15_19'], dc['a20_24'], dc['a25_29'], dc['a30_34'], dc['a35_39'],
                         dc['a40_44'], dc['a45_49'], dc['a50_54'], dc['a55_59'], dc['a60_64'], dc['a65_69'],
                         dc['a70_74'], dc['a75_79'], dc['a80_84'], dc['a85_'], dc['f'], dc['m'], dc['naao'],
                         dc['onao_Canadian'], dc['onao'], dc['eo_bio_English'], dc['eo_bio_Irish'],
                         dc['eo_bio_Scottish'],
                         dc['eo_obio'], dc['eo_fo'], dc['eo_weo_Dutch'], dc['eo_weo_German'], dc['eo_oweo'],
                         dc['eo_neo'], dc['eo_eeo_Hungarian'], dc['eo_eeo_Polish'], dc['eo_eeo_Russian'],
                         dc['eo_eeo_Ukrainian'],
                         dc['eo_oeeo'], dc['eo_seo_Greek'], dc['eo_seo_Italian'], dc['eo_seo_Portuguese'],
                         dc['eo_seo_Spanish'],
                         dc['eo_oseo'], dc['eo_oeo'], dc['co_Jamaican'], dc['oco'], dc['lcsao'],
                         dc['ao'], dc['ao_wcameo'], dc['ao_sao_ei'], dc['ao_osao'], dc['ao_esao_Chinese'],
                         dc['ao_esao_Filipino'], dc['ao_oesao'], dc['oo']]
    # 'naao', 'onao_Canadian', 'onao', 'eo_bio_English', 'eo_bio_Irish', 'eo_bio_Scottish', 'eo_obio', 'eo_fo', 'eo_weo_Dutch',
    # 'eo_weo_German', 'eo_oweo', 'eo_neo', 'eo_eeo_Hungarian', 'eo_eeo_Polish', 'eo_eeo_Russian', 'eo_eeo_Ukrainian','eo_oeeo',
    # 'eo_seo_Greek','eo_seo_Italian','eo_seo_Portuguese','eo_seo_Spanish','eo_oseo','eo_oeo','co_Jamaican','oco','lcsao','ao',
    # 'ao_wcameo','ao_sao_ei','ao_osao','ao_esao_Chinese','ao_esao_Filipino','ao_oesao','oo'
    # added to troubleshoot

    synth_agg = pd.DataFrame([synth_block_group], columns=constraints.columns)

    diff = constraints.values.flatten() - synth_agg.values.flatten()
    diff = pd.DataFrame([diff], columns=constraints.columns)
    return (diff.abs().values.sum(), diff)


#returns list of sum and also goodness of fit differences
def compare_fit(prev_agg, new_ind, prev_ind,constraints):
    prev_agg[prev_ind['AGE']]+=1
    prev_agg[new_ind['AGE']]-=1
    prev_agg[prev_ind['RACE']]+=1
    prev_agg[new_ind['RACE']]-=1
    prev_agg[prev_ind['SEX']]+=1
    prev_agg[new_ind['SEX']]-=1


    return [prev_agg.abs().values.sum(),prev_agg]


# HILL CLIMBING
def hill_climbing(i, minute_limit):
    population_num = cons['population'][i]

    # initialize step counts
    t_0 = 1
    step = 0.001
    orig_solution = np.random.choice(sample_num, population_num)

    # calculates initial goodness of fit
    tempCons = cons.loc[[i], 'population':'oo']  # added to resolve the error
    fit0 = goodness_fit(orig_solution, inds, tempCons)
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
    #print("DA running: ", i+1)
    #sys.stdout.flush()
    ans = hill_climbing(i, 6)
    ans.to_csv('../synthetic_data/Canada/DA/hill_climbing/{num}.csv'.format(num=str(i + 1)), index=False)
    #print("DA complete:", i+1)
    #sys.stdout.flush()

num_cbg = len(cons)
sample_num = len(inds)

if __name__ == '__main__':
    a_pool = multiprocessing.Pool(os.cpu_count())
    #print("Processes", a_pool._processes)
    result = a_pool.map(generate_population, range(num_cbg))