library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#yearly emission of Baltimore City, Maryland (fips == "24510") aggregated by year and type
yearlyEmissionsBM_type <- aggregate(Emissions ~ year + type, data = NEI[NEI$fips == "24510",], sum)

png("plot3.png")

ggplot(yearlyEmissionsBM_type, aes(as.factor(year), Emissions)) +
  geom_bar(stat = "identity") +
  facet_grid(type ~ .) +
  xlab("Year") +
  ylab("PM2.5 in Tons") +
  ggtitle("Total Emissions of PM2.5 in Baltimore City by Type")


#alternative:
#qplot(year, Emissions, data = yearlyEmissionsBM_type, facets = type ~ .) + stat_smooth()

dev.off()
