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


#filter for Baltimore (fips == "24510") and Los Angeles (fips == "06037")
NEI_motor_BM_LA <- NEI[NEI$SCC %in% motorSources$SCC & (NEI$fips == "24510" | NEI$fips == "06037"),]

#yearly motor emission
yearlyMotorEmissions <- aggregate(Emissions ~ year + fips, data = NEI_motor_BM_LA, sum)

#rename for plot
yearlyMotorEmissions[yearlyMotorEmissions$fips == "24510",]$fips <- "Baltimore City"
yearlyMotorEmissions[yearlyMotorEmissions$fips == "06037",]$fips <- "Los Angeles County"

png("plot6.png")

ggplot(yearlyMotorEmissions, aes(as.factor(year), Emissions)) +
  geom_bar(stat = "identity") +
  facet_grid(fips ~ .) +
  xlab("Year") +
  ylab("PM2.5 in Tons") +
  ggtitle("Total Emissions of PM2.5 of Motor Vehicles")

dev.off()
