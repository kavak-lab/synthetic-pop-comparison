options(warn=-1)
raw_age_sex <- read.csv(paste0("../census_data/Raw/Canada/CT/age_and_sex/OmPdyFR6LnDF_data.csv"),stringsAsFactors = FALSE)

geo_id = raw_age_sex[,'COL0']
population = raw_age_sex[,'COL1']
a0_4 = raw_age_sex[,'COL3']
a5_9 = raw_age_sex[,'COL4']
a10_14 = raw_age_sex[,'COL5']
a15_19 = raw_age_sex[,'COL7']
a20_24 = raw_age_sex[,'COL8']
a25_29 = raw_age_sex[,'COL9']
a30_34 = raw_age_sex[,'COL10']
a35_39 = raw_age_sex[,'COL11']
a40_44 = raw_age_sex[,'COL12']
a45_49 = raw_age_sex[,'COL13']
a50_54 = raw_age_sex[,'COL14']
a55_59 = raw_age_sex[,'COL15']
a60_64 = raw_age_sex[,'COL16']
a65_69 = raw_age_sex[,'COL18']
a70_74 = raw_age_sex[,'COL19']
a75_79 = raw_age_sex[,'COL20']
a80_84 = raw_age_sex[,'COL21']
a85_89 = raw_age_sex[,'COL23']
a90_94 = raw_age_sex[,'COL24']
a95_99 = raw_age_sex[,'COL25']
a100_ = raw_age_sex[,'COL26']
a85_ = a100_+a95_99+a90_94+a85_89
m = raw_age_sex[,'COL33']
f = raw_age_sex[,'COL65']

cons = cbind(geo_id, population, a0_4, a5_9, a10_14, a15_19, a20_24, a25_29, a30_34, a35_39, a40_44, a45_49, a50_54, a55_59, a60_64, a65_69, a70_74, a75_79, a80_84, a85_, m, f)

geo_areas = length(cons[,1]) # Number of total geo areas
cons = cons[2:geo_areas,] # Starting from 2 since the first row
                   # is the sum of all records.

raw_ethnic_origin <- read.csv(paste0("../census_data/Raw/Canada/CT/ethnic_origin/RrQJ1volu4xaVxp_data.csv"),stringsAsFactors = FALSE)

geo_areas = length(raw_ethnic_origin[,1]) # Number of total geo areas
raw_ethnic_origin = raw_ethnic_origin[2:geo_areas,] # Starting from 2 since the first row
                   # is the sum of all records.

naao = raw_ethnic_origin[,'COL2'] #North American Aboriginal origins
onao_Canadian = raw_ethnic_origin[,'COL9'] #Other North American origins / Canadian
onao = raw_ethnic_origin[,'COL6']-raw_ethnic_origin[,'COL9'] #Other North American origins
eo_bio_English = raw_ethnic_origin[,'COL20'] #European origins / British Isles origins / English
eo_bio_Irish = raw_ethnic_origin[,'COL21'] #European origins / British Isles origins / Irish
eo_bio_Scottish = raw_ethnic_origin[,'COL23'] #European origins / British Isles origins / Scottish
eo_obio = raw_ethnic_origin[,'COL17'] - eo_bio_English - eo_bio_Irish - eo_bio_Scottish #Other British Isles origins
eo_fo = raw_ethnic_origin[,'COL26'] #European origins / French origins
eo_weo_Dutch = raw_ethnic_origin[,'COL35']
eo_weo_German = raw_ethnic_origin[,'COL38']
eo_oweo = raw_ethnic_origin[,'COL31'] - eo_weo_Dutch - eo_weo_German
eo_neo = raw_ethnic_origin[,'COL42']
eo_eeo_Hungarian = raw_ethnic_origin[,'COL55']
eo_eeo_Polish = raw_ethnic_origin[,'COL59']
eo_eeo_Russian = raw_ethnic_origin[,'COL61']
eo_eeo_Ukrainian = raw_ethnic_origin[,'COL63']
eo_oeeo = raw_ethnic_origin[,'COL49'] - eo_eeo_Hungarian - eo_eeo_Polish - eo_eeo_Russian - eo_eeo_Ukrainian
eo_seo_Greek = raw_ethnic_origin[,'COL71']
eo_seo_Italian = raw_ethnic_origin[,'COL72']
eo_seo_Portuguese = raw_ethnic_origin[,'COL77']
eo_seo_Spanish = raw_ethnic_origin[,'COL81']
eo_oseo = raw_ethnic_origin[,'COL65'] - eo_seo_Greek - eo_seo_Italian - eo_seo_Portuguese - eo_seo_Spanish
eo_oeo = raw_ethnic_origin[,'COL84']
co_Jamaican = raw_ethnic_origin[,'COL101']
oco = raw_ethnic_origin[,'COL90'] - co_Jamaican
lcsao = raw_ethnic_origin[,'COL111']
ao = raw_ethnic_origin[,'COL136']
ao_wcameo = raw_ethnic_origin[,'COL205']
ao_sao_ei = raw_ethnic_origin[,'COL238']
ao_osao = raw_ethnic_origin[,'COL234'] - ao_sao_ei
ao_esao_Chinese = raw_ethnic_origin[,'COL252']
ao_esao_Filipino = raw_ethnic_origin[,'COL253']
ao_oesao = raw_ethnic_origin[,'COL249'] - ao_esao_Chinese - ao_esao_Filipino
oo = raw_ethnic_origin[,'COL270']

C16Sum = raw_ethnic_origin[,'COL17']+raw_ethnic_origin[,'COL26']+raw_ethnic_origin[,'COL31']+raw_ethnic_origin[,'COL42']+raw_ethnic_origin[,'COL49']+raw_ethnic_origin[,'COL65']+raw_ethnic_origin[,'COL84']
C17 = round(raw_ethnic_origin[,'COL17']/C16Sum*raw_ethnic_origin[,'COL16'])
counter = 1
while(counter<=length(C17)){
    if(is.na(C17[counter])){
        C17[counter] = 0
    }
    counter = counter + 1
}
eo_fo = round(raw_ethnic_origin[,'COL26']/C16Sum*raw_ethnic_origin[,'COL16'])
counter = 1
while(counter<=length(eo_fo)){
    if(is.na(eo_fo[counter])){
        eo_fo[counter] = 0
    }
    counter = counter + 1
}

#Correcting using percentage while assuming that the total pop in each subgroup is correct

#Col2 is okay at this point
naao = raw_ethnic_origin[,'COL2'] #North American Aboriginal origins


# Col9 needs to be cleaned
C6Sum = raw_ethnic_origin[,'COL7']+raw_ethnic_origin[,'COL8']+raw_ethnic_origin[,'COL9']+raw_ethnic_origin[,'COL10']+raw_ethnic_origin[,'COL11']+raw_ethnic_origin[,'COL12']+raw_ethnic_origin[,'COL13']+raw_ethnic_origin[,'COL14']+raw_ethnic_origin[,'COL15']
onao_Canadian = round(raw_ethnic_origin[,'COL9']/C6Sum*raw_ethnic_origin[,'COL6']) #Other North American origins / Canadian
counter = 1
while(counter<=length(onao_Canadian)){
    if(is.na(onao_Canadian[counter])){
        onao_Canadian[counter] = 0
    }
    counter = counter + 1
}
onao = raw_ethnic_origin[,'COL6']-onao_Canadian #Other North American origins
counter = 1
while(counter<=length(onao)){
    if(is.na(onao[counter])){
        onao[counter] = 0
    }
    counter = counter + 1
}
# Col9 cleaning is DONE

# Fix C17, C26, C31, C42, C49, C65, C84
# These columns need to be cleaned
C16Sum = raw_ethnic_origin[,'COL17']+raw_ethnic_origin[,'COL26']+raw_ethnic_origin[,'COL31']+raw_ethnic_origin[,'COL42']+raw_ethnic_origin[,'COL49']+raw_ethnic_origin[,'COL65']+raw_ethnic_origin[,'COL84']
C17 = round(raw_ethnic_origin[,'COL17']/C16Sum*raw_ethnic_origin[,'COL16'])
counter = 1
while(counter<=length(C17)){
    if(is.na(C17[counter])){
        C17[counter] = 0
    }
    counter = counter + 1
}
eo_fo = round(raw_ethnic_origin[,'COL26']/C16Sum*raw_ethnic_origin[,'COL16'])
counter = 1
while(counter<=length(eo_fo)){
    if(is.na(eo_fo[counter])){
        eo_fo[counter] = 0
    }
    counter = counter + 1
}
C31 = round(raw_ethnic_origin[,'COL31']/C16Sum*raw_ethnic_origin[,'COL16'])
counter = 1
while(counter<=length(C31)){
    if(is.na(C31[counter])){
        C31[counter] = 0
    }
    counter = counter + 1
}
eo_neo = round(raw_ethnic_origin[,'COL42']/C16Sum*raw_ethnic_origin[,'COL16'])
counter = 1
while(counter<=length(eo_neo)){
    if(is.na(eo_neo[counter])){
        eo_neo[counter] = 0
    }
    counter = counter + 1
}
C49 = round(raw_ethnic_origin[,'COL49']/C16Sum*raw_ethnic_origin[,'COL16'])
counter = 1
while(counter<=length(C49)){
    if(is.na(C49[counter])){
        C49[counter] = 0
    }
    counter = counter + 1
}
C65 = round(raw_ethnic_origin[,'COL65']/C16Sum*raw_ethnic_origin[,'COL16'])
counter = 1
while(counter<=length(C65)){
    if(is.na(C65[counter])){
        C65[counter] = 0
    }
    counter = counter + 1
}
eo_oeo = raw_ethnic_origin[,'COL16'] - C17 - eo_fo - C31 - eo_neo - C49 - C65
counter = 1
while(counter<=length(eo_oeo)){
    if(is.na(eo_oeo[counter])){
        eo_oeo[counter] = 0
    }
    counter = counter + 1
}
# C17, C26, C31, C42, C49, C65, C84 cleaning is DONE



# C20, C21, C23 needs to be cleaned
C17Sum = raw_ethnic_origin[,'COL18']+raw_ethnic_origin[,'COL19']+raw_ethnic_origin[,'COL20']+raw_ethnic_origin[,'COL21']+raw_ethnic_origin[,'COL22']+raw_ethnic_origin[,'COL23']+raw_ethnic_origin[,'COL24']+raw_ethnic_origin[,'COL25']
eo_bio_English = round(raw_ethnic_origin[,'COL20']/C17Sum*C17)
counter = 1
while(counter<=length(eo_bio_English)){
    if(is.na(eo_bio_English[counter])){
        eo_bio_English[counter] = 0
    }
    counter = counter + 1
}
eo_bio_Irish = round(raw_ethnic_origin[,'COL21']/C17Sum*C17)
counter = 1
while(counter<=length(eo_bio_Irish)){
    if(is.na(eo_bio_Irish[counter])){
        eo_bio_Irish[counter] = 0
    }
    counter = counter + 1
}
eo_bio_Scottish = round(raw_ethnic_origin[,'COL23']/C17Sum*C17)
counter = 1
while(counter<=length(eo_bio_Scottish)){
    if(is.na(eo_bio_Scottish[counter])){
        eo_bio_Scottish[counter] = 0
    }
    counter = counter + 1
}
eo_obio = C17 - eo_bio_English - eo_bio_Irish - eo_bio_Scottish
counter = 1
while(counter<=length(eo_obio)){
    if(is.na(eo_obio[counter])){
        eo_obio[counter] = 0
    }
    counter = counter + 1
}
# C20, C21, C23 cleaning is DONE


# Already Cleaned above
eo_fo = eo_fo #European origins / French origins



# C35, C38 needs to be cleaned
C31Sum = raw_ethnic_origin[,'COL32']+raw_ethnic_origin[,'COL33']+raw_ethnic_origin[,'COL34']+raw_ethnic_origin[,'COL35']+raw_ethnic_origin[,'COL36']+raw_ethnic_origin[,'COL37']+raw_ethnic_origin[,'COL38']+raw_ethnic_origin[,'COL39']+raw_ethnic_origin[,'COL40']+raw_ethnic_origin[,'COL41']
eo_weo_Dutch = round(raw_ethnic_origin[,'COL35']/C31Sum*C31)
counter = 1
while(counter<=length(eo_weo_Dutch)){
    if(is.na(eo_weo_Dutch[counter])){
        eo_weo_Dutch[counter] = 0
    }
    counter = counter + 1
}
eo_weo_German = round(raw_ethnic_origin[,'COL38']/C31Sum*C31)
counter = 1
while(counter<=length(eo_weo_German)){
    if(is.na(eo_weo_German[counter])){
        eo_weo_German[counter] = 0
    }
    counter = counter + 1
}
eo_oweo = C31 - eo_weo_Dutch - eo_weo_German
counter = 1
while(counter<=length(eo_oweo)){
    if(is.na(eo_oweo[counter])){
        eo_oweo[counter] = 0
    }
    counter = counter + 1
}
# C35, C38 cleaning is DONE



# Already Cleaned above
eo_neo = eo_neo



# C55, C59, C61, C63 needs to be cleaned
C49Sum = raw_ethnic_origin[,'COL50']+raw_ethnic_origin[,'COL51']+raw_ethnic_origin[,'COL52']+raw_ethnic_origin[,'COL53']+raw_ethnic_origin[,'COL54']+raw_ethnic_origin[,'COL55']+raw_ethnic_origin[,'COL56']+raw_ethnic_origin[,'COL57']+raw_ethnic_origin[,'COL58']+raw_ethnic_origin[,'COL59']+raw_ethnic_origin[,'COL60']+raw_ethnic_origin[,'COL61']+raw_ethnic_origin[,'COL62']+raw_ethnic_origin[,'COL63']+raw_ethnic_origin[,'COL64']
eo_eeo_Hungarian = round(raw_ethnic_origin[,'COL55']/C49Sum*C49)
counter = 1
while(counter<=length(eo_eeo_Hungarian)){
    if(is.na(eo_eeo_Hungarian[counter])){
        eo_eeo_Hungarian[counter] = 0
    }
    counter = counter + 1
}
eo_eeo_Polish = round(raw_ethnic_origin[,'COL59']/C49Sum*C49)
counter = 1
while(counter<=length(eo_eeo_Polish)){
    if(is.na(eo_eeo_Polish[counter])){
        eo_eeo_Polish[counter] = 0
    }
    counter = counter + 1
}
eo_eeo_Russian = round(raw_ethnic_origin[,'COL61']/C49Sum*C49)
counter = 1
while(counter<=length(eo_eeo_Russian)){
    if(is.na(eo_eeo_Russian[counter])){
        eo_eeo_Russian[counter] = 0
    }
    counter = counter + 1
}
eo_eeo_Ukrainian = round(raw_ethnic_origin[,'COL63']/C49Sum*C49)
counter = 1
while(counter<=length(eo_eeo_Ukrainian)){
    if(is.na(eo_eeo_Ukrainian[counter])){
        eo_eeo_Ukrainian[counter] = 0
    }
    counter = counter + 1
}
eo_oeeo = C49 - eo_eeo_Hungarian - eo_eeo_Polish - eo_eeo_Russian - eo_eeo_Ukrainian
counter = 1
while(counter<=length(eo_oeeo)){
    if(is.na(eo_oeeo[counter])){
        eo_oeeo[counter] = 0
    }
    counter = counter + 1
}
# C55, C59, C61, C63 cleaning is DONE




# C71, C72, C77, C81 needs to be cleaned
C65Sum = raw_ethnic_origin[,'COL66']+raw_ethnic_origin[,'COL67']+raw_ethnic_origin[,'COL68']+raw_ethnic_origin[,'COL69']+raw_ethnic_origin[,'COL70']+raw_ethnic_origin[,'COL71']+raw_ethnic_origin[,'COL72']+raw_ethnic_origin[,'COL73']+raw_ethnic_origin[,'COL74']+raw_ethnic_origin[,'COL75']+raw_ethnic_origin[,'COL76']+raw_ethnic_origin[,'COL77']+raw_ethnic_origin[,'COL78']+raw_ethnic_origin[,'COL79']+raw_ethnic_origin[,'COL80']+raw_ethnic_origin[,'COL81']+raw_ethnic_origin[,'COL82']+raw_ethnic_origin[,'COL83']
eo_seo_Greek = round(raw_ethnic_origin[,'COL71']/C65Sum*C65)
counter = 1
while(counter<=length(eo_seo_Greek)){
    if(is.na(eo_seo_Greek[counter])){
        eo_seo_Greek[counter] = 0
    }
    counter = counter + 1
}
eo_seo_Italian = round(raw_ethnic_origin[,'COL72']/C65Sum*C65)
counter = 1
while(counter<=length(eo_seo_Italian)){
    if(is.na(eo_seo_Italian[counter])){
        eo_seo_Italian[counter] = 0
    }
    counter = counter + 1
}
eo_seo_Portuguese = round(raw_ethnic_origin[,'COL77']/C65Sum*C65)
counter = 1
while(counter<=length(eo_seo_Portuguese)){
    if(is.na(eo_seo_Portuguese[counter])){
        eo_seo_Portuguese[counter] = 0
    }
    counter = counter + 1
}
eo_seo_Spanish = round(raw_ethnic_origin[,'COL81']/C65Sum*C65)
counter = 1
while(counter<=length(eo_seo_Spanish)){
    if(is.na(eo_seo_Spanish[counter])){
        eo_seo_Spanish[counter] = 0
    }
    counter = counter + 1
}
eo_oseo = C65 - eo_seo_Greek - eo_seo_Italian - eo_seo_Portuguese - eo_seo_Spanish
counter = 1
while(counter<=length(eo_oseo)){
    if(is.na(eo_oseo[counter])){
        eo_oseo[counter] = 0
    }
    counter = counter + 1
}
# C71, C72, C77, C81 cleaning is done



# Already Cleaned above
eo_oeo = eo_oeo



# C101 needs to be cleaned
C90Sum = raw_ethnic_origin[,'COL91']+raw_ethnic_origin[,'COL92']+raw_ethnic_origin[,'COL93']+raw_ethnic_origin[,'COL94']+raw_ethnic_origin[,'COL95']+raw_ethnic_origin[,'COL96']+raw_ethnic_origin[,'COL97']+raw_ethnic_origin[,'COL98']+raw_ethnic_origin[,'COL99']++raw_ethnic_origin[,'COL100']+raw_ethnic_origin[,'COL101']+raw_ethnic_origin[,'COL102']+raw_ethnic_origin[,'COL103']+raw_ethnic_origin[,'COL104']+raw_ethnic_origin[,'COL105']+raw_ethnic_origin[,'COL106']+raw_ethnic_origin[,'COL107']+raw_ethnic_origin[,'COL108']+raw_ethnic_origin[,'COL109']+raw_ethnic_origin[,'COL110']
co_Jamaican = round(raw_ethnic_origin[,'COL101']/C90Sum*raw_ethnic_origin[,'COL90'])
counter = 1
while(counter<=length(co_Jamaican)){
    if(is.na(co_Jamaican[counter])){
        co_Jamaican[counter] = 0
    }
    counter = counter + 1
}
oco = raw_ethnic_origin[,'COL90'] - co_Jamaican
counter = 1
while(counter<=length(oco)){
    if(is.na(oco[counter])){
        oco[counter] = 0
    }
    counter = counter + 1
}
# Col101 cleaning is DONE



#Col111 is okay at this point
lcsao = raw_ethnic_origin[,'COL111']


#Col136 is okay at this point
ao = raw_ethnic_origin[,'COL136']


#Fix C205, C234, C249
# These columns need to be cleaned
C204Sum = raw_ethnic_origin[,'COL205']+raw_ethnic_origin[,'COL234']+raw_ethnic_origin[,'COL249']+raw_ethnic_origin[,'COL268']
ao_wcameo = round(raw_ethnic_origin[,'COL205']/C204Sum*raw_ethnic_origin[,'COL204'])
counter = 1
while(counter<=length(ao_wcameo)){
    if(is.na(ao_wcameo[counter])){
        ao_wcameo[counter] = 0
    }
    counter = counter + 1
}
C234 = round(raw_ethnic_origin[,'COL234']/C204Sum*raw_ethnic_origin[,'COL204'])
counter = 1
while(counter<=length(C234)){
    if(is.na(C234[counter])){
        C234[counter] = 0
    }
    counter = counter + 1
}
C249 = round(raw_ethnic_origin[,'COL249']/C204Sum*raw_ethnic_origin[,'COL204'])
counter = 1
while(counter<=length(C249)){
    if(is.na(C249[counter])){
        C249[counter] = 0
    }
    counter = counter + 1
}
# C205, C234, C249 cleaning is DONE


# Already Cleaned above
ao_wcameo = ao_wcameo



# C238 needs to be cleaned
C234Sum = raw_ethnic_origin[,'COL235']+raw_ethnic_origin[,'COL236']+raw_ethnic_origin[,'COL237']+raw_ethnic_origin[,'COL238']+raw_ethnic_origin[,'COL239']+raw_ethnic_origin[,'COL240']+raw_ethnic_origin[,'COL241']+raw_ethnic_origin[,'COL242']+raw_ethnic_origin[,'COL243']+raw_ethnic_origin[,'COL244']+raw_ethnic_origin[,'COL245']+raw_ethnic_origin[,'COL246']+raw_ethnic_origin[,'COL247']+raw_ethnic_origin[,'COL248']
ao_sao_ei = round(raw_ethnic_origin[,'COL238']/C234Sum*C234)
counter = 1
while(counter<=length(ao_sao_ei)){
    if(is.na(ao_sao_ei[counter])){
        ao_sao_ei[counter] = 0
    }
    counter = counter + 1
}
ao_osao = C234 - ao_sao_ei
counter = 1
while(counter<=length(ao_osao)){
    if(is.na(ao_osao[counter])){
        ao_osao[counter] = 0
    }
    counter = counter + 1
}
# C238 cleaning is DONE



# C252, C253 needs to be cleaned
C249Sum = raw_ethnic_origin[,'COL250']+raw_ethnic_origin[,'COL251']+raw_ethnic_origin[,'COL252']+raw_ethnic_origin[,'COL253']+raw_ethnic_origin[,'COL254']+raw_ethnic_origin[,'COL255']+raw_ethnic_origin[,'COL256']+raw_ethnic_origin[,'COL257']+raw_ethnic_origin[,'COL258']+raw_ethnic_origin[,'COL259']+raw_ethnic_origin[,'COL260']+raw_ethnic_origin[,'COL261']+raw_ethnic_origin[,'COL262']+raw_ethnic_origin[,'COL263']+raw_ethnic_origin[,'COL264']+raw_ethnic_origin[,'COL265']+raw_ethnic_origin[,'COL266']+raw_ethnic_origin[,'COL267']
ao_esao_Chinese = round(raw_ethnic_origin[,'COL252']/C249Sum*C249)
counter = 1
while(counter<=length(ao_esao_Chinese)){
    if(is.na(ao_esao_Chinese[counter])){
        ao_esao_Chinese[counter] = 0
    }
    counter = counter + 1
}
ao_esao_Filipino = round(raw_ethnic_origin[,'COL253']/C249Sum*C249)
counter = 1
while(counter<=length(ao_esao_Filipino)){
    if(is.na(ao_esao_Filipino[counter])){
        ao_esao_Filipino[counter] = 0
    }
    counter = counter + 1
}
ao_oesao = C249 - ao_esao_Chinese - ao_esao_Filipino
counter = 1
while(counter<=length(ao_oesao)){
    if(is.na(ao_oesao[counter])){
        ao_oesao[counter] = 0
    }
    counter = counter + 1
}
# C252, C253 cleaning is DONE



#Col270 is okay at this point
oo = raw_ethnic_origin[,'COL270']

cons_formatted = cbind(cons, naao, onao_Canadian, onao, eo_bio_English, eo_bio_Irish, eo_bio_Scottish, eo_obio, eo_fo, eo_weo_Dutch, eo_weo_German, eo_oweo, eo_neo, eo_eeo_Hungarian, eo_eeo_Polish, eo_eeo_Russian, eo_eeo_Ukrainian, eo_oeeo, eo_seo_Greek, eo_seo_Italian, eo_seo_Portuguese, eo_seo_Spanish, eo_oseo, eo_oeo, co_Jamaican, oco, lcsao, ao, ao_wcameo, ao_sao_ei, ao_osao, ao_esao_Chinese, ao_esao_Filipino, ao_oesao, oo)

row = nrow(cons_formatted)
cons_formatted_without_NA = data.frame(matrix(0, ncol = ncol(cons_formatted), nrow = 0))
counter = 1
while(counter<=row){
    selected_row = cons_formatted[counter,]
    if(is.na(selected_row['population']) || is.na(selected_row['naao'])){
        
    }else{
        cons_formatted_without_NA =  rbind(cons_formatted_without_NA, selected_row)
    }
    counter = counter+1
}
names(cons_formatted_without_NA) = names(cons_formatted)

prelabel = list('geo_id', 'population')
age_group = list('a0_4', 'a5_9', 'a10_14', 'a15_19', 'a20_24', 'a25_29', 'a30_34', 'a35_39', 'a40_44', 'a45_49', 'a50_54', 'a55_59', 'a60_64', 'a65_69', 'a70_74', 'a75_79', 'a80_84', 'a85_')
sex = list('f', 'm')
race = list('naao', 'onao_Canadian', 'onao', 'eo_bio_English', 'eo_bio_Irish', 'eo_bio_Scottish', 'eo_obio', 'eo_fo', 'eo_weo_Dutch', 'eo_weo_German', 'eo_oweo', 'eo_neo', 'eo_eeo_Hungarian', 'eo_eeo_Polish', 'eo_eeo_Russian', 'eo_eeo_Ukrainian','eo_oeeo','eo_seo_Greek','eo_seo_Italian','eo_seo_Portuguese','eo_seo_Spanish','eo_oseo','eo_oeo','co_Jamaican','oco','lcsao','ao','ao_wcameo','ao_sao_ei','ao_osao','ao_esao_Chinese','ao_esao_Filipino','ao_oesao','oo')

labels = c(prelabel, age_group, sex, race)

names(cons_formatted_without_NA) = labels

row = nrow(cons_formatted_without_NA)
cons_formatted_without_NA_Perc = data.frame(matrix(0, ncol = ncol(cons_formatted_without_NA), nrow = 0))
counter = 1
while(counter<=row){
    selected_row = cons_formatted_without_NA[counter,]
    
    pop = selected_row['population']
    
    age_groups = length(age_group)
    age_group_counter = 1
    sum_of_age_group = 0
    while(age_group_counter<=age_groups){
        sum_of_age_group = sum_of_age_group + selected_row[age_group[[age_group_counter]]]
        age_group_counter = age_group_counter + 1
    }
    
    age_group_counter = 1
    running_sum = 0;
    while(age_group_counter<=age_groups){
        if(age_group_counter==age_groups){
            selected_row[age_group[[age_group_counter]]] = pop-running_sum
        }else{
            selected_row[age_group[[age_group_counter]]] = round(selected_row[age_group[[age_group_counter]]]/sum_of_age_group*pop)
            running_sum = running_sum + selected_row[age_group[[age_group_counter]]]
        }
        age_group_counter = age_group_counter + 1
    }
    
    sum_of_sex = selected_row['f']+selected_row['m']
    selected_row['f'] = round(selected_row['f']/sum_of_sex*pop)
    selected_row['m'] = pop-selected_row['f']
    
    races = length(race)
    race_counter = 1
    sum_of_race = 0
    while(race_counter<=races){
        sum_of_race = sum_of_race + selected_row[race[[race_counter]]]
        race_counter = race_counter + 1
    }
    
    race_counter = 1
    running_sum = 0
    while(race_counter<=races){
        if(race_counter==races){
            selected_row[race[[race_counter]]] = pop-running_sum
        }else{
            selected_row[race[[race_counter]]] = round(selected_row[race[[race_counter]]]/sum_of_race*pop)
            running_sum = running_sum + selected_row[race[[race_counter]]]
        }
        race_counter = race_counter + 1
    }
    #if(is.na(selected_row['population']) || is.na(selected_row['naao'])){
        
    #}else{
    cons_formatted_without_NA_Perc =  rbind(cons_formatted_without_NA_Perc, selected_row)
    #}
    counter = counter+1
}
names(cons_formatted_without_NA_Perc) = labels

write.csv(cons_formatted_without_NA_Perc, file = "../census_data/Processed/Canada/CT/cons_canada_ct.csv", row.names = FALSE)