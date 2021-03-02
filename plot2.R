## Script to generate a line diagram of global active power (in kilowatts) as a time series with the data from
## two days of February 2007 using the base plotting system

## Use the data table library
library(data.table)

## Load data set
data <- read.table("household_power_consumption.txt", sep = ";" , header = TRUE)

## Convert to date and time and subset to just two dates
data$Date <- as.Date(data$Date, "%d/%m/%Y")
firstDay <- as.Date.character("2007-02-01", "%Y-%m-%d")
lastDay <- as.Date.character("2007-02-02", "%Y-%m-%d")
data <- data[data$Date >= firstDay & data$Date <= lastDay,]

## Join date and time in one new field
data[,10] <- as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")
names(data)[10] <- "DateTime"

## Plot a line chart, write to a png file
png("plot2.png", width=480, height=480)
plot(x = data$DateTime, y = data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()