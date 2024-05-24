#Mohammed A. Al Muhaymin,Md Muhibul Islam, Luis Melo
#Final Project
install.packages("plotly")
install.packages('ggplot2')
install.packages("tidyverse")
install.packages("rsample")
install.packages("reshape2")
install.packages("tidyr")
library(plotly)
library(ggplot2)
library(tidyverse)
library(haven)
library(dplyr)
library(rsample)
library(caret)
library(DT)
summary(acs2021)
use_var <- (acs2021$AGE >= 18) & (acs2021$AGE <= 62) & (acs2021$LABFORCE == 2) & ((as.numeric(acs2021$Commute_bus)) | (as.numeric(acs2021$Commute_subway)) | (as.numeric(acs2021$Commute_rail)))
#use_var is a subset of acs2021 data where the people are from age 18 to 62, they are in labor force,
#they like to use public transportation like bus,subways or rail.
commute_data <- subset(acs2021,use_var)
summary(commute_data) 

#Graph 1
commute_educ_graph <- ggplot(data = commute_data) +
  geom_bar(mapping = aes(x = EDUC, fill = EDUC))+
  labs(
    title = 'Education Level of People Commute Using Public Transportation in NY' ,
    x = 'Education Level',
    y = 'Number of People'
  ) + theme_bw() +
  theme(
    plot.title = element_text(color = "brown2", size = 15, face = "bold", 
                              hjust = 0.5), axis.text.x = element_text(angle = 90, hjust = 1))
ggplotly(commute_educ_graph)

#The graphs portrays the education level of the people who uses public transportation. 
#Among the people who uses public transportation, highest number of people are people 
#who spend 4 years of college or getting their bachelor degree. Next highest 
#is the people at the end of highe school, grade 12. 

#Graph 2
commute_hispanic_graph <- ggplot(data = commute_data) +
  geom_bar(mapping = aes(x = HISPAN, fill = HISPAN))+
  labs(
    title = 'Race Distribution of Hispanic people who uses public transportaion in NY' ,
    x = 'Type of Race',
    y = 'Amount of People'
  ) + theme_bw() +
  theme(
    plot.title = element_text(color = "orchid4", size = 15, face = "bold",
                              hjust = 0.5), axis.text.x = element_text(angle = 90, hjust = 1))
ggplotly(commute_hispanic_graph)
#The graph tells us that majority of the people commuting using public transportation are
# not Hispanic, which is surprising given that there are lot of of Hispanic people living in NY. 
#0 means not hispanic, 1 means they are mexican, 2 means they are puerto rican,
#3 means they are cuban, and 4 means other type of hispanic.

#Graph 3

commute_time_graph <- ggplot(commute_data, aes(x = TRANTIME))+
  geom_histogram(binwidth = 10)+
  labs(
    title = 'Time Spent Traveling Using Public Transportation' ,
    x = 'Public Transportattion Travel Time',
    y = 'Amount of People'
  ) + theme_bw() +
  theme(
    plot.title = element_text(color = "seagreen", size = 15, face = "bold", 
                              hjust = 0.5), axis.text.x = element_text(angle = 90, hjust = 1))
ggplotly(commute_time_graph)


#The graph shows that people who used public transportation sepnt traveling 
#it 40 minutes followed by a hour. Not many people people
#who commute used public transportation long time, like 2 hours or short time as well.


#Graph 4
set.seed(123)
split <- initial_split(commute_data,prop = 0.7)

commute_train <- training(split)
commute_test <- testing(split)
commute_time_model <- lm(DEPARTS ~ TRANTIME,data = commute_data)
commute_time_model
ggplot(commute_train,
       aes(x = DEPARTS, y = TRANTIME)) + 
  geom_point() +
  geom_smooth(method = "lm")

#The departure time was regressed with travel time shows that 
#between 5 am to 9 am is the most of public transportation usage since the dots more concentrated there. 
#The time frame varied mainly from 0 to 100 min. It makes sense, since 
#during that time people are going to work. But, there are still people who leaving for late not during
#rush hour and it still took a long time. Also, there seems more or less a negative relationship
#between travel time and time of departure. The coefficient is -0.9927,which is very close close to -1. 


