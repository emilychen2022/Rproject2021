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

summary <- function(file){   #"file" is the file name
#Load Data
  data <- read.csv("allData.csv", header=TRUE, sep= ",", stringsAsFactors=FALSE)

##Number of Screens
#Number of Screens Total = number of rows (i.e. number of people tested)
  total_screens <- nrow(data)
  cat("The number of total screens run: ", total_screens, "\n")
  #Number of screens for each country
  Xfiles <- subset(data, country == "X")
  countryX_screens <- nrow(Xfiles)
  cat("The number of screens in Country X: ", countryX_screens, "\n")
  Yfiles <- subset(data, country == "Y")
  countryY_screens <- nrow(Yfiles)
  cat("The number of screens in Country Y: ", countryY_screens, "\n")
  # compile data for screens for Total, Country X, and Country Y
  Location <- c("Total Screens", "Country X", "Country Y")
  Screens <- c(total_screens, countryX_screens, countryY_screens)
  Screens_df <- data.frame(Location, Screens)
##Plot 1 : Number of Screens
  plot_1 <- ggplot(data = Screens_df, aes(x=Location, y=Screens))+
    geom_col(aes(fill=Location))+
    ggtitle("Number of Screens Run per Country")+
    theme(legend.position = "none")
  
##Percentage of Infected Patients
#Look at each row individually. If infected, individual will have one or more marker as a 1.
  #Percent of patients screened that were infected and not infected
  infected <- nrow(data[data$marker01 == 1 | data$marker02==1 | data$marker03==1 |
                          data$marker04==1 | data$marker05==1 | data$marker06==1 |
                          data$marker07==1 | data$marker08==1 | data$marker09==1 |
                          data$marker10==1, ])
  percent_infected <- (infected/total_screens)*100
  cat("The percent infected: ", percent_infected, "%\n")
  percent_not_infected <- (1-(infected/total_screens))*100
  cat("The percent not infected: ", percent_not_infected, "%\n")

  
##Male v. Female Patients
  total_patients <- nrow(data)
  male <- nrow(data[data$gender == "male",])
  percent_male <- (male/total_patients)*100
  cat("Percentage of male patients: ", percent_male, "%\n")
  female <- nrow(data[data$gender == "female",])
  percent_female <- (female/total_patients)*100
  cat("Percentage of female patients: ", percent_female, "%\n")
  
##Age Distribution
  age_data <- data
  age_data$group <- cut(age_data$age, breaks = c(0,10,20,30,40,50,60,70,80,400),
                             labels = c("0+","10+","20+","30+","40+","50+","60+","70+","80+"),
                             right=T)
##Plot 4: Age Distribution
  plot_4 <- ggplot(age_data, aes(x=group, fill = gender)) +
    geom_bar() +
    ggtitle("Age Distribution") +
    xlab("Age Group") +
    ylab("Number of People")
  
fig<-plot_grid(plot_1, plot_4, labels = c('A', 'B'))
return(fig)
}
summary(allData.csv)

