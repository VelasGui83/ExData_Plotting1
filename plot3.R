## Adjusting data to be used
data<-read.table("household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE, colClasses = c('character',
                                                                                                               'character', 'numeric','numeric','numeric','numeric',
                                                                                                               'numeric','numeric','numeric')
)
data$Date<-as.Date(data$Date, "%d/%m/%Y")

data<-subset(data, Date>=as.Date("2007-02-01")& Date<=as.Date("2007-02-02"))

dateTime<-paste(data$Date,data$Time)

dateTime<-setNames(dateTime, "DateTime")

data<-data[,!(names(data) %in% c("Date","Time"))]

data<-cbind(dateTime, data)

data$dateTime<-as.POSIXct(dateTime)

#Generating the plot
plot(data$Sub_metering_1~data$dateTime, type="l", ylab = "Energy sub metering", xlab = "")
lines(data$Sub_metering_2~data$dateTime, col= "red")
lines(data$Sub_metering_3~data$dateTime, col= "blue")
legend("topright", col = c("black","red","blue"), lwd=c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##Saving the plot in png format
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()