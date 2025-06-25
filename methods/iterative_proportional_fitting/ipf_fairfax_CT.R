suppressPackageStartupMessages(library(ipfp))
suppressPackageStartupMessages(library(plyr))
suppressPackageStartupMessages(library(mipfp))
suppressPackageStartupMessages(library(parallel))


args <- commandArgs(trailingOnly=TRUE)
cons <- read.csv(args[1],stringsAsFactors = FALSE)
inds <- read.csv(args[2],stringsAsFactors = FALSE)

#cons = read.csv("../../census_data/Processed/US/CT/cons_us_ct.csv")
#inds = read.csv("../../census_data/Processed/US/CT/inds_us_ct.csv")

con_sex <- cons[c(13:14)]
con_age <- cons[c(4:12)]
con_emp <- cons[c(15:18)]
con_mob <- cons[c(19:21)]
con_inc <- cons[c(22:29)]
con_cit <- cons[c(30:34)]
con_mar <- cons[c(35:39)]
con_sch <- cons[c(40:42)]
con_dis <- cons[c(43:44)]
con_wrk <- cons[c(45:52)]
con_ins <- cons[c(53:54)]
con_race <- cons[c(55:59)]

consz <- cbind(con_age,con_sex,con_emp,con_mob,con_inc,con_cit,con_mar,con_sch,con_dis,con_wrk,con_ins,con_race)
indsz <- inds[c(6:17)]

cat_age <- model.matrix(~ indsz$AGE - 1)
cat_sex <- model.matrix(~ indsz$SEX - 1)
cat_emp <- model.matrix(~ indsz$EMP - 1)
cat_mob <- model.matrix(~ indsz$MOB - 1)
cat_inc <- model.matrix(~ indsz$INC - 1)
cat_cit <- model.matrix(~ indsz$CIT - 1)
cat_mar <- model.matrix(~ indsz$MAR - 1)
cat_sch <- model.matrix(~ indsz$SCH - 1)
cat_dis <- model.matrix(~ indsz$DIS - 1)
cat_wrk <- model.matrix(~ indsz$WRK - 1)
cat_ins <- model.matrix(~ indsz$INS - 1)
cat_race <- model.matrix(~ indsz$RACE - 1)

ind_cat <- cbind(cat_age, cat_sex, cat_emp, cat_mob, cat_inc, cat_cit, cat_mar, cat_sch, cat_dis, cat_wrk, cat_ins, cat_race)

ind_agg <- colSums(ind_cat)

n_zone <- nrow(consz)
n_ind <- nrow(indsz)

consz <- apply(consz, 2, as.numeric)

weights_zone <- list()
zones <- seq(stats::rnorm(n_zone))

ipf_generation <- function(val){
  if (is.na(cons[val,3])){
    weights_zone <- append(weights_zone, list(0))
  }
  else if(cons[val,3]!=0){
    weights_zone <- append(weights_zone,list(ipfp(consz[val,], t(ind_cat),x0 = rep(1,n_ind))))
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
clusterExport(NULL, c('ipf_generation', 'cons', 'weights_zone', 'consz', 'ind_cat', 'n_ind'))
clusterEvalQ(NULL, library(ipfp))
weights_zone<-parLapply(NULL, zones, function (zones) ipf_generation(zones))
stopCluster(cl)
###############################################################################################

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


set.seed(50)
weight_int <- list()

integerize<- function(val){
  if (is.na(cons[val,3])){
    weight_int <- append(weight_int, list(0))
  }
  else if (cons[val,3] != 0)
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
clusterExport(NULL, c('integerize', 'int_trs', 'cons', 'weight_int', 'weights_zone'))
weight_int<-parLapply(NULL, zones, function (zones) integerize(zones))
stopCluster(cl)
###############################################################################################

int_expand_vector <- function(x){
  index <- 1:length(x)
  rep(index, round(x)) #No need to round x here as all of the elements of weight_int has already been converted to an integer
}


ind_indices <- list()
expand<- function(val){
  if (is.na(cons[val,3])){
    ind_indices <- append(ind_indices, list(0))
  }
  else if (cons[val,3] != 0)
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
clusterExport(NULL, c('expand', 'int_expand_vector', 'cons', 'ind_indices', 'weight_int'))
ind_indices<-parLapply(NULL, zones, function (zones) expand(zones))
stopCluster(cl)
###############################################################################################

ind_zone <- list()

for (val in zones){
  ind_zone <- append(ind_zone, list(inds[unlist(ind_indices[val]),]))
}

names(ind_zone) <- c(1:length(ind_zone))
invisible(capture.output(lapply(1:length(ind_zone), function(i) write.csv(ind_zone[[i]], 
                                                 file = paste0("../synthetic_data/US/CT/ipf/",paste0(i, ".csv")), row.names = FALSE))))
