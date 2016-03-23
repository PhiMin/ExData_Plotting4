## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#yearly emission of Baltimore City, Maryland (fips == "24510") aggregated
yearlyEmissionsBM <- aggregate(x=NEI[NEI$fips == "24510",]$Emissions, by=list(NEI[NEI$fips == "24510",]$year), FUN=sum)

png("plot2.png")
barplot(yearlyEmissionsBM[,2], names.arg = yearlyEmissionsBM[,1], xlab = "Year", ylab='PM2.5 in Tons', main="Total Emissions of PM2.5 in Baltimore City")
dev.off()
