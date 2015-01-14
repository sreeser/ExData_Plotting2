#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
#from 1999 to 2008? Use the base plotting system to make a plot answering this question.

library(dplyr)

#load data
NEI <- readRDS("summarySCC_PM25.rds")

#filtering on Baltimore City
baltimore.data<-filter(NEI,fips == "24510")

#get our subset and sum by year
baltimore.year.data<-summarise(group_by(select(baltimore.data,Emissions,year),year),emissions.total=sum(Emissions))

png(filename="plot2.png",width=480,height=480,bg="transparent")
#plot it out
plot(baltimore.year.data$year,baltimore.year.data$emissions.total,ylab="Total Emissions",xlab="Year",main="",type="l")
dev.off()

#as a general trend it looks like its decreasing, but 2005 it almost spiked back up to 1999 levels.