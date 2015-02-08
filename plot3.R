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
png(file="plot3.png",bg="transparent")

# create plot for Sub_metering_1
plot(newerdata$DateTime,newerdata$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering",col="black")

# add Sub_metering_2
lines(newerdata$DateTime,newerdata$Sub_metering_2,col="red")

# add Sub_metering_3
lines(newerdata$DateTime,newerdata$Sub_metering_3,col="blue")

# add legend
legend("topright",lty=1,c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"))

dev.off()
