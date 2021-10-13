### Worksheet 3, 5.0 onwards, Writing data out of R

#To export a .csv file we can again use the vroom function:
my_data <- data.frame( "a" = runif(10, 0, 1), 
                       "b" =  rnorm(10, 3, 5))
vroom_write(my_data, "./Code/Workshops/Workshop 3/testing_export.csv")
#where my_data is a data.frame
#this file is now saved to this pathway


#Similarly, RData can be written out using the save() function in base:
#To write out my data as an RData file:
save(my_data, file = "./Code/Workshops/Workshop 3/testing_export.RData")
#However we can here specify as many items as we want to save out
#and these data types can be anything R can handle (vector, list, array, etc)
#unlike csv doesn't have to be a data.frame

