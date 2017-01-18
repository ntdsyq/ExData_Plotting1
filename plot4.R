rm(list = ls())
setwd('C:/Users/yanqi/Documents/Coursera courses/JHU Data Science 4 - Exploratory Data Analysis/wk1/project1/ExData_Plotting1/')
fileinput = 'C:/Users/yanqi/Documents/Coursera courses/JHU Data Science 4 - Exploratory Data Analysis/wk1/project1/household_power_consumption.txt'

# read in file, convert Date and Time columns to the right format 
df <- read.table(file = fileinput, sep = ";", header = TRUE, na.strings = "?")
df$Date = as.Date(df$Date, format = "%d/%m/%Y") 
df$Time = strptime(df$Time, format = "%H:%M:%S")

# filter the data down to just the subset we need for the analysis
consumption = subset(df, Date == "2007-02-01" | Date == "2007-02-02")
wkday = weekdays(consumption$Date)
n = dim(consumption)[1]
day1 = match('Thursday',wkday)  # first occurrence of Thursday
day2 = match('Friday',wkday)    # first occurrence of Friday

# setup a 2 by 2 plotting area
png("plot4.png")
par(mfrow = c(2,2))

# create subplot1
with(consumption, plot(1:n, 
                       Global_active_power, type = "l",
                       ylab = "Global Active Power (kilowatts)",
                       xlab = "", xaxt="n"))
axis(side=1, at = c(day1, day2, n+1), labels = c('Thu','Fri','Sat'))

# create subplot2 
with(consumption, plot(1:n, 
                       Voltage, type = "l", 
                       xlab = "datetime", xaxt="n"))
axis(side=1, at = c(day1, day2, n+1), labels = c('Thu','Fri','Sat'))

# create subplot3
with(consumption, plot(1:n, 
                       Sub_metering_1, type = "l", 
                       ylab = "Energy sub metering",
                       xlab = "", xaxt="n"))
with(consumption, lines(1:n, Sub_metering_2, col = "red"))
with(consumption, lines(1:n, Sub_metering_3, col = "blue"))
axis(side=1, at = c(day1, day2, n+1), labels = c('Thu','Fri','Sat'))
legend("topright", bty = "n", lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# create subplot4: Global_reactive_power 
with(consumption, plot(1:n, 
                       Global_reactive_power, type = "l", 
                       xlab = "datetime", xaxt="n"))
axis(side=1, at = c(day1, day2, n+1), labels = c('Thu','Fri','Sat'))
dev.off()