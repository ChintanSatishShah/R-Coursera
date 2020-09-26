
#Set the date format to use the Date type in column of DataFrame
setClass("myDate")
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )
#Set the class for all columns of DataFrame
colTypes <- c('myDate', 'character', rep('numeric', 7)) 
#Create a tempfile for temp storage
temp <- tempfile()
#Download the file from Internet URL into tempfile
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
#Move the file data to dataframe
data <- read.table(unz(temp, "household_power_consumption.txt"), header=T, sep=";", 
	colClasses=colTypes, na.strings = "?", comment.char = "")
#Remove the temp file from memory
unlink(temp)
#str(data) #Use for debugging

#Filter data as per specified dates
plotdata <- subset (data, Date == "2007-02-01" | Date == "2007-02-02")
#Add datetime column
plotdata$datetime <- with(plotdata, as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"))

#Plot 3
#Create a png file of specified dimensions and name
png(filename = "plot3.png", width = 480, height = 480, units = "px", 
	bg = "transparent", restoreConsole = TRUE)
plot(Sub_metering_1 ~ datetime, data=plotdata, type="l", xlab="", ylab="Energy sub metering")
lines(plotdata$datetime, plotdata$Sub_metering_2, type="l", col="Red") 
lines(plotdata$datetime, plotdata$Sub_metering_3, type="l", col="Blue") 
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
	col=c("black", "red", "blue"), lty=1)
#dev.copy(png, file = "plot3.png") ## Copy plot to a PNG file
dev.off() ## Close the PNG device

##Remove all the variables created by this code
rm(list=ls(all=TRUE))