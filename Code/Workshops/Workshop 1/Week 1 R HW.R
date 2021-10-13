###  WEEK 1 HOMEWORK
#EASY CODE


#Vector of 100 random numbers between 0 and 50
my_vec <- runif(n=100, min=0, max=50)
#Shows vector
my_vec 

#Sorting objects in my_vec, from largest to smallest
sorted_vec <- sort(my_vec, decreasing=T)
#Shows sorted vector
sorted_vec 

#Function to subtract log of vector from original vector
lmv <- function(x){
  #subtracts the log10 of vector from vector
  lmv_value <-  x-log10(x)
  
  #returns lmv_value to global environment
  return(lmv_value)
}


#Creates new object from sorted vector
logged_vec <- lmv(sorted_vec)

#Shows new vector
logged_vec

#Function to find standard error
se <- function(x){
  std_er <- sd(x)/sqrt(length(x))
  #Defines object std_er
  return(std_er)
  #Returns std_er
}

#Creating list of mean, standard dev and standard error of new vector
newlist <- c("mean" = mean(logged_vec), "standard dev" = sd(logged_vec), "standard error" = se(logged_vec))
newlist


# ADVANCED CODE

#Creates seq of numbers from 15 to 100
a_vector <- 15:100

#Finds mean of numbers in sequence between 20 and 60
a_mean <- mean(a_vector[a_vector>20 & a_vector<60])
#Shows result
a_mean

#Finds sum of numbers in sequence above 48
a_sum <- sum(aaa_vector[aaa_vector>48])
#Shows result
a_sum

#function to return max and min of vector
max_min<- function(x){
  
  #Sorts vector in descending order, finds first value
  max_numb <- (sort(x, decreasing=T))[1]
  
  #Sorts vector in ascending order, finds first value
  min_numb <- (sort(x))[1]
  
  #Creates vector containing max and min, named
  m_m <- c("max" = max_numb, "min" = min_numb)
  #returns vector
  return(m_m)
  
}

#Test on randomly generated sequence:
max_min(my_vec)

#Reverted back to advanced code
