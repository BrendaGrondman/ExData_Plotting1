#Load required libraries and data
library(ggplot2)
library(plyr)
setwd("C:/Users/Brenda/Documents/Coursera/ProjectDataExploration")
NEI <- readRDS("summarySCC_PM25.rds") 
SCC <- readRDS("Source_Classification_Code.rds")


#Select records with Mobile and Vehicle in the column EI.Sector. 
Rows_Vehicle<-grep("([Mm][Oo][Bb][Ii][Ll][Ee](.*)[Vv][eE][hH][Ii][Cc][Ll][eE])",(SCC$EI.Sector));
#Select the rigth records from SCC and NEI 
SCCfinal<- SCC[Rows_Vehicle,]
NEI_Subset<-merge(NEI,SCCfinal);

#Select Baltimore and summarise to get total emissions. 
#Prepare data total_Baltimore for generation ggplot
NEI_Baltimore <- NEI_Subset[NEI_Subset[,2]=="24510",]
total_emissions_Baltimore <- ddply(NEI_Baltimore, .(year), summarise, sum(Emissions))
colnames(total_emissions_Baltimore) <- c("year", "Emission")
year_Baltimore <- as.character(total_emissions_Baltimore[,"year"])
Emission_Baltimore <- as.numeric(total_emissions_Baltimore[,"Emission"])
total_Baltimore<-na.omit(data.frame(year_Baltimore,Emission_Baltimore))

#creat ggplot
ggplot(data=total_Baltimore, aes(x=year_Baltimore, y=Emission_Baltimore)) + geom_bar(stat="identity")+ggtitle("Total emissions from motor vehicle related sources in Baltimore City")
dev.copy(png, file = "plot5.png")
dev.off()  