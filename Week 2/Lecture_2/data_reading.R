source("stemVol.R")

#myfile <- "yield_csvs/N_Japan_yield.csv"
#myfile <- "yield_csvs/Ornamental_yield.csv"
#myfile <- "yield_csvs/Yangtze_Qinling_yield.csv"
#myfile <- "yield_csvs/Sichuan_yield.csv"

read_yield <- function(myfile){
  # import data
  mydata <- read.csv(myfile)
  
  if(!all(c("Latitude", "Longitude") %in% names(mydata))){
    if(all(c("Lat", "Long") %in% names(mydata))){
      names(mydata)[names(mydata) == "Lat"] <- "Latitude"
      names(mydata)[names(mydata) == "Long"] <- "Longitude"
      print("Lat and Long changed to Latitude and Longitude")
    } else {
      mydata$Latitude <- rep(NA, nrow(mydata))
      mydata$Longitude <- rep(NA, nrow(mydata))
      print("Latitude and Longitude columns added with missing data.")
    }
  } else {
    print("Latitude and Longitude found in file.")
  }
  
  # convert from kg to g if necessary
  if(!is.null(mydata$Biomass.yield) && # make sure we have a yield column
     median(mydata$Biomass.yield, na.rm = TRUE) < 10){
    mydata$Biomass.yield <- mydata$Biomass.yield * 1000
    print("Yield converted from kg to g")
  }
  
  # print message if plant height or num. stems is missing
  if(is.null(mydata$Plant.height) || is.null(mydata$Number.of.stems)){
    print("Plant.height and Number.of.stems needed")
  }
  
  # add a stem volume column
  mydata$Stem.volume <- stemVol(mydata$Plant.height,
                                mydata$Stem.diameter)
  
  return(mydata)
}

# code for testing - what if column doesn't exist
#if(median(mydata$blah, na.rm = TRUE) < 10){
#  "test"
#}
#is.null(mydata$blah)
