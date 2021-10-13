### Worksheet 3, 6.0 onwards, Data handling

#Tidyverse package: a collection of some of the most useful packages in R
##install the tidyverse
install.packages("tidyverse")
#and then loading as normal:
library("tidyverse")

## Pipelines
#Pipelines are a way of chaining a series of functions together
#The data created using one function are passed straight to the next function in the chain

#Take the form of:
## my_data %>% function_1() %>% function_2()
#and so on, with as many functions as needed.

#If using a v large dataset, can start to slow down
#Can use other options e.g. data.table

## data.table
#A package specifically designed to deal with big data
#Focussing on tidyverse as simpler, but data.table is valid alternative

## Summarising data

wad_dat <- vroom("./Code/Workshops/Workshop 3/wader_data.csv")
covid_data <- vroom("https://raw.githubusercontent.com/chrit88/Bioinformatics_data/master/Workshop%203/time_series_covid19_deaths_global.csv")
#2 data files loaded into R

#Looking at covid data set:
#What class is the object?
class(covid_data)
#this file has 4 classes: spec_tbl_df, tbl_df, tbl and data.frame
#tbl stands for tibble - a kind of data.frame.
#The universal data type used by the tidyverse
#covid_data is a tibble bc we read it using vroom - output is tibble
#tibble automatically display a lot of info:
covid_data

#Tidying up data
#This data is in wide data format - multiple data recordings per row
#Also, two column headers contain an operator (/)
#To avoid issues, change the first two names of out data frame:
names(covid_data)[1:2] <- c("Province.State", "Country.Region")


## Basic data reshaping
#Using pivot_
#To shape data from wide to long format, use the pivot_longer() function
#With the magrittr operator - %>%
covid_long <- covid_data %>% pivot_longer(cols = -c(Province.State, Country.Region, Lat, Long))
#use cols = to specify the columns to pivot the data around
#the "-" before c()is also needed.
#could alternatively use Province.State:Long instead of listing all the columns to pivot around
covid_long

#The columns not specified to be pivoted around have been put in long format
#And named "name" and "value"
#These need renaming

##use this instead:
covid_long <- covid_data %>%
  ##and then apply this function 
  pivot_longer(cols = -c(Province.State:Long),
               names_to = "Date",
               values_to = "Deaths")
#to view
covid_long

#to convert to wide format instead of long, use pivot_wider()
#two columns: one containing name of soon-to-be column, one containing the data to go in the column.
#see workshop 3 for e.g. of code

