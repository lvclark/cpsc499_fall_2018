source("data_reading.R")

#mydata <- read_yield("yield_csvs/N_Japan_yield.csv")

myfiles <- list.files("yield_csvs")
myfiles

mydf <- list()

for(i in 1:length(myfiles)){
  f <- myfiles[i]
  thisdf <- read_yield(paste("yield_csvs", f, sep = "/"))
  if(nrow(thisdf) < 30) next # skip this data frame
  if(!endsWith(f, ".csv")) next
  
  mydf[[i]] <- thisdf
#  print(mean(mydata$Biomass.yield, na.rm = TRUE))
}

for(df in mydf){
  print(mean(df$Biomass.yield, na.rm = TRUE))
}

i <- 1
while(i < 10){
  print(i)
  i <- i - 1
}

for(i in 1:10){
  print(i)
}
