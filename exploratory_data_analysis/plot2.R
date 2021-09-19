library("data.table")

setwd("~/GitHub/JHU-Data-Science-/exploratory_data_analysis")

#Reads in data from file then subsets data for specified dates
powerDT <- data.table::fread(unzip("household_power_consumption.zip"), na.strings = "?")
powerDT <- mutate(
  powerDT, 
  # Prevent printing in scientific notation 
  Global_active_power = as.numeric(Global_active_power),
  # Making a POSIXct date capable of being filtered and graphed by time of day
  dateTime = as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")
)

# Filter Dates for 2007-02-01 and 2007-02-02
powerDT <- filter(powerDT, Date >= "2007-02-01" & Date <= "2007-02-03")

png("plot2.png", width = 480, height = 480)

## Plot 2
plot(x = powerDT[, dateTime]
     , y = powerDT[, Global_active_power]
     , type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

dev.off()

