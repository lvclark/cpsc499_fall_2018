circle_area <- function(diam){
  return(pi * (diam/2) ^ 2)
}

# estimate stem volume
# len is length of stem
# diam is diameter of stem
# output in cubic cm
stemVol <- function(len, diam,
                    len.units = "cm", diam.units = "mm"){
  if(len.units == "mm"){
    len <- len/10
  }
  if(diam.units == "mm"){
    diam <- diam/10
  }
  if(!len.units %in% c("cm", "mm") ||
     !diam.units %in% c("cm", "mm")){
    stop("Units must be cm or mm")
  }
#  if(any(len/diam < 5)){
#    warning("Strange length to diameter ratio")
#  }
  message("Calculating stem volume...")
  vol <- len * circle_area(diam)
  return(vol)
}

# testing
#stemVol(mydata$Plant.height, mydata$Stem.diameter)
#stemVol(mydata$Plant.height, mydata$Stem.diameter,
#        len.units = "cm")

#stemVol(3, 1, diam.units = "cm")

#conv <- 1.85

# convert miles to km
miles_to_km <- function(distance, nautical = FALSE){
  if(!is.numeric(distance)){
    stop("Something that is not a number was given to distance")
  }
  
 if(nautical){
   out <- distance * 1.85
 } else {
   out <- distance * 1.61
 }
  # out <- distance * conv # don't do this
  return(out)
}

#miles_to_km(20)
#miles_to_km("20")
