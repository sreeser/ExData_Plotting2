# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make 
# a plot answer this question.

library(dplyr)
library(ggplot2)

#load data
NEI <- readRDS("summarySCC_PM25.rds")

#filtering on Baltimore City
baltimore.data<-filter(NEI,fips == "24510")

#get our subset and sum by year
baltimore.year.data<-summarise(group_by(select(baltimore.data,Emissions,type,year),year,type),emissions.total=sum(Emissions))

png(filename="plot3.png",width=480,height=480,bg="transparent")
#plot it out
qplot(year,baltimore.year.data$emissions.total, data=baltimore.year.data,color=baltimore.year.data$type, geom=c("point","smooth"))
dev.off()

# Using the plot, non-road, nonpoint, on-road all have seen decreases. Point is the only one that's
# seen any kind of an increase. 
