
#test the size of the dataset in memory
#simulate a 1000 rows dataset with the same modes off variables
date <- today()
v2 <- Sys.time()
test <- data.frame("date"=rep(date,1000), "time"=rep(v2, 1000), "v3"=rnorm(1000),"v4"=rnorm(1000),
                   "v5"=rnorm(1000),"v6"=rnorm(1000),"v7"=rnorm(1000),"v8"=rnorm(1000),"v9"=rnorm(1000))

rowsize <- object.size(test) 
# the actual data set is just over 2 mln observations
dfsize <- 2000*rowsize
rm(test)  # clean up the test dataframe

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
days$Date <- as.Date(days$Date, "%d/%m/%Y")  #format the first column as date
days$Time <- strptime(days$Time, "%H:%M:%S")  #format the first column as time


png("plot1.png", width=480, height=480) 

hist(days$Global_active_power, col="red", xlab="Global Active Power (kilowatts)",main="Global Active Power")



dev.off()