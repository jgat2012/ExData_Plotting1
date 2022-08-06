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
png("plot1.png", width = 480,height = 480)

plot.new()

## Plot graph 1
hist(subdata$Global_active_power, breaks=20.0, col = "red",main = "Global Active Power",xlab = "Global Active Power (Kilowatts)")

## Close device
dev.off()
