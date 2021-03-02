## Script to generate a png file of four diagrams based on energy conumption data two days in February 2007
## 
## Top left:      Global active power as time series
## Top right:     Voltage as time series
## Bottom left:   Energy sub metering as time series
## Bottom right:  Global reactive power

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

## Open the png device
png("plot4.png", width=480, height=480)
layout(matrix(c(1,2,3,4), 2, 2, byrow = TRUE))

## Plot 1:
plot(x = data$DateTime, y = data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

## Plot 2:
plot(x = data$DateTime, y = data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

## Plot 3:
plot(x = data$DateTime, y = data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(x = data$DateTime, y = data$Sub_metering_2, type = "l", col = "red")
lines(x = data$DateTime, y = data$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

## Plot 4:
plot(x = data$DateTime, y = data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

## Close the png device
dev.off()