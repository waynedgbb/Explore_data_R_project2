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