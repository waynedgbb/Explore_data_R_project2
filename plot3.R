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