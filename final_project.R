




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

#Q3 Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

library(ggplot2)
# read file 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
png("plot3.png", width=840, height=480)

targetCity$type <- as.factor(targetCity$type)
g <- ggplot(targetCity,aes(year,Emissions))+stat_summary(fun.y = sum,geom = "bar")
g<-g+facet_grid(.~type)
print(g)
dev.off()
#Q4 Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
# which we need to find the short.names include coal and SCC.level.one include combustion 

library(ggplot2)
# read file 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
png("plot4.png", width=840, height=480)
q4_target <- SCC[grepl("[Cc]oal",SCC$Short.Name) & grepl("[Cc]ombustion",SCC$SCC.Level.One),]
l <- unique(q4_target$SCC)
Q4_target <- NEI[NEI$SCC %in% q4_target$SCC,]
g <- ggplot(Q4_target,aes(year,Emissions))+stat_summary(fun.y = sum,geom = "bar",aes(fill=year))+labs(title =" Coal Emissions", x = "Year", y = "Emissions")+theme(legend.position = "bottom")
g
print(g)
dev.off()
#Q5 How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
#since the motor vehicle in scc is too small we use On-road directly

library(ggplot2)
# read file 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
png("plot5.png", width=840, height=480)
targetCity <- NEI[NEI$fips =="24510",]
q5_target <- SCC[grepl("[mM]otor [Vv]ehicle",SCC$Short.Name),]
# dont use NEI but use targetcity created in Question 2
Q5_target <- targetCity[targetCity$type =="ON-ROAD",]
g <- ggplot(Q5_target,aes(year,Emissions))+stat_summary(fun.y = sum,geom = "bar",aes(fill=year))+ggtitle('Total Emissions of Motor Vehicle Sources Baltimore City, Maryland')
g
print(g)
dev.off()
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









