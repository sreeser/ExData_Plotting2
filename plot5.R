# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
library(dplyr)
library(ggplot2)

#load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#filtering on Baltimore City
baltimore.data<-filter(NEI,fips == "24510")

#subset our SCC set for vehicles, and get a vector 
scc.vehicle.data<-unlist(lapply(select(SCC[grep("vehicle",SCC$SCC.Level.Two,ignore.case=TRUE),],SCC),as.character))

#filter nei
nei.vehicle.data<-baltimore.data[baltimore.data$SCC %in% scc.vehicle.data,]

#add it all up
nei.vehicle.year.data<-summarise(group_by(select(nei.vehicle.data,Emissions,year),year),emissions.total=sum(Emissions))

png(filename="plot5.png",width=480,height=480,bg="transparent")
#plot it out
g<-qplot(year,emissions.total, data=nei.vehicle.year.data, geom=c("point","smooth"))
print(g)
dev.off()

#generally they've gone down with a big drop between 2005 and 2008
