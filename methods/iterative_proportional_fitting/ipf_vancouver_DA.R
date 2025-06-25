suppressPackageStartupMessages(library(ipfp))
suppressPackageStartupMessages(library(plyr))
suppressPackageStartupMessages(library(mipfp))
suppressPackageStartupMessages(library(parallel))

#Readling Merged Constrain and Individual Data
args <- commandArgs(trailingOnly=TRUE)
consMerged <- read.csv(args[1],stringsAsFactors = FALSE)
indsMerged <- read.csv(args[2],stringsAsFactors = FALSE)

consMerged_ages <- consMerged[c(3:20)]
consMerged_sex <- consMerged[c(21,22)]
consMerged_race <- consMerged[c(23:56)]

consMerged_filtered = cbind(consMerged_ages, consMerged_sex, consMerged_race)
indsMerged_filtered = indsMerged[c(1,3,4,5)]

cat_age_indsMerged_filtered <- model.matrix(~ indsMerged_filtered$AGE - 1)[,c(1,10,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18)]
cat_sex_indsMerged_filtered <- model.matrix(~ indsMerged_filtered$SEX - 1)[,c(1,2)]
cat_race_indsMerged_filtered <- model.matrix(~ indsMerged_filtered$RACE - 1)[,c(30,33,32,9,10,11,18,16,27,28,22,17,12,13,14,15,19,23,24,25,26,21,20,8,31,29,1,7,6,5,2,3,4,34)]

cat_indsMerged_filtered <- cbind(cat_age_indsMerged_filtered, cat_sex_indsMerged_filtered, cat_race_indsMerged_filtered)

colnames(cat_indsMerged_filtered) = colnames(consMerged_filtered)

agg_cat_indsMerged_filtered <- colSums(cat_indsMerged_filtered)

n_zone <- nrow(consMerged_filtered) #Number of zones
n_ind <- nrow(indsMerged_filtered) #Number of individuals
n_age <- ncol(consMerged_ages) #Number of attributes in the variable age
n_sex <- ncol(consMerged_sex) #Number of attributes in the variable sex
n_race <- ncol(consMerged_race) #Number of attributes in the variable race

consMerged_filtered <- apply(consMerged_filtered, 2, as.numeric)

weights_zone <- list()
#A vector of n_zone numbers starting from 1 to n_zone. Will loop over this and iteratively compute weight matrices and generate populations for each of these
zones <- seq(stats::rnorm(n_zone)) 


############
ipf_generation <- function(val){
  if (is.na(consMerged[val,2])){
    weights_zone <- append(weights_zone, list(0))
  }
  else if(consMerged[val,2]!=0){
    weights_zone <- append(weights_zone,list(ipfp(consMerged_filtered[val,], t(cat_indsMerged_filtered),x0 = rep(1,n_ind))))
  }else{
    weights_zone <- append(weights_zone, list(0))
  }
}
cores <- detectCores()
#weights_zone<-mclapply(zones, ipf_generation, mc.cores=cores)
# This block of code is designed to replace the mclapply function's purpose as mclapply is not available on Windows.
# If we run this code on a Mac or Linux machine, we can simply use the above one-liner code. However, if this needs to
# be executed on a Windows machine, comment out the line above and enable this block of code.
###############################################################################################
cl <- makePSOCKcluster(cores)
setDefaultCluster(cl)
clusterExport(NULL, c('ipf_generation', 'consMerged', 'weights_zone', 'consMerged_filtered', 'cat_indsMerged_filtered', 'n_ind'))
clusterEvalQ(NULL, library(ipfp))
weights_zone<-parLapply(NULL, zones, function (zones) ipf_generation(zones))
stopCluster(cl)
###############################################################################################



#TRS Integerisation function used to round weight values
#It ensures that no weight value gets decreased than it's integer part
int_trs <- function(x){ #Integerisation
  xv <- as.vector(x) 
  xint <- floor(xv) 
  r <- xv - xint
  def <- round(sum(r))
  topup <- sample(length(x), size = def, prob = r)
  xint[topup] <- xint[topup] + 1
  dim(xint) <- dim(x)
  dimnames(xint) <- dimnames(x)
  xint
}

#set seed to produce same results
set.seed(50) #As long as the very remains same in different iterations, output will also be same

#converts each of the weights to integers

weight_int <- list()
#zones <- seq(stats::rnorm(n_zone))
zones <- seq(stats::rnorm(n_zone)) 
#zones <- c(1:3) #Currently, selecting only the first 15 zone. Later, this line will be removed and the line above will be reinstated


integerize<- function(val){
  if (is.na(consMerged[val,2])){
    weight_int <- append(weight_int, list(0))
  }
  else if (consMerged[val,2] != 0)
    weight_int <- append(weight_int, list(int_trs(x=unlist(weights_zone[val]))))
  else
    weight_int <- append(weight_int, list(0))
}

#weight_int<-mclapply(zones, integerize, mc.cores=cores)
# This block of code is designed to replace the mclapply function's purpose as mclapply is not available on Windows.
# If we run this code on a Mac or Linux machine, we can simply use the above one-liner code. However, if this needs to
# be executed on a Windows machine, comment out the line above and enable this block of code.
###############################################################################################
cl <- makePSOCKcluster(cores)
setDefaultCluster(cl)
clusterExport(NULL, c('integerize', 'int_trs', 'consMerged', 'weight_int', 'weights_zone'))
weight_int<-parLapply(NULL, zones, function (zones) integerize(zones))
stopCluster(cl)
###############################################################################################


int_expand_vector <- function(x){
  index <- 1:length(x)
  rep(index, round(x)) #No need to round x here as all of the elements of weight_int has already been converted to an integer
}

ind_indices <- list()

expand<- function(val){
  if (is.na(consMerged[val,2])){
    ind_indices <- append(ind_indices, list(0))
  }
  else if (consMerged[val,2] != 0)
    ind_indices <- append(ind_indices,list(int_expand_vector(unlist(weight_int[val]))))
  else
    ind_indices <- append(ind_indices, list(0))
}

#ind_indices<-mclapply(zones,expand,mc.cores=cores)
# This block of code is designed to replace the mclapply function's purpose as mclapply is not available on Windows.
# If we run this code on a Mac or Linux machine, we can simply use the above one-liner code. However, if this needs to
# be executed on a Windows machine, comment out the line above and enable this block of code.
###############################################################################################
cl <- makePSOCKcluster(cores)
setDefaultCluster(cl)
clusterExport(NULL, c('expand', 'int_expand_vector', 'consMerged', 'ind_indices', 'weight_int'))
ind_indices<-parLapply(NULL, zones, function (zones) expand(zones))
stopCluster(cl)
###############################################################################################


ind_zone <- list()

temp = NULL

for (val in zones){
  
  #print("appending")
  #print(val)
  
  ind_zone <- append(ind_zone, list(indsMerged[unlist(ind_indices[val]),]))
  if(val == 2)
    temp = ind_zone
}

names(ind_zone) <- c(1:length(ind_zone))

lapply(1:length(ind_zone), function(i) write.csv(ind_zone[[i]], 
                                                 file = paste0("../synthetic_data/Canada/DA/ipf/",paste0(i, ".csv")), row.names = FALSE))
