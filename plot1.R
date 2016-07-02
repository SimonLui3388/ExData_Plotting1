plot1<-function ()
{
  
  #process
  consumption_zipfile<-tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", consumption_zipfile)
  consumptionfile<-unzip(consumption_zipfile)
  unlink(consumption_zipfile)
  
  consumption_data<-read.table(consumptionfile, header = TRUE, sep = ";", na.strings = "?")
  consumption_data$Date<-as.Date(consumption_data$Date, format="%d/%m/%Y")
  
  selected_data<-consumption_data[(consumption_data$Date=="2007-02-01" | (consumption_data$Date =="2007-02-02")),]
  
  selected_data$Global_active_power<-as.numeric(as.character(selected_data$Global_active_power))
  selected_data$Global_reactive_power<-as.numeric(as.character(selected_data$Global_reactive_power))
  selected_data$Voltage<-as.numeric(as.character(selected_data$Voltage))
  
  selected_data$Sub_metering_1<-as.numeric(as.character(selected_data$Sub_metering_1))
  selected_data$Sub_metering_2<-as.numeric(as.character(selected_data$Sub_metering_2))
  selected_data$Sub_metering_3<-as.numeric(as.character(selected_data$Sub_metering_3))
  
  
  #plot1
  selected_data$TimeStamp<-paste(selected_data$Date, selected_data$Time)  
  hist(selected_data$Global_active_power,col="red",main="Global Active power", xlab = "Global Active Power (kilowatts)")
  dev.copy(png,file="plot1.png",width=480,height=480)
  dev.off()
}