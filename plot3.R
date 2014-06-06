#!/usr/local/bin/rscript

# define the data types (leave date and time as character for now and ignore columns we don't need)
columnTypes <- c("character","character","NULL","NULL","NULL","NULL","numeric","numeric","numeric")

# read data file (assume file is in working directory)
data <- read.table('household_power_consumption.txt', sep=';', header=TRUE, na.strings="?", colClasses=columnTypes)

# limit data to 1st and 2nd of Feburary, 2007
timeframe <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]

# add DateTime column composed of Date and Time columns
timeframe$DateTime <- as.POSIXct(paste(timeframe$Date, timeframe$Time), format="%d/%m/%Y %H:%M:%S")

# open png file
dev <- png(filename='plot3.png')

# render line graph frame, use sub_metering_1 to set scale
plot( timeframe$Sub_metering_1 ~ timeframe$DateTime, 
  type="n", 
  ylab="Energy sub metering", 
  xlab="" )

# render a line for each sub metering
lines( timeframe$Sub_metering_1 ~ timeframe$DateTime, col="black" )
lines( timeframe$Sub_metering_2 ~ timeframe$DateTime, col="red" )
lines( timeframe$Sub_metering_3 ~ timeframe$DateTime, col="blue" )

# render legend
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c("black","red","blue"))

# save file
dev.off()
