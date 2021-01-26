
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
Coalindex <- grep("coal", SCC$EI.Sector, ignore.case = TRUE) # vector of rows with "coal" in EI.sector
SCC2 <- SCC[,c(1,4)] # reduces SCC to only SCC and one column with fuel source
SCCCoal <- SCC2[Coalindex,] #subsets SCC2 to only those rows with "coal" in EI.sector
emission2 <- merge(emission, SCCCoal, by ="SCC") #creates emission table for coal sources
emission2$yearfactor <- as.factor(emission2$year)

#create plot of Total PM25 Emissions as Plot4.png
options(scipen = 99)
png(filename = "Plot4.png", width = 480, height = 480, units = "px")
g <- ggplot(emission2, aes(x= yearfactor, y = Emissions))
g + geom_col() +labs(title = "Total PM25 Emissions for Coal Sources by Year", x="Year") 


dev.off()



