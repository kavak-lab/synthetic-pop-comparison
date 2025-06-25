#following packages are used for iterative proportional fitting (IPF)
suppressPackageStartupMessages(library(ipfp))
suppressPackageStartupMessages(library(plyr))
suppressPackageStartupMessages(library(mipfp))
suppressPackageStartupMessages(library(parallel))


args <- commandArgs(trailingOnly=TRUE)
cons <- read.csv(args[1],stringsAsFactors = FALSE)
inds <- read.csv(args[2],stringsAsFactors = FALSE)

inds = inds[inds['AGE'] != '90_99',]

#categorizes each element and organizes
con_sex <- cons[c(13,14)]
con_age <- cons[c(4:12)]
con_race <- cons[c(15:21)]
con_hisp <- cons[c(22,23)]
consz <- cbind(con_age,con_sex,con_race,con_hisp)

indsz <- inds[c(1,6,7,9,8)]

#formats each category into binaries (0 or 1) depending if they belong to category or not
cat_age <- model.matrix(~ indsz$AGE - 1)
cat_sex <- model.matrix(~ indsz$SEX - 1)[,c(2,1)]
cat_race <- model.matrix(~ indsz$RACE - 1)[,c(7,3,1,2,4,5,6)]
cat_hisp <- model.matrix(~ indsz$HISP - 1)[,c(2,1)]

ind_cat <- cbind(cat_age, cat_sex, cat_race, cat_hisp)
ind_agg <- colSums(ind_cat)

n_zone <- nrow(consz)
n_ind <- nrow(indsz)
n_age <- ncol(con_age)
n_sex <- ncol(con_sex)
n_race <- ncol(con_race)
n_hisp <- ncol(con_hisp)
consz <- apply(consz, 2, as.numeric)

#calculates weights based on IPF algorithm
weights_zone <- list()
zones <- seq(stats::rnorm(n_zone))

for (val in zones){
    if (cons[val,3] != 0)
        weights_zone <- append(weights_zone,list(ipfp(consz[val,], t(ind_cat),x0 = rep(1,n_ind))))
    else
        weights_zone <- append(weights_zone, list(0))
}

#TRS Integerisation function used to round weight values
int_trs <- function(x){ #Integerisation
  xv <- as.vector(x) 
  xint <- floor(xv) 
  r <- xv - xint
  def <- round(sum(r))

  topup <- sample(length(x), size = def, prob = r) #Setting replace to true as we encountered too few positive probabilities for the 471st CBG in the second for loop
  xint[topup] <- xint[topup] + 1
  dim(xint) <- dim(x)
  dimnames(xint) <- dimnames(x)
  xint
}

#set seed to produce same results
set.seed(50)

#converts each of the weights to integers

weight_int <- list()
zones <- seq(stats::rnorm(n_zone))

for (val in zones){
    if (cons[val,3] != 0)
        weight_int <- append(weight_int, list(int_trs(x=unlist(weights_zone[val]))))
    else
        weight_int <- append(weight_int, list(0))
}

#this function is used to make sure there is enough people in a CBG - multiplies certain people to fit
int_expand_vector <- function(x){
  index <- 1:length(x)
  rep(index, round(x))
}
ind_indices <- list()
for (val in zones){
    if (cons[val,3] != 0)
        ind_indices <- append(ind_indices,list(int_expand_vector(unlist(weight_int[val]))))
    else
        ind_indices <- append(ind_indices, list(0))
}

#saving values to csv file
ind_zone <- list()
for (val in zones){
    ind_zone <- append(ind_zone, list(inds[unlist(ind_indices[val]),])) #inds or indsz
}

names(ind_zone) <- c(1:length(ind_zone))

invisible(capture.output(lapply(1:length(ind_zone), function(i) write.csv(ind_zone[[i]], 
                                      file = paste0("../synthetic_data/US/CBG/ipf/",paste0(names(ind_zone[i]), ".csv")),
                                      row.names = FALSE))))