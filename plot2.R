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
n = length(consumption$Global_active_power)

# create plot2: a time series of Global Active Power with customized x-axis ticks and label
png('plot2.png')
with(consumption, plot(1:n, 
                       Global_active_power, type = "l",
                       ylab = "Global Active Power (kilowatts)",
                       xlab = "", xaxt="n"))  # xaxt suppresses the default x-axis labels

# manually add x-axis labels
day1 = match('Thursday',wkday)
day2 = match('Friday',wkday)
axis(side=1, at = c(day1, day2, n+1), labels = c('Thu','Fri','Sat'))
dev.off()
