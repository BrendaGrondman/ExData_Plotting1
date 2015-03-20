#load required package and data 
library(plyr)
setwd("C:/Users/Brenda/Documents/Coursera/ProjectDataExploration")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Select Baltimore and calculate total emission per type in Baltimore, and add colnames
NEI_Baltimore <- NEI[NEI[,1]=="24510",]
Emission_per_Type_Baltimore <- ddply(NEI_Baltimore, .(year, type), summarise, sum(Emissions))
colnames(Emission_per_Type_Baltimore) <- c("year", "Type", "Emission")
#Make and save graph
qplot(year,Emission, data=Emission_per_Type_Baltimore, facets = . ~ Type, geom  =  c("point",  "smooth"), method = "lm")
dev.copy(png, file = "plot3.png")
dev.off()  