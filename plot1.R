#!/usr/local/bin/rscript

# define the data types (leave date as character and ignore columns we don't need)
columnTypes <- c("character","NULL","numeric","NULL","NULL","NULL","NULL","NULL","NULL")

# read data file (assume file is in working directory)
data <- read.table('household_power_consumption.txt', sep=';', header=TRUE, na.strings="?", colClasses=columnTypes)

# limit data to 1st and 2nd of Feburary, 2007
timeframe <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]

# open png file
dev <- png(filename='plot1.png')

# render histogram
hist(timeframe$Global_active_power, 
  col="red", 
  main = "Global Active Power", 
  xlab="Global Active Power (kilowatts)")

# save file
dev.off()
