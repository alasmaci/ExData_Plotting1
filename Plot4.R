## plot_4

setwd("C:/Documents and Settings/Al/My Documents/R/DataSci_Courses/Explore/Project_1")
getwd()

require(data.table)

###  Skip down to line 37 if data frame "power" is in Global Environment (2880 obs, 10 variables)

# download dataset (zipped)
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              "power.zip")
# see list of files in zipped folder
unzip("power.zip",list=TRUE)
# only 1 file, so unzip it
unzip("power.zip")
#look at structure of file
look <- read.table("household_power_consumption.txt",header=TRUE,sep=";",nrow=3)
head(look)
str(look)

# Dataset based on a one-minute sampling rate = 1440 readings/day
# reading from row 50000 to  row 70000 should cover the required range
# read portion of file containing required dates  
pr <-fread("household_power_consumption.txt" ,header = FALSE ,sep = ";",
           stringsAsFactors=FALSE, skip = 50000, nrows = 20000) 

setNames(pr,names(look))
str(pr)
#select dates 2007-02-01 and 2007-02-02
pwr <- pr[which(pr$Date == "1/2/2007" | pr$Date == "2/2/2007"),]

# write file and read back in to change character classews to numeric
write.table(pwr, file = "pwr.txt", sep = ",", col.names = colnames(pwr))
power <- read.table("pwr.txt",header=TRUE,sep=",")
power <- transform(power, dtime = paste(power[,1], power[,2]))

# send plot to file instead of screen
png(file = "Plot4.png",width = 480, height = 480, units = "px")

par(mfrow = c(2, 2), mar=c(4,4,2,1), oma = c(0,0,2,0))

# plot (1,1)
with(power,{
  plot(dtime,Global_active_power, pch=20, xaxt = "n",ylab = "Global Active Power")
  lines(dtime,Global_active_power)
  axis(side=1, at =c(0,1440,2880), labels=c("Thu","Fri","Sat"))
})

# plot (1,2)
with(power,{
  plot(dtime,Voltage, pch=20, xaxt = "n",ylab = "Voltage",xlab="datetime")
  lines(dtime,Voltage)
  axis(side=1, at =c(0,1440,2880), labels=c("Thu","Fri","Sat"))
})

# plot (2,1)
with(power,{
  plot(dtime,Sub_metering_1, ylim=c(-1,38),pch=20, xaxt = "n",ylab = "Energy sub metering")
  lines(dtime,Sub_metering_1)
  lines(dtime,Sub_metering_2,col="RED")
  lines(dtime,Sub_metering_3,col="BLUE")
  axis(side=1, at =c(0,1440,2880), labels=c("Thu","Fri","Sat"))
  legend("topright",lty=1,col=c("black","red","blue"),
         legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n")
})

# plot (2,2)
with(power,{
  plot(dtime,Global_reactive_power, pch=20, xaxt = "n",ylab = "Global_reactive_power",
       xlab="datetime")
  lines(dtime,Global_reactive_power,)
  axis(side=1, at =c(0,1440,2880), labels=c("Thu","Fri","Sat"))
})

dev.off()
par(mfrow = c(1, 1)) # reset windows plot device

