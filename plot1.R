rm(list = ls())
setwd('C:/Users/yanqi/Documents/Coursera courses/JHU Data Science 4 - Exploratory Data Analysis/wk1/project1/ExData_Plotting1/')
fileinput = 'C:/Users/yanqi/Documents/Coursera courses/JHU Data Science 4 - Exploratory Data Analysis/wk1/project1/household_power_consumption.txt'

# read in file, convert Date and Time columns to the right format 
df <- read.table(file = fileinput, sep = ";", header = TRUE, na.strings = "?")
df$Date = as.Date(df$Date, format = "%d/%m/%Y") 
df$Time = strptime(df$Time, format = "%H:%M:%S")

# filter the data down to just the subset we need for the analysis
consumption = subset(df, Date == "2007-02-01" | Date == "2007-02-02")

# create plot1: histogram of Global_active_power 
png("plot1.png")
with(consumption, hist(Global_active_power, col = "red", 
                       xlab = "Global Active Power (kilowatts)",
                       main = "Global Active Power"))
dev.off()
