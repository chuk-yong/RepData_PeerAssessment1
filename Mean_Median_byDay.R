#Set working directoty and read in data from activity.csv
setwd("~/Desktop/Rstudio/RepData_PeerAssessment1")
Data <- read.csv("activity.csv")

#Convert strings to date
Data$date <- as.Date(Data$date)


# Get Mean and Median by day using dplyr
library(dplyr)
MM_Data <- Data %>%
  summarise(group_by(date), mean(steps), median(steps), na.rm=TRUE)


#plot mean and median total steps per day
png("Mean&Median.png")
hist(Data$date, )