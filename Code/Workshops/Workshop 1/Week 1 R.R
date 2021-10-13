##Run lines separately.

##Adding 1 plus 1 together
1+1
#[1] 2

##1 divided by 0 gives infinite number (non-trivial)
##marked by Inf
1/0
#[1] Inf

##0 divided by 0 gives NaN - not a number
##because mathematically 0/0 is not defined
0/0
#[1] NaN

##These may suggest an error in your code
##Also may see NA (not available): 
##suggests missing values in data

##Assign values to objects a and d:
a <- 1
d <- 10
##<- is the assignment operator
##Shortcut is Alt & -

##Shows the value of a:
a

##An object can also be a piece of code
## e.g. defining h:
h <- (-6+(6^2-4*1*5)^(1/2))/(2*1)
h #show h value, should be -1

##k is h divided by d
k <- h/d
k #show k value, should be -0.1

#R will overwrite an object if you
##assign another object the same name
k <- 5/4 #defines k
k <- 20 #overwrites k
k #look at value of k
##gives [1] 20

#There are various environments in which R can store variables
#The objects above are saved into the Global Environment
#Objects in the global environment are present until R is closed
##or until the memory is wiped

#Style guide
#Object names should be lowercase, short, meaningful
#e.g day_one
#Avoid names already defined as functions/variables
#e.g. "c" is pre-defined as ?one of these
#Put spaces between infix operators and arguments (=,+,- etc)
##Except when using ":", or inside ()

##R can deal w vectors containing multiple numeric values OR multiple character values
##Not both numerical values and characters
##If both are input, R will assume the numerical values are literal values:
b <- c("a", 2)
##Treats 2 as "2" here, so gives
##[1] "a" "2"
##when b is input:
b

#To define longer vectors we need to use a function called "c"
#c allows you to combine multiple values into a vector
a <- c(1, 5, 4, 2)
#Creates a numeric vector
#Look at vector, gives [1] 1 5 4 2

#Can retrieve the length of a vector using function length():
length(a)
#Gives [1] 4

#c() can also be used to combine multiple vectors into larger vectors
a <- c(1, 5, 4, 2)
g <- c(10, 2.1, 3)
#Defines vector g
c(a, g)
#Combines a and g in order listed

#You can also specify vectors within other vectors
a <- c(1, 5, 4, 2)
g <- c(10, 2.1, a, 3)
#Defines vector g which includes a

#Look at g
g

#To access data in a vector we can use square brackets
##Work as coordinates
g[3]
#Gives the third object in g:
## [1] 1

#Can also ask for multiple values
g[c(2,3)]
#Will give the 2nd and 3rd value of the vector
## [1] 2.1 1.0
#c used as have to give a vector of values

#Can do arithmetic directly with/on these vectors if numerical
a <- c(1, 5, 4, 2) #defines a
b <- a*4 #multiplies a by 4
b #look at b
#gives [1] 4 20 16 8

a * b #multiplies a by b
#gives [1] 4 100 64 16

#Non-integer values will only be displayed to 7 digits

#We can name the positions in a vector
#To specify names, we use =
my_vec <- c("a" = 1, "d" = 3, "b" = 2)
#Defines a vector with named positions
my_vec
#The first value names the position/object

#The names of an existing vector can be modified
my_vec <- c(1, 3, 2)
my_vec # Gives [1] 1 3 2

names(my_vec) <- c("a", "d", "b")
#assigns names to the vector using the names() function
my_vec
##gives:
# a d b
# 1 3 2
##these are names numeric vectors

#Can still access items in this vector as earlier
my_vec[2]
#Retrieves 2nd value in vector, gives:
# d
# 3

#Can also pull out a value if order has been changed
my_vec["d"]
#The "" signifies a named position
#Gives 
## d
## 3

#Objects in vectors can be sorted
my_vec <- c(1, 3, 2)
names(my_vec) <- c("a", "d", "b")
sorted_vec <- sort(my_vec)
#This sorts the values from smallest to largest
sorted_vec
#Gives
## a b d
## 1 2 3

#Can now return the previously second value 
#by returning the value named d:
sorted_vec["d"]

#Can also view the names of a vector using the names() function
names(my_vec)
#Gives [1] "a" "d" "b"

###Character vectors
#Characters always need to be in quotation parks
#When we don't include "", R assumes it is looking for an object of that name

###Factors

##student names
class_names <- c("James", "John", "Mary", "Linda", "Susan", "Mary", "Charles", "John", "James")
#9 people in class, only 6 different names
#Currently stored as character vector

#Convert vector to factor
class_names <- as.factor(class_names)
#Look at factor
class_names
#Look only at levels
levels(class_names)
#Gives the unique values of the categories in the data
#Sorted in alphabetical order


###Logical vectors
#Logical arguments in R (TRUE/FALSE) 

#a logical vector
logic_vec <- c("TRUE", "FALSE")
#logic vectors are a subset of character vectors, requires "

#E.g. generate a vector of random numbers
x <- runif(n = 10, min = 0, max = 20)
#runif() is a function that generates uniformly distributes random numbers
#generates 10 numbers between 0 and 20

x
#look at vector
#can then use the logical argument greater than to produce a logical vector of answers
x > 5
#gives list of TRUEs and FALSEs corresponding to objects in vector
#on workbook is list of logical operators
# == equal to
# != not equal to
# <, <=, >, >=
# | or
# %in%

#to return only the numbers from the vector which are greater than 5:
x[x > 5]

##Checking vectors
#Can check what a vector is made of using:

is.numeric(1:5)
#is this vector numeric?
#gives [1] TRUE

is.logical(c(TRUE, 1))
#is this vector logical?
#gives [1] FALSE as contains a number also

###FUNCTIONS
#Can download functions other people have written
#e.g. c() and length()

#to calculate mean, want to use function as quicker and more reliable than manually typing
a <- c(1, 4, 6, 2, 10, 12, 3, 85, 17, 2)
sum_a <- sum(a)
#gives sum of values in the vector
length_a <- length(a)
#gives length of vector
#mean is sum/length:
sum_a/length_a
##Gives [1] 14.2

#There is already a function to calc the mean
mean(a)

#Arguments
#function to round values to integers
round(c(1.2536, 2.54, 4.1124, 7.28821))
##gives [1] 1 3 4 7
#if want to round to specific no of places, use argument
round(c(1.2536, 2.54, 4.1124, 7.28821), digits = 1)
#digits=1 argument means vector is rounded to 1dp

##R has inbuilt help function using ? command
#in front of function will bring up associated help file
?mean()
#Shows default settings when no arguments are provided
#Here, default is not to trim (trim=0). Fraction of observations to be trimmed from each end of x
#Also, na.rm = FALSE. A logical value indicating where NA values should be stripped before computation proceeds

vec <- c(1, 5, 6, 3, NA, 10, 12)
#vector including NA value
mean(vec) #gives [1] NA as na.rm = FALSE
mean(vec, na.rm = T) #NA values ignored
#Gives 6.166667
#R assumes x in mean(x) is vec due to order of argument
#OK as long as arguments are in correct order

##Nesting functions
#Used to generate efficient code
#e.g.
mean(x = sqrt(x = runif(n=10, min=0, max=20)))

#base is the library of standard functions in R


##Writing own functions
#First make object called se (standard error)
se <- function(x)
  #Defines se as a function
  #Put arguments in parentheses
  #Tells R this function requires an object called x
  
#Can also define names of arguments your function needs
a_new_function <- function(data, na.rm, round)
  
#Use curly brackets {} to specify what we want to do with x
se <- function(x){
    
}
  
#To calc SE, standard deviation of data/square root of data n
#Function sd() calculates standard deviation
#sqrt() calculates squareroot of numeric values

se <- function(x){
  
  std_er <- sd(x)/sqrt(length(x))
  #defines object std_er
  return(std_er)
}

#return function tells R to give us back std_er as result of se() function
#when a function is run, a new temp environment is made which the function operates in
#the object std_er must therefore be returned to the global environment

numberlist <- runif(n=10, min=0, max=20)
numberlist
#generates random numbers
se(x = numberlist)
#finds standard dev of list
