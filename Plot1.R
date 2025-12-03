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
png(filename = "plot1.png", width = 480, height = 480)

#histogram of the global active power column 
hist(data$Global_active_power, col='red', xlab='Global Active Power (kilowatts)', main='Global Active Power')

dev.off()

