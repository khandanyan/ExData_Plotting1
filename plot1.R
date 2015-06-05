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

hist(data$Global_active_power,col = "red",main="Global Active Power",
     xlab = "Global Active Power (kilowatts)")

dev.copy(png,file="plot1.png",width=480,height=480)
dev.off()