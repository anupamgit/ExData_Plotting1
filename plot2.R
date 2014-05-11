## DOWNLOAD DATA IF IT DOES NOT EXIST IN CURRENT DIRECTORY

if(!file.exists("household_power_consumption.txt")) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, destfile="household_power_consumption.zip", method="curl")
  unzip("household_power_consumption.zip")
}

## READ DATA

datasub <- read.table("household_power_consumption.txt",header=TRUE,sep=";", na.strings="?",nrows=5)
classes <- sapply(datasub, class)
data <- read.table("household_power_consumption.txt", colClasses=classes, header=TRUE,sep=";", na.strings="?")
## Clean data
data <- data[complete.cases(data),]
## Transform Date and Time
data <- transform(data, Date = as.Date(Date, "%d/%m/%Y")) 
data <- subset(data, Date>="2007-02-01" & Date<="2007-02-02")
data <- transform(data, Time = strptime(paste(Date,Time), "%Y-%m-%d %H:%M:%S"))

## PLOT IN PNG

png(file="plot2.png", width=480, height=480)
par(mfrow=c(1,1))
with(data, plot(Time, Global_active_power, type="l",xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()