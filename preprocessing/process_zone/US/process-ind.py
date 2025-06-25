import pandas as pd
import numpy as np
ind_raw = pd.read_csv("../census_data/Raw/US/IND/psam_p51.csv")

sub_ind = ind_raw[["SERIALNO", "DIVISION", "SPORDER","PUMA","REGION", 
                    "AGEP","SEX","HISP","RACAIAN","RACASN","RACBLK","RACNH","RACPI","RACNUM","RACSOR","RACWHT","PWGTP1"]]
col_names = ["SERIALNO", "DVISION", "SPORDER","PUMA","REGION", 
                    "AGE","SEX","HISP","RACE","PWGTP1"]
ind = pd.DataFrame([], columns=col_names)

def setAge(num):
    if num < 10: 
        return "0_9"
    else:
        return str(num//10)+"0_"+str(num//10)+"9"

def setSex(num):
    if num == 1: return "m"
    else: return "f"

def setHisp(num):
    if num == 1: return "not.hisp.latino"
    else: return "hisp.latino"

for index, row in sub_ind.iterrows():
    p_row = [row["SERIALNO"],row["DIVISION"], row["SPORDER"], row["PUMA"], row["REGION"]]
    p_row.append(setAge(int(row["AGEP"])))
    p_row.append(setSex(int(row["SEX"])))
    p_row.append(setHisp(int(row["HISP"])))
    if int(row["RACNUM"]) > 1: p_row.append("two.")
    else:
        if int(row["RACWHT"]) == 1: p_row.append("white")
        elif int(row["RACAIAN"]) == 1: p_row.append("a.ind..nat.ak")
        elif int(row["RACASN"]) == 1: p_row.append("asian")
        elif int(row["RACBLK"]) == 1: p_row.append("black.aa")
        elif int(row["RACNH"]) == 1 or int(row["RACPI"]) == 1: p_row.append("nat.hi.pt.isl")
        else: p_row.append("other")
    p_row.append(row["PWGTP1"])
    
    p_row = pd.DataFrame([p_row], columns=col_names)
    ind = pd.concat([ind, p_row], ignore_index=True)

ind.to_csv("../census_data/Processed/US/CBG/inds_us_cbg.csv", index=False)
del ind['HISP']
ind.to_csv("../census_data/Processed/US/CT/inds_us_ct_sk.csv", index=False)

