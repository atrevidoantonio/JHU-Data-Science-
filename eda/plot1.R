library("data.table")

setwd("~/GitHub/JHU-Data-Science-/exploratory_data_analysis")

#Reads in data from file then subsets data for specified dates
powerDT <- data.table::fread(unzip("household_power_consumption.zip"), na.strings = "?")
powerDT <- mutate(
  powerDT, 
  # Prevents histogram from printing in scientific notation
  Global_active_power = as.numeric(Global_active_power),
  # Change Date Column to Date Type
  Date = lubridate::dmy(Date)
)
# Filter Dates for 2007-02-01 and 2007-02-02
powerDT <- filter(powerDT, Date >= "2007-02-01" & Date <= "2007-02-02")

png("plot1.png", width=480, height=480)

## Plot 1
hist(powerDT[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()
