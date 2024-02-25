#Mohammed A. Al Muhaymin
#HW 3



install.packages("nycflights13")
library(nycflights13)
library(tidyverse)
library(ggplot2)
flights
glimpse(flights)


#3.2.5
#1

#Had an arrival delay of two or more hours
flights %>%
  filter(arr_delay >= 120)

#Flew to Houston (IAH or HOU)
flights %>%
  filter(dest == "IAH" | dest == "HOU")

#Were operated by United, American, or Delta
flights %>%
  filter(carrier == "UA" | dest == "AA" | dest == "DL")

#Departed in summer (July, August, and September)
flights %>%
  filter(month == 7 | month == 8 | month == 9)

#Arrived more than two hours late, but didn’t leave late
flights %>%
  filter(arr_delay >= 120 & dep_delay <= 0)

#Were delayed by at least an hour, but made up over 30 minutes in flight
flights %>%
  filter(arr_delay >= 60 & (dep_delay - arr_delay > 30))
#4
flights %>%
  select(month,day,year)%>%
  distinct()
  view()

#Yes, Selecting s distinct month,day, and year shows that there is acrually 365 rows for 365 days.
#6

#No, because arrange just changes the order and you can filter after arranging it or filter and then arrange it.
#It all results in the same thing at the end.


#3.3.5
#4
  
variables <- c("year", "month", "day", "dep_delay", "arr_delay")
#any_of function gets these variables even if it is negative

#For example: 

flights |> 
  select(any_of(variables))
#Gets any value of these variables


flights |> 
  select(variables)
#Error
         
#3.5.7
#2
flights %>%
  arrange(desc(dep_delay)) %>%
  head()

#It shows that flight 51,3535, and 3695 have the most departure delays
#3

ggplot(
  data = flights,
  mapping = aes(x = day, y = dep_delay)
) +
  geom_point()
#Around day 9 has the most departure delayed time
  
ggplot(
  data = flights,
  mapping = aes(x = day, y = arr_delay)
) +
  geom_point()
#Around day 9 has the most arrival delayed time as well

#How does it look by each hour in the day?

flights %>%
  group_by(hour) %>%
  summarise(avg_dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = hour, y = avg_dep_delay))+
  geom_smooth()

flights %>%
  group_by(hour) %>%
  summarise(avg_arr_delay = mean(arr_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = hour, y = avg_arr_delay))+
  geom_smooth()

  

