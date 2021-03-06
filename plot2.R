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
totalpm_BC <- ddply(NEI_BC, .(year), summarise, Emissions = sum(Emissions))
totalpm_BC$axis1 <- c(1,2,3,4)

# plot the data
with(totalpm_BC, plot(axis1, Emissions, 
                      type = "o",
                      axes = FALSE,
                      xlab = "Year",
                      ylab = "PM2.5 Emission (tons)",
                      main = "Total Emissions in the Baltimore City\n from 1999 to 2008"))
year = c(1999, 2002, 2005, 2008)
axis(side = 1, at = 1:4, labels = year)
axis(side = 2)
box()

# save the plot
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()
