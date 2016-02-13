#6 Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, 
#California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

library(ggplot2)
# read file 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
png("plot6.png", width=840, height=480)

targetCity <- NEI[which(NEI$type =="ON-ROAD" & (NEI$fips =="24510" | NEI$fips =="06037")),]
g <- ggplot(targetCity,aes(year,Emissions))+stat_summary(fun.y = sum,geom = "bar",aes(fill=year))+ggtitle('Total Emissions of Motor Vehicle Sources\nLos Angeles County, California vs. Baltimore City, Maryland')
g<- g+facet_grid(.~fips)

print(g)
dev.off()
