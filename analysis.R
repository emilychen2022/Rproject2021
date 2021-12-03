
##Plot 1 : Number of Screens Per Country Bar Plot
# compile data for screens for Total, Country X, and Country Y
Location <- c("Total Screens", "Country X", "Country Y")
Screens <- c(total_screens, countryX_screens, countryY_screens)
Screens_df <- data.frame(Location, Screens)
# Plot Data
plot_1 <- ggplot(data = Screens_df, aes(x=Location, y=Screens))+
  geom_col(aes(fill=Location))+
  ggtitle("Number of Screens Run per Country")+
  theme(legend.position = "none")
fig_1<-plot_grid(plot_1)
return(fig_2)

##Plot 2 : Percent Infected 
#compile data
slices <- c(percent_infected, percent_not_infected)
lbls <- c("Infected", "Not Infected")
pct <- round(slices)
lbls <- paste(lbls, pct) # add percents to labels
lbls <- paste(lbls,"%",sep="") # ads % to labels
pie(slices,labels = lbls, col=rainbow(length(lbls)), main="Infected v. Not Infected")
fig_2<-plot_grid(plot_2)
return(fig_2)

##Plot 3: