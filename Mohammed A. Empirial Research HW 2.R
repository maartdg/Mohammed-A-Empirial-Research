library(tidyverse)
install.packages("palmerpenguins")
install.packages("ggthemes")
install.packages("penguins")
library(palmerpenguins)
library(ggthemes)
library(penguins)
glimpse("penguins")
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point()


# Exercises 1.2.5
#5
ggplot(data = penguins) + 
  geom_point()
#This code is missing the aesthetics, so I would fix it by giving what the x should be and y s should be.

#Fix
ggplot(
  data = penguins,
  #Aesthetics
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point()


#9
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = island)
) +
  geom_point() +
  geom_smooth(se = FALSE)

#In this code, my prediction is correct in the sense that the data used was penguins, it had x and y defined, and color
#distinguished island. The se and false would be removed due to it being false.


#10

#First One

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point() +
  geom_smooth()


#Second One
ggplot() +
  geom_point(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  ) +
  geom_smooth(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  )

#They ctually would be the same because the first one give the code all together. But the second one,
#the code is separated into geompoint and geomsmooth.The were separated but connected with the + sign


#1.4.3

#2

ggplot(penguins, aes(x = species)) +
  geom_bar(color = "red")

ggplot(penguins, aes(x = species)) +
  geom_bar(fill = "red")

#Fill is more useful in to make bar red insetad of color.

install.packages("carat")
library(carat)
ggplot(diamonds, aes(x = carat)) +
  geom_histogram(binwidth = 20)

ggplot(diamonds, aes(x = carat)) +
  geom_histogram(binwidth = 1)

ggplot(diamonds, aes(x = carat)) +
  geom_histogram(binwidth = 0.5)


ggplot(diamonds, aes(x = carat)) +
  geom_histogram(binwidth = 0.3)

ggplot(diamonds, aes(x = carat)) +
  geom_histogram(binwidth = 0.15)

#The graph shows count for carat diamnods. I like bandwith 0.15. It shows learly the count for different carats.


#Exercses 1.5.5

#6
ggplot(
  data = penguins,
  mapping = aes(
    x = bill_length_mm, y = bill_depth_mm, 
    color = species, shape = species
  )
) +
  geom_point() +
  # labs changes axis labels and legend titles
  labs(color = "Species",shape = "Species")

#Since in the mapping function, species is conveyed through shape and color. I simply added that in the labs 
#function shape should equal to species as well.

#7
library(palmerpenguins)
library(ggthemes)
library(penguins)
glimpse("penguins")
#1st On
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")

#The graph tell you the how much of the island consists of the three species. For example, Biscoe island has 
#75 percent Gentoo and 25 percent Adelie. Also, Adelie is on all three islands.

#2nd 
ggplot(penguins, aes(x = species, fill = island)) +
  geom_bar(position = "fill")

#The graph tells you the percentage of species on different islands. For example, Dream island has only
#Chinstrap species.


