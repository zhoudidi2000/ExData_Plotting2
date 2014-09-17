# check the folder
if (!file.exists("ExData_Plotting2")) {
    dir.create("ExData_Plotting2")
}

# set the folder as working directory
setwd("./ExData_Plotting2")

# download the zip file
fileurl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileurl, destfile = "data.zip")

# unzip the file
fname <- unzip("C:\\Users\\lenovo\\Documents\\ExData_Plotting2\\data.zip", list = TRUE)$Name
unzip("C:\\Users\\lenovo\\Documents\\ExData_Plotting2\\data.zip",
      files = fname, 
      exdir = "C:\\Users\\lenovo\\Documents\\ExData_Plotting2",
      overwrite = TRUE)

# read the data
NEI <- readRDS("summarySCC_PM25.rds")

# clean the data
NEI_city <- NEI[NEI$fips == "24510" | NEI$fips == "06037",]
NEI_motor <- NEI_city[NEI_city$type == "ON-ROAD",]
library(plyr)
pm_motor <- ddply(NEI_motor, .(fips, year), summarise, Emissions = sum(Emissions))
fips <- pm_motor$fips
fips <- gsub("06037", "Los Angeles County", fips)
fips <- gsub("24510", "Baltimore city", fips)
pm_motor$fips <- fips
names(pm_motor)[1] <- "County"
pm_motor$year <- as.factor(pm_motor$year)
pm_motor$County <- as.factor(pm_motor$County)

# plot the data
library(ggplot2)
g <- ggplot(data = pm_motor, aes(year, Emissions, group=County, colour=County))
g + geom_line() + geom_point() + xlab("Year") + ylab("PM2.5 Emission (tons)") + ggtitle("Total Emissions from Motor Vehicle Source\n in Baltimore City and Los Angeles County\n from 1999 to 2008")

# save the plot
dev.copy(png, file = "plot6.png", width = 480, height = 480)
dev.off()



