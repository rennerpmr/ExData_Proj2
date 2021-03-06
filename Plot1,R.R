
# get the source file, download as emission.zip
if (!file.exists("emission.zip")){
     fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(fileURL, "emission.zip", method="curl")
}

#unzip into emission dataset
if (!file.exists("summarySCC_PM25.rds")) { 
  unzip("emission.zip") 
}

#read into data frames emission and SCC (source classification codes)
emission <-  readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



#create new variable of newtime
#power1$newtime <- paste(power1$Date, power1$Time)
#power1$newtime <- strptime(power1$newtime, format ="%m/%d/%Y %H:%M:%S")

#create histogram of Total PM25 Emissions as Plot1.png
png(filename = "Plot1.png", width = 480, height = 480, units = "px")
barplot(tapply(emission$Emissions, emission$year, FUN=sum), main = "Total PM25 Emissions")
dev.off()



