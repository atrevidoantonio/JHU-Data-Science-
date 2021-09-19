library("data.table")

setwd("~/GitHub/JHU-Data-Science/exploratory_data_analysis")

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

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

# Plot 1
plot(powerDT[, dateTime], powerDT[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

# Plot 2
plot(powerDT[, dateTime],powerDT[, Voltage], type="l", xlab="datetime", ylab="Voltage")

# Plot 3
plot(powerDT[, dateTime], powerDT[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(powerDT[, dateTime], powerDT[, Sub_metering_2], col="red")
lines(powerDT[, dateTime], powerDT[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

# Plot 4
plot(powerDT[, dateTime], powerDT[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
