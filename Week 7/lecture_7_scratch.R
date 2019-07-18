function(x){
  return(length(x) <= 50)
} 

fruits <- c("apple", "orange", "banana")
gsub("a", c("A", "aa", "o"), fruits)

# apply across a vector with a custom function
sapply(c("A", "aa", "o"),
       function(x) gsub("a", x, fruits))

mypattern <- c("an", "or", "pp")
myreplacement <- c("AN", "OR", "PP")

# apply across multiple vectors
mapply(function(x, y) gsub(x, y, fruits),
       mypattern, myreplacement)

# tapply
msiyield <- read.csv("Miscanthus_sinensis_yield.csv")
myindex <- msiyield$Genetic.group

tapply(msiyield$Plant.height, myindex, mean, na.rm = TRUE)

# by
# get snp_mat from last week
# msi groups from week 3
mygrps <- read.csv("Msi_groups_and_phenotypes.csv")
dim(snp_mat)
# get matching names between snp matrix and table
mygrps_samples <- as.character(mygrps$Sample_name)
mymatch <- mygrps_samples[mygrps_samples %in% rownames(snp_mat)]
snp_mat2 <- snp_mat[mymatch,]
dim(snp_mat2)

match_groups <- mygrps$DAPC_group[match(mymatch, 
                                        mygrps_samples)]
length(match_groups)
match_groups[1:20]

mycolMeans <- by(snp_mat2, match_groups, colMeans, na.rm = TRUE)
mycolMeans[1:3]
str(mycolMeans)
mycolMeans$`N Japan`

myfreqs <- by(snp_mat2, match_groups, 
              function(x) colMeans(x, na.rm = TRUE)/2)
myfreqs[[1]]

## environments and namespaces
a <- 1:5
tracemem(a) # this shows you where the object is in physical memory
b <- a
tracemem(b)
b[2] <- 6

myfun <- function(x){
  x <- x-1
  cat(tracemem(x))
  return(x + 1)
}

myfun(a)

search() # where does R look for variable names

# overlaps between namespaces

round <- function(x){
  return(x %/% 1)
}

round(6.7)
round(6.7, digits = 3)
base::round(6.7, digits = 3)


# function within a function
fun1 <- function(x){
  fun2 <- function(y){
    return(y^2)
  }
  
  return(fun2(x) + 1)
}
fun1(3)

# classes
class(fun1)
typeof(fun1)
fun1[2]

a
class(a)
typeof(a)
b
class(b)
typeof(b)

class(snp_mat)
typeof(snp_mat)

class(mygrps)
typeof(mygrps)

is.integer(a)
is.integer(b)
is.numeric(b)
is.numeric(a) # integers give TRUE for is.numeric
is.double(a)
is.double(b)

class(a) == "numeric"
class(b) == "numeric"

is.integer(snp_mat)

# setting up empty vectors
integer(5)
numeric(5)
character(5)
logical(5)

# different classes of NA
test <- rep(NA, 5)
class(test)
test <- rep(NA_integer_, 5)
class(test)
test

# methods
summary(snp_mat)
summary(a)
summary(mymatch)
?summary.Date

?mean
?mean.Date
?mean.default

methods(as.Date)

# using dots in function definitions
minusTenLog <- function(x, ...){
  return(-10 * log(x, ...))
}

minusTenLog(0.05)
minusTenLog(0.05, base = 10)

## integer vs. numeric
some_numbers <- 1:100
class(some_numbers)
object.size(some_numbers) # 4 bytes per value

some_numeric <- as.numeric(some_numbers)
some_numeric
class(some_numeric)
object.size(some_numeric) # 8 bytes per value

is.integer(10L)
is.integer(10)

# precision of floating point numbers
0.3 - 0.2 - 0.1
print(0.3, digits = 18)
print(0.2, digits = 18)
print(0.1, digits = 18)

# numbers that were stored exactly
# anything ending in .0 or .5
# 0.11, .22, .99

# numbers that had rounding error


## integer vs. floating point math
389 + 57

3.5 * 10^8 + 2.2 * 10^6

# keeping integers as integers
x <- 1L + 1
class(x) # int + double = double
y <- 1L + 1L
class(y) # int + int = int
