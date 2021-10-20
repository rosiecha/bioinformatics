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
remotes::install_github("nset-ornl/wbstats")