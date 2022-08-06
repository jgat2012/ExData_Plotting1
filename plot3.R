## Load libraries

library("tidyverse")
library("readxl")
library("dplyr")
## Load data
mydata <- read.delim2("household_power_consumption.txt",sep = ";") %>%
  
  ## Convert variable data types
  mutate(
    Date = parse_date(Date,"%d/%m/%Y"),
    Time = strptime(paste(Date,Time,sep=" "),"%Y-%m-%d %H:%M:%S")
  ) %>%
  
  #Convert the rest of variables to numeric
  mutate_if(is.character,as.numeric)

## Get data to be used for graphs
start_date <-as.Date("2007-02-01")
end_date   <-as.Date("2007-02-02")
subdata <-mydata %>%
  filter(Date >=start_date & Date <=end_date )

## Open devide
png("plot3.png", width = 480,height = 480)

plot.new()

## Plot graph 3
plot(subdata$Time, subdata$Sub_metering_1, type = "l", col="black", lty = 1,xlab = "Datetime", ylab= "Global Active Power (Kilowatts)")
lines(subdata$Time, subdata$Sub_metering_2,col="red")
lines(subdata$Time, subdata$Sub_metering_3,col="blue")
legend("topright", legend = c("sub_metering_1","sub_metering_2","sub_metering_3"), lty=1,col = c("black","red","blue"), cex=0.8)

## Close device
dev.off()
