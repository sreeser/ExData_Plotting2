# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

library(dplyr)

#load data
NEI <- readRDS("summarySCC_PM25.rds")

#get our subset and sum by year
year.data<-summarise(group_by(select(NEI,Emissions,year),year),emissions.total=sum(Emissions))

png(filename="plot1.png",width=480,height=480,bg="transparent")
#plot it out
plot(year.data$year,year.data$emissions.total,ylab="Total Emissions",xlab="Year",main="",type="l")
dev.off()
#answer is yes