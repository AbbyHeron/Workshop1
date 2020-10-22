#Reading the data into R
chaff <- read.table("chaff.txt", header = T)

#Loading in Tidyverse
library(tidyverse)

#The data is in two columns of males and females so it is important to put the data into tidy format -
#males and females in one column (sex) and the value in another column (max)
chaff2 <- gather(data = chaff, key = sex, value = max)

#Analysing the data to see if there is a difference in mass between males and females
#Running a one way ANOVA of the data to see if there is a significant difference
mod <- aov(max ~ sex, data = chaff2)
mod
t.test(data = chaff2, max~sex)

#There is no significant difference between the mass of males and females

#Loading in RMisc to generate a summary of the data
library(Rmisc)

#Generating a summary of the data
chaffsummary <- summarySE(chaff2, measurevar = "max", groupvars = "sex")
chaffsummary

#Creating a plot to see if there is a difference in mass between males and females
#Loading ggplot to create a plot
library(ggplot2)

#Creating a plot
fig1 <- ggplot(data = chaffsummary, aes(x = sex, y = max, fill = sex))+
  geom_bar(stat = "identity", colour = "black")+
  geom_errorbar(aes(ymin = max-se, ymax = max+se), width = 0.2, size = 1)+
  theme_classic()+
  scale_fill_manual(values=c("dark grey", "#EA3C3C")) +
  theme(axis.line = element_line(size = 1.25), 
        axis.ticks = element_line(size = 1.25), 
        axis.text.x = element_text(size = rel(1.2), colour = "black"),
        axis.text.y = element_text(size = rel(1.2), colour = "black"),
        legend.text = element_text(size = rel(1)),
        legend.position = "none")+
  theme(text = element_text(size=14))+
  labs(x = "Sex", y = "Mass (g)")+
  scale_x_discrete(labels = parse(text=c("females" = "Females", "males" = "Males")))

#Creating figure saving settings to make it easier to save figures
units <- "in"  
fig_w <- 3.5
fig_h <- fig_w
dpi <- 300
device <- "tiff"

#Saving the figure to a file
ggsave("fig1.tiff",
       plot = fig1,
       device = device,
       width = fig_w,
       height = fig_h,
       units = units,
       dpi = dpi)
