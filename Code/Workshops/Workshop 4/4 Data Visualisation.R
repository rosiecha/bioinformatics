library("tidyverse")
library("vroom")

covid_data <- vroom("https://raw.githubusercontent.com/chrit88/Bioinformatics_data/master/Workshop%203/time_series_covid19_deaths_global.csv")
names(covid_data)[1:2] <- c("Province.State", "Country.Region")

#Converting wide to long shape
covid_long <- covid_data %>%
  pivot_longer(cols = -c(Province.State:Long),
               names_to = "Date",
               values_to = "Deaths")

#loading wbstats:
library("wbstats")
#extract the population data for all countries
pop_data <- wb_data(indicator = "SP.POP.TOTL", 
                    start_date = 2002, 
                    end_date = 2020)

pop_data <- as_tibble(pop_data)

# Find the maximum value in the date column to find the most recent year:
max(pop_data$date)

# Filter the data to include data from the year 2020 only:
pop_2020 <- pop_data %>% 
  filter(date == 2020)

## Cleaning the data
#Before we can join these data frames, need to convert covid data so it is not split by region
covid_country <- covid_long %>% 
  group_by(Country.Region, Date) %>% 
  summarise(Deaths = sum(Deaths))
covid_country

#Issue matching country names in the two data sets - differences in spelling/grammar
library("countrycode")
covid_country$country_code <- countrycode(covid_country$Country.Region, origin = "country.name", destination = "iso3c")

## Joining data
names(pop_2020)[5] <- "value"
covid_w_pop <- left_join(covid_country, #first data set
                         pop_2020 %>% select(iso3c, value), #second data set, specific columns selected
                         by = c("country_code"="iso3c"))

#Want to rename "value" column to something more meaningful
which(names(covid_w_pop) == "value")
names(covid_w_pop)[which(names(covid_w_pop) == "value")] <- "Population"

## Calculating death rates

# Total global deaths
most_recent <- covid_w_pop %>% 
  ##only return data where the date is equal to the maximum value in the column "date"
  filter(Date == max(covid_w_pop$Date))

#sum the deaths
sum(most_recent$Deaths)


## Deaths per day globally
global_deaths_day <- covid_w_pop %>% 
  group_by(Date) %>%
  summarise("Global.deaths" = sum(Deaths))

global_deaths_day

#To check for NA issues:
which(is.na(global_deaths_day$Global.deaths))

#Add deaths per million column:
covid_w_pop$Deaths.p.m <- covid_w_pop$Deaths/(covid_w_pop$Population/1000000)
covid_w_pop 


### Data visualisation from here!

## make a ggplot object using ggplot() function
#aes argument for aesthetics
ggplot(data = global_deaths_day, aes(x = Date, y = Global.deaths)) + 
  ##add a geom to that object (in this case geom_point)
  ## notice the + after the ggplot() argument which allows us to split this over multiple lines
  geom_point()


# Is reading dates as characters
#To convert to date format:
global_deaths_day$Date.corrected <- as.Date(global_deaths_day$Date, format = "%m/%d/%y")
#using as.Date() from base R

ggplot(data = global_deaths_day, aes(x = Date.corrected, y = Global.deaths)) + geom_point()



## Using geom_...()
#e.g. geom_point()

#creating a line plot instead of scatter plot:
ggplot(data = global_deaths_day, aes(x = Date.corrected, y = Global.deaths)) + geom_line()

#scatter and line overlaid
ggplot(data = global_deaths_day, aes(x = Date.corrected, y = Global.deaths)) + 
  geom_point(col= "darkgrey") +
  geom_line(col= "red")
#can use col = to recolour plots
#plotted in order written so line is over scatter plot

#many more geoms available



### Splitting up ggplot arguments

##make the ggplot object
p1 <- ggplot(data = global_deaths_day, aes(x = Date.corrected, y = Global.deaths)) 
## add the graphic (in this case lines)
p2 <- p1 + geom_line()
p1

# testing how a graphic might look, but not overwriting it:
p1 + geom_point()
  
##make a second plot where you have points too, saved to a new object so you dont overwrite p1:
p2<-p1+geom_point()
p2


### Grouped data
#Want to plot the covid_w_pop data by country 
#to visualise how the virus has spread over time in different places across the world.

# Aesthetic grouping

covid_w_pop$Date.corrected <- as.Date(covid_w_pop$Date, format = "%m/%d/%y")

by_country <- ggplot(data = covid_w_pop, aes(x = Date.corrected, y = Deaths)) 

#View ggplot as scatter plot with countries coloured:
by_country + geom_point(aes(col = Country.Region))
#col argument in aes function assigns each country a different colour.
#can't actually see the plot due to the size of the legend

#use ggplot function theme() to change other aspects of plot not relating to data:

by_country + geom_point(aes(col = Country.Region)) + theme(legend.position = "none")
#hides legend



# To look at selection of countries:

##make a vector of countries we want to look at:
selec_countries <- c("United Kingdom", "China", "US", "Italy", "France", "Germany")

##use this to filter by for our plot. here using the %in% operature:
sel_country_plot <- ggplot(data = covid_w_pop %>% 
                             filter(Country.Region %in% selec_countries), 
                             aes(x = Date.corrected, y = Deaths)) 

##add a line geom specifying that the colours are dependant on the groups in `Country.Region`
sel_country_plot + geom_line(aes(col=Country.Region))



### Point/line types
#Can alternatively alter the aesthetics of the point/lines

##set line type by country
sel_country_plot + geom_line(aes(linetype = Country.Region))

##set point type by country
sel_country_plot + geom_point(aes(shape = Country.Region))


### Faceting
#Alternatively can spread data from different groups across subplots (facets)
#Use facet_wrap() or facet_grid()

#Need to use the ~ operature - means as a function of
#If you have two groups to facet by, you specify them as facet_wrap(x ~ y)
#Facet the data by country:
sel_country_plot + geom_line() + facet_wrap(. ~ Country.Region)

#Can also stack arguments:
sel_country_plot + geom_line(aes(col = Country.Region)) + facet_wrap(. ~ Country.Region)


### Saving plots
#Use pdf() function
#Use pdf() function then run code to print plot, then use dev.off() to stop pdf() function

##specify the directory and name of the pdf, and the width and height
pdf("~/R/bioinformatics/Code/Workshops/Workshop 4/Deaths by country.pdf", width = 6, height = 4)

##run your code to print your plot
sel_country_plot + 
  ##add lines
  geom_line(aes(col = Country.Region)) + 
  ##add facets
  facet_wrap(. ~ Country.Region)

##stop the pdf function and finish the .pdf file
dev.off()
