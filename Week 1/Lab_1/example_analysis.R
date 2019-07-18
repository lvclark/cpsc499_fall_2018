# import my dataset
mydata <- read.csv("data/Miscanthus_sinensis_yield.csv")

# open a connection for plotting a figure
#pdf("figures/example_plot.pdf")
plot(mydata$Biomass.yield, mydata$Plant.height)
#dev.off() # close the connection to the file

x <- 1 + 1 # an assignment

1 + 1 # an expression

x <- x + 1 # assignment operator necessary for changing values

y <- x + 5

x <- 6

# indexing a data frame
mydata$Latitude
mydata[[2]]
mydata[1:5, 1:3]

mydata$Height.over.stems <- mydata$Plant.height / 
  mydata$Number.of.stems

# creating a vector
myvect <- c(4.5, 5, 2, 3)
myvect
biggervect <- c(myvect, c(1, 2, 3))

biggervect + 1
biggervect + c(0, 1)
myvect + c(0, 1)

# mini-exercise
newvect <- mydata$Plant.height * mydata$Number.of.stems *
  mydata$Stem.diameter ^ 2
newvect
mydata$Approx.volume <- newvect

mydata$Approx.volume <- mydata$Plant.height * mydata$Number.of.stems *
  mydata$Stem.diameter ^ 2

plot(mydata$Approx.volume, mydata$Biomass.yield)

# indexing
biggervect
biggervect[3:5]
biggervect[3:5] <- c(4, 5, 6)

mydata[c(4, 8, 3),1:5]
mydata[2, 5]

# single values are still vectors of length one
is.vector(2)

mydata$Approx.volume[1:5]
mydata[1:5,]
head(mydata)

# booleans
!TRUE # NOT
!FALSE
!c(TRUE, FALSE)

TRUE | TRUE # OR
TRUE | FALSE
FALSE | FALSE

TRUE & TRUE # AND
TRUE & FALSE

c(TRUE, FALSE) | c(FALSE, TRUE)

mydata$Stem.diameter <= 3

mydata$Genetic.group == "N Japan"

c("S Japan", "China") %in% mydata$Genetic.group

# indexing by Boolean
mydata$Plant.height[mydata$Genetic.group == "N Japan"]

# which to get rid of NA
mydata$Plant.height[which(mydata$Stem.diameter > 5)]

myvect[c(2, NA)]

mean(mydata$Stem.diameter > 5, na.rm = TRUE)

# mini exercise
tokeep <- which(mydata$Number.of.stems > 220 & 
                  mydata$Stem.diameter >= 7)
tokeep
mydata[tokeep, ]

sum(mydata$Biomass.yield > 1000, na.rm = TRUE)

mean(myvect, 1, TRUE)

# exporting data
mydata2 <- mydata[tokeep, ]

write.csv(mydata2, "data_subset.csv", row.names = FALSE)

mydata2 <- read.csv("data_subset.csv")

#save(mydata2, file = "mydata2.RData")
load("mydata2.RData")
