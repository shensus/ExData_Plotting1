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
png(file="plot2.png",bg="transparent")

# plot line
plot(newerdata$DateTime,newerdata$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")

dev.off()
