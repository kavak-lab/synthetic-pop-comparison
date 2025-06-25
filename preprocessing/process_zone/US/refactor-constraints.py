import pandas as pd
import numpy as np
import sys

cons2 = pd.read_csv(sys.argv[1])
label = sys.argv[2]
label2 = sys.argv[3]

r0 = []
r1 = []
r2 = []
r3 = []
r4 = []
r5 = []
r6 = []
r7 = []
r8 = []
for index, row in cons2.iterrows():
    r0.append(row['m0_9']+row['f0_9'])
    r1.append(row['m10_19']+row['f10_19'])
    r2.append(row['m20_29']+row['f20_29'])
    r3.append(row['m30_39']+row['f30_39'])
    r4.append(row['m40_49']+row['f40_49'])
    r5.append(row['m50_59']+row['f50_59'])
    r6.append(row['m60_69']+row['f60_69'])
    r7.append(row['m70_79']+row['f70_79'])
    r8.append(row['m80_89']+row['f80_89'])

cons2 = cons2.drop(['m0_9','m10_19','m20_29','m30_39','m40_49','m50_59','m60_69','m70_79','m80_89'], axis = 1) 
cons2 = cons2.drop(['f0_9','f10_19','f20_29','f30_39','f40_49','f50_59','f60_69','f70_79','f80_89'], axis = 1)

r0 = pd.Series(r0)
r1 = pd.Series(r1)
r2 = pd.Series(r2)
r3 = pd.Series(r3)
r4 = pd.Series(r4)
r5 = pd.Series(r5)
r6 = pd.Series(r6)
r7 = pd.Series(r7)
r8 = pd.Series(r8)

cons2.insert(loc=3, column='80_89', value = r8)
cons2.insert(loc=3, column='70_79', value = r7)
cons2.insert(loc=3, column='60_69', value = r6)
cons2.insert(loc=3, column='50_59', value = r5)
cons2.insert(loc=3, column='40_49', value = r4)
cons2.insert(loc=3, column='30_39', value = r3)
cons2.insert(loc=3, column='20_29', value = r2)
cons2.insert(loc=3, column='10_19', value = r1)
cons2.insert(loc=3, column='0_9', value = r0)

cons2.to_csv("../census_data/Processed/US/{}/cons_{}.csv".format(label2,label),index=False)