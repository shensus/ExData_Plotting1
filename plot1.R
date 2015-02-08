# read entire file
data <- read.table("household_power_consumption.txt",sep=";",header=TRUE,na.strings="?")

# read the Date column as a date
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# subset the data for the two desired dates and store as newdata
newdata <- data[data$Date == as.Date("2007-02-01") | data$Date == as.Date("2007-02-02"),]

# create a png file
png(file="plot1.png",bg="transparent")

# create a histogram
hist(newdata$Global_active_power,col="red",border="black",main="Global Active Power",
     xlab="Global Active Power (kilowatts)",ylab="Frequency",xlim=c(0,8),axes=FALSE)

# x-axis label
axis(1,at=c(0,2,4,6))

# y-axis label
axis(2,at=c(0,200,400,600,800,1000,1200))

dev.off()