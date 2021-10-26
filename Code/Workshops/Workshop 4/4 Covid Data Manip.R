library("tidyverse")
library("vroom")

#Importing data
covid_data <- vroom("https://raw.githubusercontent.com/chrit88/Bioinformatics_data/master/Workshop%203/time_series_covid19_deaths_global.csv")

#Renaming columns containing "/"
names(covid_data)[1:2] <- c("Province.State", "Country.Region")

#Converting wide to long shape
covid_long <- covid_data %>%
  pivot_longer(cols = -c(Province.State:Long),
               names_to = "Date",
               values_to = "Deaths")
covid_long

#tidyverse data manipulation has 5 common themes: select(), mutate(), filter(), summarise(), arrange()
#can be combined with group_by()

## Getting country pop data

#someone has build an R package to allow us to easily access the world bank data: wbstats
#installing wbstats:
#remotes::install_github("nset-ornl/wbstats")

#loading wbstats:
library("wbstats")

#extract the population data for all countries
pop_data <- wb_data(indicator = "SP.POP.TOTL", 
                    start_date = 2002, 
                    end_date = 2020)


#convert it to a tibble
pop_data <- as_tibble(pop_data)
pop_data


#Task: work out most recent data available in pop_data
#Find the maximum value in the date column to find the most recent year:
max(pop_data$date)

## Filtering data
#Want to filter out latest available pop counts for each country
#Use filter() function, with logical operators and other functions
#Want the data from 2020:

## filter the data to include data from the year 2020 only:
pop_2020 <- pop_data %>% 
  ##only return data where the date is equal to the maximum value in the column "date"
  filter(date == 2020)

##look at the data
pop_2020
#want to merge this data into the covid data


## Cleaning the data

##Issues with merging data:
#The wb data contains countries AND economic areas.
#Therefore we drop the values for countries in the pop_2020 data set which don't match the countries in the covid data
#Will only be able to join data sets when the country names match ecavtly
#Major issue: province.state column in covid data


## just look at the data from Australia:
covid_long %>% filter(Country.Region == "Australia")
pop_data %>% filter(country == "Australia")
# WB data does not contain provinces/states

#Before we can join these data frames, need to convert covid data so it is not split by region
#Use summarise function

# make a new data.frame from the old covid_long data.frame
covid_country <- covid_long %>% 
  # we want to calculate the number of 
  ##deaths in each country and at each date:
  group_by(Country.Region, Date) %>% 
  ## and we want the sum of the "Death" column in these groups:
  summarise(Deaths = sum(Deaths))

covid_country

#Issue matching country names in the two data sets - differences in spelling/grammar
#Use the 3 letter codes provided in the WB iso3c column
#Use an R package to utilise these codes:

library("countrycode")

covid_country$country_code <- countrycode(covid_country$Country.Region, origin = "country.name", destination = "iso3c")
#Use $ here not [""] to look up index - don't know why.
#Adds vector of codes to covid_country
covid_country



## Joining data
#Use _join() functions - left join in this case
#Also don't want ALL columns in WB data, so use select() function
names(pop_2020)[5] <- "value"

#Join the data sets:
covid_w_pop <- left_join(covid_country, #first data set
                         pop_2020 %>% select(iso3c, value), #second data set, specific columns selected
                         by = c("country_code"="iso3c"))
covid_w_pop

#Want to rename "value" column to something more meaningful
#Use which function to find value column without having to specify location:
which(names(covid_w_pop) == "value")
#Returns the location of the value column

#Change the name
names(covid_w_pop)[which(names(covid_w_pop) == "value")] <- "Population"

covid_w_pop



## Calculating death rates

# Total global deaths
#Data in set in cumulative - total deaths is sum of data for all countries in most recent date
#Use filter:
## filter the data to include data from the year 2020 only:
most_recent <- covid_w_pop %>% 
  ##only return data where the date is equal to the maximum value in the column "date"
  filter(Date == max(covid_w_pop$Date))
most_recent

#sum the deaths
sum(most_recent$Deaths)



## Deaths per day globally
global_deaths_day <- covid_w_pop %>% 
  # we want to calculate the total number of 
  ##deaths at each date:
  group_by(Date) %>% 
  ## and we want the sum of the "Death" column in these groups:
  summarise("Global.Deaths" = sum(Deaths))

global_deaths_day

#To check for NA issues:
which(is.na(global_deaths_day$Global.Deaths))

covid_w_pop$Deaths.p.m <- covid_w_pop$Deaths/(covid_w_pop$Population/1000000)
covid_w_pop 

