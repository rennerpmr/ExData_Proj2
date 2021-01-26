
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
Balto <- emission[which(emission$fips == "24510"),]

Baltosum <- Balto %>% 
       group_by(year, type) %>% 
       summarise(Emissions = mean(Emissions))
Baltosum$year2 <- as.factor(Baltosum$year)

#create plot of Total PM25 Emissions as Plot3.png
png(filename = "Plot3.png", width = 480, height = 480, units = "px")
g <- ggplot(Baltosum, aes(x= year2, y = Emissions))
g + geom_col() + facet_grid(. ~ type)


dev.off()



