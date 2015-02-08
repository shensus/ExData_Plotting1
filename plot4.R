# read entire file
data <- read.table("household_power_consumption.txt",sep=";",header=TRUE,na.strings="?")

# read the Date column as a date
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# subset the data for the two desired dates and store as newdata
newdata <- data[data$Date == as.Date("2007-02-01") | data$Date == as.Date("2007-02-02"),]

# create a new column, DateTime, that's the Date and Time columns concatenated
newerdata <-transform(newdata,DateTime=paste(newdata$Date,newdata$Time))

# convert DateTime to date and time format
newerdata$DateTime <- as.character(newerdata$DateTime)
newerdata$DateTime <- as.POSIXct(newerdata$DateTime, format="%Y-%m-%d %H:%M:%S")

# create a png file
png(file="plot4.png",bg="transparent")

# create 2x2 plots, filling in by row
par(mfrow=c(2,2))

# upper left plot
plot(newerdata$DateTime,newerdata$Global_active_power,type="l",xlab="",ylab="Global Active Power")

# upper right plot
plot(newerdata$DateTime,newerdata$Voltage,type="l",xlab="datetime",ylab="Voltage")

# lower left plot
plot(newerdata$DateTime,newerdata$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering",col="black")
lines(newerdata$DateTime,newerdata$Sub_metering_2,col="red")
lines(newerdata$DateTime,newerdata$Sub_metering_3,col="blue")
legend("topright",lty=1,c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"))

# lower right plot
plot(newerdata$DateTime,newerdata$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")

dev.off()