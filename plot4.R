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