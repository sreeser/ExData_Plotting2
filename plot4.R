# Across the United States, how have emissions from coal combustion-related sources changed 
# from 1999–2008?

library(dplyr)
library(ggplot2)

#load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subset our SCC set for coal sectors, and get a vector
scc.coal.data<-unlist(lapply(select(SCC[grep("Coal$",SCC$EI.Sector),],SCC),as.character))

#filter nei
nei.coal.data<-NEI[NEI$SCC %in% scc.coal.data,]

#add it all up
nei.coal.year.data<-summarise(group_by(select(nei.coal.data,Emissions,year),year),emissions.total=sum(Emissions))

png(filename="plot4.png",width=480,height=480,bg="transparent")
#plot it out
g<-qplot(year,emissions.total, data=nei.coal.year.data, geom=c("point","smooth"))
print(g)
dev.off()

#generally they've gone down with a big drop between 2005 and 2008