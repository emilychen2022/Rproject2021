setwd("C:Desktop/R Studio Projects/Rproject2021")

#STEP (1) convert .txt to .csv
dir<-setwd("~/Desktop/R Studio Projects/Rproject2021/")
csv_converter <- function(dir){
  setwd(dir)
  data <- list.files(pattern = ".txt")
  for (i in 1:length(data)){
    DATA=read.table(file=data[i],header=T)
    write.table(DATA,file=paste0("~/Desktop/R Studio Projects/Rproject2021/countryY/",sub(".txt","",data[i]),".csv"),row.names=F,quote=F,sep=",")
  }
  file.remove(data)
}

csv_converter("countryY")

#STEP (2) compile all csv files from country Y into one csv vile
csvcompiling <- function(dir) {
  # define fileset
  files<-list.files(path=dir, full.names=TRUE)
  # read in first file
  alldata <- read.csv("~/Desktop/R Studio Projects/Rproject2021/countryY/screen_120.csv", header=TRUE, stringsAsFactors = FALSE)
  alldata$country <- numeric(length=nrow(alldata))
  for (i in 1:length(alldata$country)){
    alldata$country[i] = "Y"
  }
  alldata$DOY <- numeric(length=nrow(alldata))
  for (i in 1:length(alldata$DOY)){
    alldata$DOY[i] = 120
  }
  year = 121
  for(i in 2:length(files)){
    # open every file and add columns for country and DOY
    csvdata <- read.table(file=files[i], sep=',', header=TRUE, stringsAsFactors=FALSE)
    csvdata$country <- numeric(length=nrow(csvdata))
    for (i in 1:length(csvdata$country)){
      csvdata$country[i] = "Y"
    }
    csvdata$DOY <- numeric(length=nrow(csvdata))
    for (i in 1:length(csvdata$DOY)){
      csvdata$DOY[i] = year
    }
    # combine all files 
    alldata <-rbind(alldata,csvdata)
    year = year + 1 
  }
  return(alldata)
}

dfy <- csvcompiling("~/Desktop/R Studio Projects/Rproject2021/countryY/")

##2b: Repeat previous function with country X
csvcompiling <- function(dir) {
  # define fileset
  files<-list.files(path=dir, full.names=TRUE)
  # read in first file
  alldata <- read.csv("~/Desktop/R Studio Projects/Rproject2021/countryX/screen_120.csv",header=TRUE, stringsAsFactors = FALSE)
  alldata$country <- numeric(length=nrow(alldata))
  for (i in 1:length(alldata$country)){
    alldata$country[i] = "X"
  }
  alldata$DOY <- numeric(length=nrow(alldata))
  for (i in 1:length(alldata$DOY)){
    alldata$DOY[i] = 120
  }
  year = 121
  for(i in 2:length(files)){
    # open every file and add columns for country and DOY
    csvdata <- read.table(file=files[i], sep=',', header=TRUE,
                          stringsAsFactors=FALSE)
    csvdata$country <- numeric(length=nrow(csvdata))
    for (i in 1:length(csvdata$country)){
      csvdata$country[i] = "X"
    }
    csvdata$DOY <- numeric(length=nrow(csvdata))
    for (i in 1:length(csvdata$DOY)){
      csvdata$DOY[i] = year
    }
    # combine all files 
    alldata <-rbind(alldata,csvdata)
    year = year + 1 
  }
  return(alldata)
}

dfx <- csvcompiling("~/Desktop/R Studio Projects/Rproject2021/countryX/")

##2c: Bring data from both countries into one single csv file 
setwd("~/Desktop/R Studio Projects/Rproject2021")
write.csv(rbind(dfx, dfy),"finalcombineddata.csv")
read.csv("finalcombineddata.csv")


##Step (3) - Write a function to summarize the compiled data set in terms of number of screens run, 
#percent of patients screened that were infected, male vs. female patients, and the age distribution of patients

#establish function and load data from combined file
library(ggplot2)
library(cowplot)

summary <- function(file){
#Load Data
  data <- read.csv("allData.csv", header=TRUE, sep= ",", stringsAsFactors=FALSE)
#Number of Screens Total = number of rows (i.e. number of people tested)
  total_screens <- nrow(data)
#Number of screens for each country
  Xfiles <- subset(data, country == "X")
  countryX_screens <- nrow(Xfiles)
  Yfiles <- subset(data, country == "Y")
  countryY_screens <- nrow(Yfiles)
# compile data for screens for Total, Country X, and Country Y
  Location <- c("Total Screens", "Country X", "Country Y")
  Screens <- c(total_screens, countryX_screens, countryY_screens)
  Screens_df <- data.frame(Location, Screens)
  # Plot Data
  plota <- ggplot(data = Screens_df, aes(x=Location, y=Screens))+
    geom_col(aes(fill=Location))+
    ggtitle("Number of Screens Run per Country")+
    theme(legend.position = "none")
fig<-plot_grid(plota)
}
summary(allData.csv)


summary <- function(file){     #"file" is the file name
  #Load data 
  data <- read.table("allData.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)
  #Number of screens run
  total_screens <- nrow(data)
  cat("The number of total screens run: ", total_screens, "\n")
  #Percent of patients screened that were infected
  nInfected <- 0
  for(n in 1:nrow(data)){
    if(is.element(1, data[n,3:12]) == TRUE){
      nInfected <- nInfected + 1
    }
  }
  percentInfected <- nInfected / nscreens * 100
  #Male vs. female patients
  nMale <- 0
  nFemale <- 0
  for(n in 1:nrow(data)){
    if(is.element(1, data[n,3:12]) == TRUE){
      if(data[n,1] == "male"){
        nMale <- nMale + 1
      }else{
        nFemale <- nFemale + 1
      }
    }
  }
  pMale <- nMale / nInfected * 100
  pFemale <- nFemale / nInfected * 100
  #Age distribution of patients
  ageDist <- summary(data$age)
  #return statement
  returns <- list("Number of screens run:" = nscreens, "Percent infected" = percentInfected, "Percent of infected patients that are male" = pMale, "Percent of infected patients that are female" = pFemale, "Age distribution of all patients" = ageDist)
  return(returns)
}
