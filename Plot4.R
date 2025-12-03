#load data

#use read.table with sep=';' (values separated by ;) and head = TRUE (the first row is the column names)

data <- read.table('/Users/austenjack/Desktop/Coursera/Exploratory_data_analysis/Project_1/household_power_consumption.txt', sep=';', head=TRUE )


#turn the date and time into a datetime object

datetime_str <- paste(data$Date, data$Time)

#just adding a new column with the full date and time
data$DateTime <- as.POSIXct(datetime_str, format = "%d/%m/%Y %H:%M:%S")



#subset the data with just the dates of interest


start_date <- as.POSIXct("2007-02-01 00:00:00")
end_date   <- as.POSIXct("2007-02-02 23:59:59")

data <- data[data$DateTime >= start_date & data$DateTime <= end_date,]





#Need to make the Global_active_power column numeric
data$Global_active_power <- as.numeric(data$Global_active_power)

#open png graphic device
png(filename = "plot4.png", width = 480, height = 480)


#make 4 plots in a 2x2 window with plots 2 and 3 in the left column
#the other two plots are line graphs of voltage and reactive_power over time
par(mfrow=c(2, 2))

#Top left plot

#The x-axis ticks should be titled with the day of the week
ticks <- seq(from = as.POSIXct("2007-02-01 00:00:00"), to   = as.POSIXct("2007-02-02 00:00:00") + 86400,by   = "1 day")

#line graph without x title
plot(x = data$DateTime, y = data$Global_active_power, type = 'l', xaxt = 'n', ylab = 'Global Active Power (kilowatts)', xlab = '')

#add weekday names to the x-ticks
axis(1, at = ticks, labels = strftime(ticks, "%a"))


#top right plot

plot(data$DateTime, data$Voltage, type='l', ylab='Voltage', xlab='datetime', xaxt='n')
axis(1, at = ticks, labels = strftime(ticks, "%a"))


#bottom left plot

ticks <- seq(from = as.POSIXct("2007-02-01 00:00:00"), to   = as.POSIXct("2007-02-02 00:00:00") + 86400,by   = "1 day")
#make an empty plot then add the three lines

plot(data$DateTime, data$Sub_metering_1, type = 'n',xlab='', xaxt='n', ylab='Energy sub metering')

lines(data$DateTime, data$Sub_metering_1, type='l', col='black')
lines(data$DateTime, data$Sub_metering_2, type='l', col='red')
lines(data$DateTime, data$Sub_metering_3, type='l', col='blue')

#add weekday names to the x-ticks
axis(1, at = ticks, labels = strftime(ticks, "%a"))


#add a legend of the three lines in the top right of the graph
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col = c("black", "red", "blue"), lty = 1, cex = 0.4)




#bottom right plot
plot(data$DateTime, data$Global_reactive_power, type='l', xlab='datetime', xaxt='n')
axis(1, at = ticks, labels = strftime(ticks, "%a"))


dev.off()




