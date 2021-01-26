
library(ggplot2)

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


#create summary table, summarizing emissions by year and type, for Baltimore
Balto <- emission[which(emission$fips == "24510"),] # Baltimore city emissions

MVindex <- grep("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE) # vector of rows with "vehicle" in level two
SCC2 <- SCC[,c(1,8)] # reduces SCC to only SCC and one column with type of source
SCCMV <- SCC2[MVindex,] #subsets SCC2 to only those rows with "vehicle" 
emissionMV <- merge(Balto, SCCMV, by ="SCC") #creates emission table for motor vehicle sources
emissionMV$yearfactor <- as.factor(emissionMV$year)

#create plot of Total PM25 Emissions as Plot5.png
options(scipen = 99)
png(filename = "Plot5.png", width = 480, height = 480, units = "px")
g <- ggplot(emissionMV, aes(x= yearfactor, y = Emissions))
g + geom_col() +labs(title = "Total PM25 Emissions for Motor Vehicles in Baltimore City", x="Year") 


dev.off()



