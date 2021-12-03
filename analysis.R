# Question 1: In which country (X or Y) did the disease outbreak likely begin?
# Question 2: If Country Y develops a vaccine for the disease, is it likely to work for citizens of Country X?


#Assumptions:
# path= "~/Desktop/R Studio Projects/Rproject2021/"
#objects in Rproject2021:
  #countryX folder
  #countryY folder
  #allData.csv
  #supportingFunctions.R
  #analysis.R
#Go to working directory
setwd(dirname(getwd()))
#Use source() to load functions in supportingFunctions.R
source("supportingFunctions.R")
##Run All Functions
#convert .txt files into .csv
csv_converter("countryY")
#compile all .csv files
source("compile.R")

source("summary.R")
#summarize data
summary("allData.csv")

#From plots 'C' and 'D' found in the summary, we see ...
  # Country X: greater number of bacteria markers, concentrated in 1-5
  # Country Y: smaller number of markers present, but more distribution 
# More distribution means that the 

#This means the disease (bacteria) likely underwent mutations between Country X and Country Y. 