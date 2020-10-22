#Reading the data into R
chaff <- read.table("chaff.txt", header = T)

#Loading in Tidyverse
library(tidyverse)

#The data is in two columns of males and females so it is important to put the data into tidy format -
#males and females in one column (sex) and the value in another column (max)
chaff2 <- gather(data = chaff, key = sex, value = max)

#Analysing the data to see if there is a difference in mass between males and females
#Loading in RMisc to generate a summary of the data
library(Rmisc)

#Generating a summary of the data
chaffsummary <- summarySE(chaff2, measurevar = "max", groupvars = "sex")
chaffsummary

#Creating a plot to see if there is a difference in mass between males and females
#Loading ggplot to create a plot
library(ggplot2)

#Creating a plot
ggplot(data = chaff2, aes(x = sex, y = max ))+
  geom_boxplot()
