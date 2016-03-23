library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#read SCC
head(SCC)

# --> EI.Sector might me relevant:
sectors <- unique(SCC$EI.Sector)
sectors

motorSectors <- sectors[grepl("Vehicles", sectors)]
motorSectors

#looks good

motorSources <- SCC[SCC$EI.Sector %in% motorSectors,]


#yearly motor emission
yearlyMotorEmissions <- aggregate(Emissions ~ year, data = NEI[NEI$SCC %in% motorSources$SCC,], sum)
yearlyMotorEmissions$Emissions <- yearlyMotorEmissions$Emissions / 1000


png("plot5.png")

ggplot(yearlyMotorEmissions, aes(as.factor(year), Emissions)) +
  geom_bar(stat = "identity") +
  xlab("Year") +
  ylab("PM2.5 in Kilotons") +
  ggtitle("Total Emissions of PM2.5 of Motor Vehicles")

dev.off()
