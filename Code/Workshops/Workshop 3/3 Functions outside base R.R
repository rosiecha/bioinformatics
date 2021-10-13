### Worksheet 3, 3.1 Functions outside base R

#Functions which are not included in the basic installation are contained in “packages” 
#These can be downloaded and installed onto your version of R.
#Packages can be installed from CRAN or GitHub

##CRAN
#Click tools > install packages..
#Or use the install.packages() function:
install.packages("devtools", dependencies = TRUE)
# Dependencies = TRUE tells R to install any other packages that devtools relies on which you haven't already installed.
# See worksheet 3 for issues

#R differentiates between installing a package and loading a packing into the global environment. 
#To load a package (once it is installed) use the library() function:
#load the devtools package
library("devtools")

##Packages on GitHub
#Use install_github() function
#Need to install and load the devtools package (which we have already done). Then we can use the following code to load package:

#Installing vroom package from GitHub:
#The arguament for install_github takes the username and repository name where the package resides 
#vroom url: https://github.com/r-lib/vroom
#We just use the bit after github.com/:
install_github("r-lib/vroom")

library("vroom")

#If there are multiple functions with the same name, then R will use the function from the last package you LOADED into the global environment 
#Can tell R to use a function from a specific package using the :: operator:
#e.g tell R to use the "vroom()" function from the vroom package (see below)
vroom::vroom()