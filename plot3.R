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
NEI_BC <- NEI[NEI$fips == "24510",]
library(plyr)
pm_type <- ddply(NEI_BC, .(type, year), summarise, Emissions = sum(Emissions))
pm_type$year <- as.factor(pm_type$year)
pm_type$type <- as.factor(pm_type$type)
names(pm_type)[1] <- "Type"

# plot the data
library(ggplot2)
g <- ggplot(data = pm_type, aes(year, Emissions, group=Type, colour=Type))
g + geom_line() + geom_point() + xlab("Year") + ylab("PM2.5 Emission (tons)") + ggtitle("Total Emissions by Source Type in Baltimore city\n from 1999 to 2008")

# save the plot
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()






