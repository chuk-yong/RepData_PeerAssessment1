#Set working directoty and read in data from activity.csv
setwd("~/Desktop/Rstudio/RepData_PeerAssessment1")
Data <- read.csv("activity.csv")

# Get Mean and Median by day using dplyr
library(dplyr)
MM_Data <- Data %>% 
  # na.omit(steps) %>%
  group_by(date) %>% 
  summarise(Sum=sum(steps,na.rm=TRUE),Mean=mean(steps,na.rm=TRUE), Median=median(steps,na.rm=TRUE))

TMedian <- aggregate(Data$steps, by=list(Data$date), FUN=median, na.rm=TRUE)
#plot mean and median total steps per day
library(ggplot2)
png("Mean&Median.png")
g <- ggplot()