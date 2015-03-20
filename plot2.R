#load required package and data 
library(plyr)
setwd("C:/Users/Brenda/Documents/Coursera/ProjectDataExploration")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Select Baltimore and calculate total emission in Baltimore, and add colnames
NEI_Baltimore <- NEI[NEI[,1]=="24510",]
total_emission_Baltimore <- ddply(NEI_Baltimore, .(year), summarise, sum(Emissions))
colnames(total_emission_Baltimore) <- c("year", "TotalPM")
#Make and save graph
barplot(total_emission_Baltimore$TotalPM, names =total_emission_Baltimore$year, ylab= "Total PM2.5 emissions Baltimore City, Maryland", pch = 19, xlab = "Year", main = "Total PM2.5 Emission per year, Baltimore City")
dev.copy(png, file = "plot2.png")
dev.off()