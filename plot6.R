# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
# vehicle sources in Los Angeles County, California (fips == “06037”). Which city has seen 
# greater changes over time in motor vehicle emissions?

library(dplyr)
library(ggplot2)

#load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

city<-as.data.frame(matrix(c("24510", "06037","Baltimore City","Los Angeles County"), ncol = 2))
names(city)[1]="fips"
names(city)[2]="location"

#filtering on Baltimore City and L.A.
city.data<-filter(NEI,fips %in% c("24510","06037"))

#subset our SCC set for vehicles, and get a vector SCC[grep(" [vV]ehicle ",SCC$SCC.Level.Two),"SCC.Level.Two"]
scc.vehicle.data<-unlist(lapply(select(SCC[grep("vehicle",SCC$Short.Name,ignore.case=TRUE),],SCC),as.character))

#filter nei
nei.vehicle.data<-NEI[NEI$SCC %in% scc.vehicle.data,]

nei.vehicle.data<-merge(nei.vehicle.data,city,by="fips")

#add it all up
nei.vehicle.year.data<-summarise(group_by(select(nei.vehicle.data,Emissions,year,location),location,year),emissions.total=sum(Emissions))

png(filename="plot6.png",width=780,height=480,bg="transparent")
#plot it out
g<-qplot(data=nei.vehicle.year.data,year,emissions.total,color=location,geom=c("point","smooth"))
print(g)
dev.off()

#LA is way higher than BC, but LA has seen a larger reduction in total emissions