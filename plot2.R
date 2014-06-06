#!/usr/local/bin/rscript

# define the data types (leave date and time as character for now and ignore columns we don't need)
columnTypes <- c("character","character","numeric","NULL","NULL","NULL","NULL","NULL","NULL")

# read data file (assume file is in working directory)
data <- read.table('household_power_consumption.txt', sep=';', header=TRUE, na.strings="?", colClasses=columnTypes)

# limit data to 1st and 2nd of Feburary, 2007
timeframe <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]

# add DateTime column composed of Date and Time columns
timeframe$DateTime <- as.POSIXct(paste(timeframe$Date, timeframe$Time), format="%d/%m/%Y %H:%M:%S")

# open png file
dev <- png(filename='plot2.png')

# render line graph
plot( timeframe$DateTime, timeframe$Global_active_power, 
  type="l", 
  ylab="Global Active Power (kilowatts)", 
  xlab="" )

# save file
dev.off()
