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

#Start with the prepartion of the Baltimore dataset.
#Select Baltimore, total emissions, use 1999 as ref point for calculation relative increase
#Creat total_Baltimore set with relevant info and colnames. 
NEI_Baltimore <- NEI_Subset[NEI_Subset[,2]=="24510",]
total_emissions_Baltimore <- ddply(NEI_Baltimore, .(year), summarise, sum(Emissions))
year_Baltimore <- as.character(total_emissions_Baltimore[,"year"])
Emission_Baltimore <- as.numeric(total_emissions_Baltimore[,"..1"])
Refpoint_Baltimore <- rep(total_emissions_Baltimore[1,2], 4)
Relative_change_Baltimore <- Emission_Baltimore/Refpoint_Baltimore
Baltimore <-rep("Baltimore", 4)
total_Baltimore<-na.omit(data.frame(Baltimore, year_Baltimore  ,Emission_Baltimore, Relative_change_Baltimore))
colnames(total_Baltimore)<-c("State", "Year", "Emission", "RelativeChange")
   
#Same as for Baltimore
NEI_LosAng <- NEI_Subset[NEI_Subset[,2]=="06037",]
total_emissions_LosAng <- ddply(NEI_LosAng, .(year), summarise, sum(Emissions))
year_LosAng <- as.character(total_emissions_LosAng[,"year"])
Emission_LosAng <- as.numeric(total_emissions_LosAng[,"..1"])
Refpoint_LosAng <- rep(total_emissions_LosAng[1,2], 4)
LA <-rep("Los Angelos", 4)
Relative_change_LA <- Emission_LosAng/Refpoint_LosAng
total_LosAng<-na.omit(data.frame(LA, year_LosAng,Emission_LosAng, Relative_change_LA))
colnames(total_LosAng)<-c("State", "Year", "Emission", "RelativeChange")

#Append total_LosAng and total_baltimore to have a good dataset as input for ggplot
Total<-rbind(total_Baltimore,total_LosAng)
#Plot graph
plot <- ggplot(Total, aes(Year, RelativeChange))
plot+facet_grid(.~State) + geom_bar(stat="identity")+labs(y="Relative change in motor vehicle emissions")+ggtitle("Relative change in motor vehicle related emissions (1999 = 100%)")
dev.copy(png, file = "plot6.png")
dev.off()  