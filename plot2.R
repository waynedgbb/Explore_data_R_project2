#Q2 Have total emissions from PM2.5 decreased in the Baltimore City, 
#Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

library(ggplot2)
# read file 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

png("plot2.png", width=840, height=480)
targetCity <- NEI[NEI$fips =="24510",]
totalemission_target <- with(targetCity, tapply(Emissions,year,sum))
totalemission_target <- with(targetCity, sapply(split(Emissions,year),sum,na.rm = T))
table(totalemission_target)

plot(names(totalemission_target),totalemission_target,xlab = "Year",main="Total Emissions of PM2.5", col="black",type="l")
points(names(totalemission_target),totalemission_target,xlab = "Year",main="Total Emissions of PM2.5", col=names(totalemission_target),lwd=4)
legend("topright",legend=names(totalemission_target),col=names(totalemission_target), pch = 1,lwd=4)

dev.off()