#Mohammed A. Al Muhaymin,Md Muhibul Islam, Luis Melo
#HW 4
install.packages("plotly")
install.packages('ggplot2')
install.packages("tidyverse")
library(plotly)
library(ggplot2)
library(tidyverse)

#To get my directory
getwd()
#We are listing all calling all the files in the specific directory and naming it midterm_csvfiles
crash_csvfiles <- list.files(path = '/Users/mohammed.almuhaymin/Downloads/Empirical Midterm CSV file',full.names = TRUE)

list_crash_csvfiles <-list() #list the files one by one
for (i in 1:length(crash_csvfiles)){#For loop to read the files one by one and calling them no matter the length
  list_crash_csvfiles[[i]] <- read_csv(crash_csvfiles[i])#Reading all the files that was listed
}   

combined_crash_csvs <- do.call(bind_rows,list_crash_csvfiles) #Combining all the files to make 848,757 observations

combined_crash_csvs<- combined_crash_csvs %>% 
  distinct()

filt_combined_crash_data <- combined_crash_csvs %>% 
  mutate(accident_cause = gsub('/Users/mohammed.almuhaymin/Downloads/Empirical Midterm CSV file/', '', crash_csvfiles[i]) %>% 
           gsub('_Crashes.csv', '', .)) 
# Joining with cause files
list_crash_csvfiles <-list() # creating an open list 
for(i in 1:length(crash_csvfiles)){
  accident_type = gsub('/Users/mohammed.almuhaymin/Downloads/Empirical Midterm CSV file/', '', crash_csvfiles[i]) %>% 
  gsub('_Crashes.csv', '', .)
  list_crash_csvfiles[[i]] <- read_csv(crash_csvfiles[i]) %>%
    select(CrashID)%>%
    mutate("{accident_type}" := TRUE) 
  filt_combined_crash_data <- left_join(filt_combined_crash_data, list_crash_csvfiles[[i]], by = "CrashID")
}
filt_combined_crash_data <- filt_combined_crash_data %>% 
  mutate(across(where(is.logical), ~replace_na(., FALSE)))


danbury_crashdata <- filt_combined_crash_data %>%
  filter(CrashTownName == 'Danbury')

ggplot(data = danbury_crashdata) + 
  geom_bar(mapping = aes(x = MostSevereInjuryDesc, fill = MostSevereInjuryDesc))+
  theme(axis.text.x = element_text(angle = 90))

#This talk about the injury of the crashes that happened in Danbury. Maost of the crashes did not have any apparent injury.
#Very few of the crashes had suspected serious injury
ggplot(danbury_crashdata %>% group_by(Young_Driver) %>% count(),
       aes (x = Young_Driver, y = n)) +
  geom_bar(stat = 'identity')

#Many of the crashes in danbury were caused by a young river. At least half of the crashes actually involves a 
#young driver

ggplot(danbury_crashdata %>% group_by(Fixed_Object) %>% count(),
       aes (x = Fixed_Object, y = n)) +
  geom_bar(stat = 'identity')

#Few thousand of the crashes invilved a fixed object. Some of the crashes involve not a car, but an objet.






#Graph 1
monthly_accidents_plot <- ggplot(danbury_crashdata %>%
                  mutate(month = floor_date(as.Date(CrashDate), 'month')) %>%
                  group_by(month) %>%
                  count(),
                aes(x= month, y= n))+ 
  geom_line(color = 'blue',size = 1) + 
  geom_point(color = 'red',size = 2)+
  theme_bw() + labs(
    title = 'Danbury Accidents by Month',
    subtitle = 'Jan 2015 - March 2022',
    x = 'Month',
    y = 'Number of Accidents'
  )+
  theme(
    plot.title = element_text(color = "blue", size = 20, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 13, face = "bold", hjust = 0.5,color = "red"),
  )

monthly_accidents_plot
#The accidents were more or less around 200 during 2015 and beginning of2016. then, for some months it went more than 
#300 in 2017 and 2018. The highest number of accidents happended at the end of 2016. The lowest number of accidents happedned at
#the beginning of 2022.

ggplotly(monthly_accidents_plot)



#Graph 2
young_driver_plot <- ggplot(danbury_crashdata,aes(x = Young_Driver,fill = Young_Driver))+
  geom_bar()+
  labs(
    title = 'Young Driver Accidents in Danbury' ,
    subtitle = 'Jan 2015 - Feb 2022',
    x = 'Young Driver',
    y = 'Number of Young Driver Accidents'
  ) + theme_bw() +
  theme(
    plot.title = element_text(color = "brown2", size = 20, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 13, face = "bold", hjust = 0.5,color = "darkturquoise"))

young_driver_plot
##Many of the crashes in danbury were caused by a young river. At least half of the crashes actually involves a 
#young driver
ggplotly(young_driver_plot)

#Graph 3
injury_plot <- ggplot(data = danbury_crashdata) + 
  geom_bar(mapping = aes(x = MostSevereInjuryDesc, fill = MostSevereInjuryDesc))+
  labs(
    title = 'Injury From Accidents in Danbury' ,
    subtitle = 'Jan 2015 - Feb 2022',
    x = 'Type of Injury'
  ) + theme_bw()+ theme(axis.text.x = element_text(angle = 90)) +
  theme(
    plot.title = element_text(color = "forestgreen", size = 20, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 13, face = "bold", hjust = 0.5,color = "firebrick1"))
injury_plot
#This talk about the injury of the crashes that happened in Danbury. Most of the crashes did not have any apparent injury.
#Very few of the crashes had suspected serious injury
ggplotly(injury_plot)
  

