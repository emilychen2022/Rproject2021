# Question 1: In which country (X or Y) did the disease outbreak likely begin?
# Question 2: If Country Y develops a vaccine for the disease, is it likely to work for citizens of Country X?



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


###STEP (4) - Determine Marker Count
countryX_data <- data[data$country == "X", ]
# Country Y data
countryY_data <- data[data$country == "Y", ]

# Count each marker per country
markers <- data.frame(marker = seq(1,10), 
                      totalX = colSums(countryX_data[, 3:12] != 0),
                      totalY = colSums(countryY_data[, 3:12] != 0))
markers$marker <- as.factor(markers$marker)

# Plots Country X's marker data
x_marker_graph <- ggplot(markers, aes(x = marker, y = totalX, fill = marker)) + 
  geom_bar(stat = "identity") +
  ggtitle("Country X Marker Count") +
  theme(legend.position = "none")+
  xlab("Marker") + ylab("Total")

# Plots Country Y's marker data
y_marker_graph <- ggplot(markers, aes(x = marker, y = totalY, fill = marker)) + 
  geom_bar(stat = "identity") +
  ggtitle("Country Y Marker Count") +
  theme(legend.position = "none")+
  xlab("Marker") + ylab("Total")

# print results
fig<-plot_grid(x_marker_graph, y_marker_graph, labels = c('A', 'B'))
print(fig)
