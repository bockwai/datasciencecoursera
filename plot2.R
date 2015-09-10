# Loading of data and required prelim processing
if(!file.exists("exdata-data-household_power_consumption.zip")) {
  tempdata = tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",tempdata)
  datafile = unzip(tempdata)
  unlink(tempdata)
}
powcon = read.table(datafile, header=T, sep=";")
powcon$Date = as.Date(powcon$Date,format="%d/%m/%Y")
powerdata = powcon[(powcon$Date=="2007-02-01")|(powcon$Date=="2007-02-02"),]
powerdata$Global_active_power = as.numeric(as.character(powerdata$Global_active_power))
powerdata$Global_reactive_power = as.numeric(as.character(powerdata$Global_reactive_power))
powerdata$Voltage = as.numeric(as.character(powerdata$Voltage))
powerdata$Sub_metering_1 = as.numeric(as.character(powerdata$Sub_metering_1))
powerdata$Sub_metering_2 = as.numeric(as.character(powerdata$Sub_metering_2))
powerdata$Sub_metering_3 = as.numeric(as.character(powerdata$Sub_metering_3))
powerdata = transform(powerdata,timestamp=as.POSIXct(paste(Date,Time)),"%d/%m/%Y %H:%M:%S")
# function to create plot2
plot2 = function() {
  plot(powerdata$timestamp,powerdata$Global_active_power,type="l",xlab = "",ylab = "Global Active Power (kilowatts)")
  dev.copy(png,file="plot2.png",width=480,height=480)
  dev.off()
  cat("plot2.png is saved in",getwd())
}
plot2()