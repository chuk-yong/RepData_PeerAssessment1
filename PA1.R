#Set working directoty and read in data from activity.csv
setwd("~/Desktop/Rstudio/RepData_PeerAssessment1")
Data <- read.csv("activity.csv")

totalSteps <-aggregate(steps~date,data=Data,sum,na.rm=TRUE)
barplot(totalSteps$steps, names.arg = totalSteps$date, main= "Total steps per day",xlab = "Date", ylab = "Steps")

# Find the mean and total
mean(totalSteps$steps)
median(totalSteps$steps)

#Total of 5min interval
intervalSteps <- aggregate(steps~interval, Data, sum, na.rm=TRUE)

#what is the max 5min interval
intervalSteps[which.max(intervalSteps$steps),]$interval

# plot interval
plot(steps~interval,data=intervalSteps,type="l")

# what is the total missing data
sum(is.na(Data$steps))

# Create a new data set with the missing values filled in
# Find the interval mean
# intervalMean <- aggregate(steps ~ interval, Data, mean, na.rm=TRUE)

# Replace missing data in steps by the mean of corresponding interval
library(dplyr)
NewData <- Data %>% group_by(interval) %>%
  mutate(steps = replace(steps, is.na(steps), mean(steps, na.rm = TRUE)))

# Calculate and plot the new data frame for comparison
totalNewSteps <- aggregate(steps ~ date, data = NewData, sum)
barplot(totalNewSteps$steps, names.arg = totalNewSteps$date, main= "Total steps per day",xlab = "Date", ylab = "Steps")

mean(totalNewSteps$steps)
median(totalNewSteps$steps)

## Weekday vs Weekend

# NewDateData <- NewData %>% mutate(DayofWeek = weekdays(as.Date(date))) 

# Convert to dat format and check what day, convert to weekday and weekend
NewDateData <- NewData %>% mutate(DayofWeek = ifelse(weekdays(as.Date(date)) %in% c("Saturday","Sunday"), "Weekend","Weekday"))

NewDateData$DayofWeek <- as.factor(NewDateData$DayofWeek)

# Group data by Weekday/Weekend and interval, calculate total steps for each interval
WeekDaySteps <- NewDateData %>% group_by(DayofWeek, interval) %>% summarise(Totalsteps=sum(steps))

# Plot
ggplot(WeekDaySteps, aes(x=interval, y=Totalsteps)) + 
  geom_line() + 
  facet_wrap(~ DayofWeek, nrow=2, ncol=1) +
  labs(x="Interval", y="Number of steps") +
  theme_bw()

