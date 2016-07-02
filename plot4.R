plot4<-function ()
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
  
  #plot4
  
  par(mfrow=c(2,2))
  #plot1/4
  
  plot(strptime(selected_data$TimeStamp,"%Y-%m-%d %H:%M:%S"),selected_data$Global_active_power,type = "l", xlab = "",ylab = "Global Active Power (kilowatts)")
  
  #plot2/4
  plot(strptime(selected_data$TimeStamp,"%Y-%m-%d %H:%M:%S"),selected_data$Voltage,type = "l", xlab = "datetime",ylab = "Voltage")
  
  
  
  #plot 3/4
  plot(strptime(selected_data$TimeStamp,"%Y-%m-%d %H:%M:%S"),selected_data$Sub_metering_1,type = "l", xlab = "",ylab = "Energy sub metering")
  
  
  lines(strptime(selected_data$TimeStamp,"%Y-%m-%d %H:%M:%S"),selected_data$Sub_metering_2,type = "l", xlab = "",col="red")
  
  lines(strptime(selected_data$TimeStamp,"%Y-%m-%d %H:%M:%S"),selected_data$Sub_metering_3,type = "l", xlab = "",col="blue")
  
  legend("topright",col=c("Black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, bty = "n", cex=.5)
  
  
  #plot4/4
  plot(strptime(selected_data$TimeStamp,"%Y-%m-%d %H:%M:%S"),selected_data$Global_reactive_power ,type = "l", xlab = "datetime",ylab = "Global_reactive_power")
  
  
  #output
  dev.copy(png,file="plot4.png",width=480,height=480)
  dev.off()
  
  
}