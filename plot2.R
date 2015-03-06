#Download file from website, unzip and save it. 
download.file("https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip",destfile="data.zip")
unzip("data.zip", "household_power_consumption.txt")
dd <- read.table("household_power_consumption.txt", sep=";",header=T)
subset1 <- dd[dd$Date=="1/2/2007",]
subset2 <- dd[dd$Date=="2/2/2007",]
subset<- rbind(subset1, subset2)

date<-as.Date(subset[,1], "%d/%m/%Y")
time<-subset[,2]
datetime<-paste(date,time)
time<-strptime(datetime, "%Y-%m-%d %H:%M:%S")

Global_active_power_vect <- as.numeric(as.vector(subset[,3]))

png(filename = "plot2.png", width = 480, height = 480)
plot(time, Global_active_power_vect, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()