#plot 4
setwd()
url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destination="data.zip"
##memory usage estimate
ncols=9
nrows=2075259
nbytes=ncols*nrows*8
#memory usage estimate in MB
memory=nbytes/(2^20)
if(memory > 1000){
  return(0)
}
zipfile=download.file(url,destination,method="curl")
unzip("data.zip")
file=read.table("household_power_consumption.txt",header=TRUE,sep=";",dec=".",na.strings="?")
#subset the data
data<-subset(file,file$Date=="1/2/2007" | file$Date=="2/2/2007")
data<-na.omit(data)

library(lubridate)
data$Date<-as.Date(data$Date,format="%d/%m/%Y")
data$Time<-strptime(data$Time,format="%H:%M:%S")
year(data$Time)<-year(data$Date)
month(data$Time)<-month(data$Date)
day(data$Time)<-day(data$Date)

png("plot4.png",height=480,width=480)
#plot 4
par(mfrow=c(2,2),mar=c(4,4,1,1))
#1,1
plot(data$Time,data$Global_active_power,xlab="",ylab="Global active power(kilowatts)",type="l")
#1,2
plot(data$Time,data$Voltage,xlab="datetime",ylab="Voltage",type="l")
#2,1
plot(x=data$Time,y=data$Sub_metering_1,xlab="",ylab="Energy sub metering",type="l",col="black")
lines(x=data$Time,y=data$Sub_metering_2,col="red")
lines(x=data$Time,y=data$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1,bty="n")
#2,2
plot(data$Time,data$Global_reactive_power,xlab="datetime",ylab="Voltage",type="l")
dev.off()
