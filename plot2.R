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
plot(data$Global_active_power~data$dateTime, type = "l", xlab="", ylab="Global Active Power (kilowatts)")

#Saving the plot in png format
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()