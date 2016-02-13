library(ggplot2)
# read file 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
#make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
png("plot1.png", width=840, height=480)
class(NEI)
str(NEI)
table(NEI$Pollutant)
table(NEI$year)
#par(mrow=c(1,4),mar = c(4, 4, 2, 1))
NEI$year <- as.factor(as.character(NEI$year))
totalemission <- with(NEI, tapply(Emissions,year,sum))
totalemission <- with(NEI, sapply(split(Emissions,year),sum,na.rm = T))
table(totalemission)

plot(names(totalemission),totalemission,xlab = "Year",main="Total Emissions of PM2.5", col="black",type="l")
points(names(totalemission),totalemission,xlab = "Year",main="Total Emissions of PM2.5", col=names(totalemission),lwd=4)
legend("topright",legend=names(totalemission),col=names(totalemission), pch = 1,lwd=4)

dev.off()