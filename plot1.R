#plot 1
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

par(mfrow=c(1,1))
png("plot1.png",height=480,width=480)
#plot
hist(data$Global_active_power,col="red",main="Global active power",xlab="Global active power",ylab="frequency")
rug(data$Global_active_power)
#print plot
dev.off()
