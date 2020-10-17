#read only the relevant rows
setwd("/Users/ktarkhan/RStat/Datafiles")
# select only two days in February 2007
feb_days <- grep("^1/2/2007|^2/2/2007", readLines("household_power_consumption.txt"))
relevantRows <- length(feb_days)
#read those lines from the dataset
days <- read.table(file="household_power_consumption.txt", sep=";", skip=feb_days[1]-1, nrows=relevantRows, na.string="?")
#set the variable names correctly
names(days) <- c("Date","Time","Global_active_power", "Global_reactive_power","Voltage","Gloabl_intensity",
                 "Sub_metering_1", "Sub_metering_2","Sub_metering_3")
days$Time <- as.POSIXct(paste(days$Date,days$Time), format="%d/%m/%Y %H:%M:%S")  #format the second column as time

days$Date <- as.Date(days$Date, "%d/%m/%Y")  #format the first column as date


png("plot3.png", width=480, height=480) 

with(days, plot(Sub_metering_1~Time, type="l", ylab="Energy sub metering", xlab=""))
with(days, lines(Sub_metering_2~Time, col="red"))
with(days, lines(Sub_metering_3~Time, col="blue"))
legend("topright",lwd=2, col=c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()
