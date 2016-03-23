## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

yearlyEmissions <- aggregate(x=NEI$Emissions, by=list(NEI$year), FUN=sum)

#Emissions is in tons -> Devide by 1000 to get kilotons

yearlyEmissions$kt <- yearlyEmissions[,2] / 1000


png("plot1.png")
barplot(yearlyEmissions$kt, names.arg = yearlyEmissions[,1], xlab = "Year", ylab='PM2.5 in Kilotons', main="Total Emissions of PM2.5")
dev.off()
