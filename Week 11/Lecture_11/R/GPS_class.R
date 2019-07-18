# setting up the GPS class

# constructor function
GPS <- function(latitude, longitude, datum){
  # check that data are formatted correctly
  if(any(latitude < -90 | latitude > 90)){
    stop("Latitude must be between -90 and 90.")
  }
  if(any(longitude < -180 | longitude > 180)){
    stop("Longitude must be between -180 and 180.")
  }
  # set up object
  object <- data.frame(Latitude = latitude,
                       Longitude = longitude)
  # add attributes
  attr(object, "datum") <- datum
  # assign class
  class(object) <- c("GPS", class(object))
  
  return(object)
}

# set up a plot method
plot.GPS <- function(object, ...){
  plot(object$Longitude,
       object$Latitude,
       xlab = "Longitude",
       ylab = "Latitude",
       ...)
}


print.GPS <- function(object, ...){
  cat(paste("Datum:", attr(object, "datum")),
      sep = "\n")
  NextMethod("print", object) # call method for data frame
}


# mini-exercise: summary method
summary.GPS <- function(object, ...){
  cat(paste("Latitude range from", 
            min(object$Latitude, na.rm = TRUE),
            "to",
            max(object$Latitude, na.rm = TRUE)),
      paste("Longitude range from", 
            min(object$Longitude, na.rm = TRUE),
            "to",
            max(object$Longitude, na.rm = TRUE)),
      sep = "\n")
}


# new generic function
hemisphere <- function(object, ...){
  UseMethod("hemisphere", object)
}
hemisphere.GPS <- function(object, ...){
  out <- character(nrow(object)) # set up output vector
  out[object$Latitude > 0 & object$Longitude > 0] <- "NE"
  out[object$Latitude > 0 & object$Longitude <= 0] <- "NW"
  out[object$Latitude <= 0 & object$Longitude > 0] <- "SE"
  out[object$Latitude <= 0 & object$Longitude <= 0] <- "SW"
  
  return(out)
}


# accessor function
GetLatitude <- function(object, ...){
  UseMethod("GetLatitude", object)
}
GetLatitude.GPS <- function(object, ...){
  return(object$Latitude)
}


SetLatitude <- function(object, value, ...){
  UseMethod("SetLatitude", object)
}
SetLatitude.GPS <- function(object, value, ...){
  # check that data are formatted correctly
  if(any(value < -90 | value > 90)){
    stop("Latitude must be between -90 and 90.")
  }
  
  object$Latitude <- value
  
  return(object)
}


# mini-exercise: GetDatum accessor
GetDatum <- function(object, ...){
  UseMethod("GetDatum", object)
}
GetDatum.GPS <- function(object, ...){
  return(attr(object, "datum"))
}


## inheritance

## making a subclass
GPS_elev <- function(latitude, longitude, datum, elevation){
  object <- GPS(latitude, longitude, datum)
  object$Elevation <- elevation
  class(object) <- c("GPS_elev", class(object))
  
  return(object)
}


