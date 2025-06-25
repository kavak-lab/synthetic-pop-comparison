from codecs import ignore_errors
import pandas as pd
import warnings
warnings.filterwarnings('ignore')

cur_cons = pd.read_csv("../census_data/Processed/US/CT/cons_us_ct_sk2.csv")
sk_cons = pd.read_csv("../census_data/Processed/US/CT/cons_us_ct_sk.csv")

new_cons = pd.DataFrame()
for i in range(len(sk_cons)):
    popl = sk_cons.iloc[i,10]+sk_cons.iloc[i,11]
    sk_row = sk_cons.iloc[i,:]
    for j in range(len(cur_cons)):
        if cur_cons.iloc[j, 2] == popl: 
            cur_row = cur_cons.iloc[j,:3]
            cur_row = pd.concat([cur_row, sk_row[1:]])
            new_cons = new_cons.append(cur_row, ignore_index=True)
            break

new_cons.columns = ['geo_id', 'block_group_name', 'population', '0_9', '10_19', '20_29', '30_39', '40_49', '50_59', '60_69', '70_79', '80_89', 'f', 'm', 'armed.forces', 'civilian.employed', 'not.in.labor.force', 'unemployed', 'abroad.house', 'diff.us.house', 'same.house', 'i.0.9999', 'i.10000.14999', 'i.15000.24999', 'i.25000.34999', 'i.35000.49999', 'i.50000.64999', 'i.65000.74999', 'i.75000.99999', 'abroad.born', 'naturalization', 'not.citizen', 'puerto.rico.born', 'us.born', 'divorced', 'married', 'never', 'separated', 'widowed', 'no.schooling', 'private', 'public', 'with.disability', 'without.disability', 'federal', 'local', 'not.working', 'private.no.profit', 'private.profit', 'self.employed.corp', 'self.employed.no.corp', 'state', 'with.insurance', 'without.insurance', 'asian', 'black', 'other', 'two.', 'white']
new_cons.to_csv("../census_data/Processed/US/CT/cons_us_ct.csv", index=False)
