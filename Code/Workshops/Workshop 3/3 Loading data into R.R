### Worksheet 3 4.0 onwards, Loading Data into R

##.csv files
#Restricted to matrix style data
#i.e. data in 2 dimensions, matrices and data,frames
#can't store data in lists or arrays

#going to use vroom() function from vroom package
##Loading from local PC:
wad_dat <- vroom("./Code/Workshops/Workshop 3/wader_data.csv")

##look at the top of the data
head(wad_dat)

#Loading in covid data added to repository after workshop 2
cov_data <- vroom("./Data/Workshop 3/time_series_covid19_deaths_global.csv")
head(cov_data)



##Loading from GitHub

#Can also load data from an online repository
#To load from GitHub, navigate to the file online and click 'Raw'
#Copy the URL and paste into the vroom function, e.g.:
covid_data <- vroom("https://raw.githubusercontent.com/chrit88/Bioinformatics_data/master/Workshop%203/time_series_covid19_deaths_global.csv")
head(covid_data)

#vroom can also load multiple files simultaneously, combining them into a single object 
#as long as the column names are the same across the different files.
#don't need to understand code below:

#######
##you can ignore this code for the moment if you want
##but to briefly summarise it is reading in some data included in base R
##and then splitting it into 3 differnt data.frame style objects based on the values in one of the columns ("cyl")
mt <- tibble::rownames_to_column(mtcars, "model")
purrr::iwalk(
  split(mt, mt$cyl),
  ##save this split files in to the default directory
  ~ vroom_write(.x, glue::glue("mtcars_{.y}.csv"), "\t")
)

##find files in the default directory which start with "mtcars" and end in "csv"
##save these file names as an object called "files"
files <- fs::dir_ls(glob = "mtcars*csv")

##these are then the names of the files matching the above arguments:
files
##gives mtcars_4.csv, mtcars_6.csv, mtcars_8.csv

##then load these file names using vroom 
vroom(files)
#vroom() now returns a single file which is the combination of the three files we read in.
######



## .RData
#Another useful file type
#You can share complex data types like lists, matrices, etc
#But can't open it in other programmes e.g. excel

#.RData are loaded into R using the load() function
#e.g. load("my_data/pathway/my_data.RData")
#However, you don’t need to specify an object to save the data too 
#as it will just directly load the object my_data into the R.