library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#read SCC
head(SCC)

# --> EI.Sector might me relevant:
sectors <- unique(SCC$EI.Sector)
sectors

coalSectors <- sectors[grepl("Coal", sectors)]
coalSectors

#looks good

coalSources <- SCC[SCC$EI.Sector %in% coalSectors,]


#yearly coal emission
yearlyCoalEmissions <- aggregate(Emissions ~ year, data = NEI[NEI$SCC %in% coalSources$SCC,], sum)
yearlyCoalEmissions$Emissions <- yearlyCoalEmissions$Emissions / 1000


png("plot4.png")

ggplot(yearlyCoalEmissions, aes(as.factor(year), Emissions)) +
  geom_bar(stat = "identity") +
  xlab("Year") +
  ylab("PM2.5 in Kilotons") +
  ggtitle("Total Emissions of PM2.5 of Coal Combustion-Related Sources")

dev.off()
