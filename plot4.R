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
Sub_metering_1 <- as.numeric(as.vector(subset[,7]))
Sub_metering_2 <- as.numeric(as.vector(subset[,8]))
Sub_metering_3 <- as.numeric(as.vector(subset[,9]))
Voltage <- as.numeric(as.vector(subset[,5]))
Global_reactive_power <- as.numeric(as.vector(subset[,4]))
datetime<-time
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
plot(time, Global_active_power_vect, type="l", ylab="Global Active Power", xlab="")
plot(time, Voltage, type="l", ylab="Voltage", xlab="datetime")
plot(time, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(time, Sub_metering_2, col="red")
lines(time, Sub_metering_3, col="blue")
legend("topright", lty=c(1,1), col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") , bty = "n")
plot(time, Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
dev.off()