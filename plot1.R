## Initially, only four rows of data are read from the file, so the starting date and time of data collection is found out
## the starting date and time are calculated using the function strptime()
## dif will be the number of minutes from the starting point to 2007-02-01, time 00:00:00
## nlines will be the number of minutes between 2007-02-01, time 00:00:00 to 2007-02-02, time 23:59:00 (inclusive)

colNames <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1",
              "Sub_metering_2", "Sub_metering_3")
initial <- read.table("household_power_consumption.txt", col.names=colNames, na.strings="?", sep=";",
                      comment.char="", skip=1, nrows=4)

initial$Time <- strptime(paste(initial$Date,initial$Time), "%d/%m/%Y %H:%M:%S")
dif <- as.integer((strptime("01/02/2007 00:00:00", "%d/%m/%Y %H:%M:%S") - initial[1,]$Time)*24*60)
nlines <- as.integer((strptime("02/02/2007 24:00:00", "%d/%m/%Y %H:%M:%S") - strptime("01/02/2007 00:00:00", "%d/%m/%Y %H:%M:%S"))*24*60)


## the data  from 2007-02-01, time 00:00:00 to 2007-02-02, time 23:59:00 is read

data <- read.table("household_power_consumption.txt", col.names=colNames, na.strings="?", sep=";",
                   comment.char="", skip=(dif+1), nrows=nlines)

## the required graph is made and put in plot1.png
png(file="plot1.png")
par(cex=0.8)
hist(data[,3], col="red", xlab="Global active power (kilowatts)", main="Global Active Power")
dev.off()
