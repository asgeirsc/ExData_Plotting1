## Script to generate a histogram with frequency of observations during the first
## two days of February 2007, against the global active power (in watts) using the base plotting system

## Use the data table library
library(data.table)

## Load data set
data <- read.table("household_power_consumption.txt", sep = ";" , header = TRUE)

## Convert to date and time and subset to just two dates
data$Date <- as.Date(data$Date, "%d/%m/%Y")
firstDay <- as.Date.character("2007-02-01", "%Y-%m-%d")
lastDay <- as.Date.character("2007-02-02", "%Y-%m-%d")
data <- data[data$Date >= firstDay & data$Date <= lastDay,]

## Plot a histogram, write to a png file
png("plot1.png", width=480, height=480)
plot_data <- as.numeric(data$Global_active_power)
hist(plot_data, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()