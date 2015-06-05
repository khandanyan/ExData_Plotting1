library(utils)
library(dplyr)



setwd("C:/Users/U003HXK/Documents/Exploratory Data Analysis//Week1")

if (!file.exists("household_power_consumption.zip")){
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  "household_power_consumption.zip")
} 
data<-read.table(unz("household_power_consumption.zip","household_power_consumption.txt"),
                 header = TRUE,sep = ";",na.strings = "?",stringsAsFactors = FALSE)

data$Date<-as.Date(data$Date,format = "%d/%m/%Y")

data<- data %>% filter(Date>="2007-02-01", Date<="2007-02-02")

data<-data %>% mutate_(DateTime=~paste(Date,Time))

data$DateTime<-strptime(data$DateTime,format = "%F %T")

plot(data$DateTime,data$Sub_metering_1,type = "l",
     ylab = "Energy sub metering",xlab = "",col="black")
lines(data$DateTime,data$Sub_metering_2,col = "red")
lines(data$DateTime,data$Sub_metering_3,col = "blue")
legend("topright",lwd=1,col=c("black","red","blue"),text.font=1,
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.copy(png,file="plot3.png",width=480,height=480)

dev.off()