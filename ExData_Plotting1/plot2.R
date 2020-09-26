
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

#Plot 2
#Create a png file of specified dimensions and name
png(filename = "plot2.png", width = 480, height = 480, units = "px", 
	bg = "transparent", restoreConsole = TRUE)
plot(Global_active_power ~ datetime, data=plotdata, 
	type="l", xlab="", ylab="Global Active Power (kilowatts)")
#dev.copy(png, file = "plot2.png") ## Copy plot to a PNG file
dev.off() ## Close the PNG device

##Remove all the variables created by this code
rm(list=ls(all=TRUE))