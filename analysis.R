
##Plot 1 : Number of Screens Per Country Bar Plot
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
plot_1 <- ggplot(data = Screens_df, aes(x=Location, y=Screens))+
  geom_col(aes(fill=Location))+
  ggtitle("Number of Screens Run per Country")+
  theme(legend.position = "none")
fig<-plot_grid(plot_1)
return(fig)

##Plot 2 : Percent Infected 
slices <- c(percent_infected, percent_not_infected)
lbls <- c("Infected", "Not Infected")
pct <- round(slices)
lbls <- paste(lbls, pct) # add percents to labels
lbls <- paste(lbls,"%",sep="") # ads % to labels
plot_2 <- pie(slices,labels = lbls, col=rainbow(length(lbls)), main="Infected v. Not Infected")