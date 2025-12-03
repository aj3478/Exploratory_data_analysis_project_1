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
png(filename = "plot2.png", width = 480, height = 480)

#Now make a line graph of Global active power on the y-axis, and datetime on the x-axis

#The x-axis ticks should be titled with the day of the week
ticks <- seq(from = as.POSIXct("2007-02-01 00:00:00"), to   = as.POSIXct("2007-02-02 00:00:00") + 86400,by   = "1 day")

#line graph without x title
plot(x = data$DateTime, y = data$Global_active_power, type = 'l', xaxt = 'n', ylab = 'Global Active Power (kilowatts)', xlab = '')

#add weekday names to the x-ticks
axis(1, at = ticks, labels = strftime(ticks, "%a"))

dev.off()



