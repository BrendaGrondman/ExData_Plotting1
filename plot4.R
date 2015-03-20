#Load required libraries and data
library(ggplot2)
library(plyr)
setwd("C:/Users/Brenda/Documents/Coursera/ProjectDataExploration")
NEI <- readRDS("summarySCC_PM25.rds") 
SCC <- readRDS("Source_Classification_Code.rds")

#I chose to look for every possible item that chould have coal in it, 
#and the code below does that.
#Then I select those records from SCc and NEI
Rows_Coal<-grep("[cC][oO][aA][lL ]",(SCC$Short.Name));
SCCfinal<- SCC[Rows_Coal,]
NEI_Subset<-merge(NEI,SCCfinal);
#The total emission for USA is calculated
total_emissions <- ddply(NEI_Subset, .(year), summarise, sum(Emissions))
#Data preparation for graph is done:
colnames(total_emissions) <- c("Year", "Emission")
Year <- as.character(total_emissions[,1])
Emission <- as.numeric(total_emissions[,2])
total<-data.frame(Year, Emission)
ggplot(data=total, aes(x=Year, y=Emission)) + geom_bar(stat="identity")+ggtitle("Total emissions from coal combustion-related sources in USA")
dev.copy(png, file = "plot4.png")
dev.off()  