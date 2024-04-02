#Mohammed A. Al Muhaymin,Md Muhibul Islam, Luis Melo
#HW 4

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