#Load required library and data.
library(plyr)
setwd("C:/Users/Brenda/Documents/Coursera/ProjectDataExploration")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Calculate total emission in USA, and add colnames
total_emission <- ddply(NEI, .(year), summarise, sum(Emissions))
colnames(total_emission) <- c("year", "TotalPM")

#Make plot and save it 
plot<-barplot(total_emission $TotalPM, names = total_emission $year,  ylab= "Total PM2.5 emissions", pch = 19, xlab = "Year", main = "Total PM2.5 Emission per year")
dev.copy(png, file = "plot1.png")
dev.off()