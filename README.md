# Quantitative Comparison of Population Synthesis Techniques

## Description

This project provides the codebase for "Quantitiative Comparision of Population Synthesis Techniques". We offer this as an outline for reproducing our data and results present in the paper.

## Citation

Han, D., Islam, S., Anderson, T., Crooks, A., & Kavak, H. (2025). **Quantitative Comparison of Population Synthesis Techniques**. In *Proceedings of the Winter Simulation Conference 2025*.


## Installation/Packages

- Python (3.8.6) (pandas, numpy, scipy, multiprocessing, seaborn, matplotlib)
- R (4.2.0) (ipfp, plyr, mipfp, parallel)

```pip3 install -r requirements.txt```
```R packages must be installed manually```

## Usage

### Scripts

Scripts for running processes are contained inside the `scripts/` folder. Run scripts within the folder for correct paths.

1. `process_raw.sh`: Processes the raw data inside of `census_data/Raw/` and converts into `cons_{}.csv` and `inds_{}.csv` files inside of `census_data/Processed/`.

2. `run_methods.sh`: Runs all five methods (Random Pick With Replacement, Iterative Proportional Fitting, Hill Climbing, Simmulated Annealing, and Conditional Probability) on five different regions: US (census block group, census tract); Canada (dissemination area, census tract, dissemination area (extra features)). 

3. `zone_aggegation.sh`: Converts the individual files into aggregated files that can be used to run results and comparisons.

## Folder Information

### Data

- Fairfax County, VA, USA: 5-year American Community Survey (ACS) data that provides detailed population attributes from [here](https://www.census.gov/data.html).
- Public Use Microdata Sample [(PUMS)](https://www.census.gov/programs-surveys/acs/microdata.html) for indvidual data
- Metro Vancouver, BC, Canada: Obtained from [Statistics Canada](https://www.statcan.gc.ca/en/start).

Files that are downloaded can be placed in the `census_data` folder. For US, data is located in `census_data/Raw/US` and for Canada in `census_data/Raw/Canada`.

### Preprocessing

1. `process_zone/`: Contains methods to convert raw data inside `census_data/Raw/` into constraint files. The constraint files are placed inside `census_data/Processed/`.

2. `processed/`: Folder used for intermediate files while processing raw data.

3. `zone_to_aggregate`: Files used to convert individual files into aggregate files.

### Methods

We focus on using five methods: Random Pick With Replacement, Iterative Proportional Fitting, Hill Climbing, Simmulated Annealing, and Conditional Probability. Each method takes in a `cons_{}.csv` inside `census_data/Processed/` to produce a set of synthetic individuals based on the chosen methods.


Individual data that are produced are located within `synthetic_data/{country}/{geo_area}/{method}/`.

Individual data can be converted into aggregate data (into a separate `cons_{}.csv`) with files located in `preprocessing/zone_to_aggregate/`.

### Results Generation

- Errors and percentages
- Joint probabilities
- R^2 values

These metrics can be calculated inside `results_generation` using `cons_{}.csv` and aggregate data csv files produced from synthetic individuals.

## Contributors

**Project Team:** [David Han](https://david-han.dev/), [Samiul Islam](https://github.com/sami141215), [Taylor Anderson](https://science.gmu.edu/directory/taylor-anderson), [Andrew Crooks](https://www.gisagents.org/), and [Hamdi Kavak](https://github.com/hamdikavak).

