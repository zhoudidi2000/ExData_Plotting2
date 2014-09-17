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
SCC <- readRDS("Source_Classification_Code.rds")

# clean the data
coal <- grep("coal", SCC$Short.Name, ignore.case = T, value = T)
SCC_coal <- SCC[SCC$Short.Name %in% coal,]
NEI_coal <- NEI[NEI$SCC %in% SCC_coal$SCC,] # 53400 obs
library(plyr)
pm_coal <- ddply(NEI_coal, .(year), summarise, Emissions = sum(Emissions))
pm_coal$axis1 <- c(1,2,3,4)

# plot the data
plot(pm_coal$axis1, pm_coal$Emissions, 
     axes = FALSE,
     type = "o",
     xlab = "Year",
     ylab = "PM2.5 Emission (tons)",
     main = "Total Emissions from Coal Combustion-related\n Sources in the United States from 1999 to 2008")
year = c(1999, 2002, 2005, 2008)
axis(side = 1, at = 1:4, labels = year)
axis(side = 2)
box()

# save the plot
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()

