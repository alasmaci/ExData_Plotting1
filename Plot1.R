## plot_1

setwd("C:/Documents and Settings/Al/My Documents/R/DataSci_Courses/Explore/Project_1")
getwd()

require(data.table)

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
str(power)
hist(power$Global_active_power,col="RED",xlab = "Global Active Power, kilowatts",
     main ="Global Active Power")

dev.copy(png, file = "Plot1.png")
dev.off()
