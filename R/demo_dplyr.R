#dplyr demo
#Xunliang Liu
#Jan 24, 2016

#install.packages("dplyr", dependencies = TRUE) #comment out after install success.
#installed.packages()
library("dplyr")
library("MASS")

#loading data
#source("script/subset.R")
gapIn <- read.csv("data/gapminder-FiveYearData.csv", header = TRUE)

#use dplyr to wrangle data
select(gapIn,year)

#pip functions
gapYear2000 <- gapIn %>%    
                  select(year) %>%
                  filter(year > 2000)

gapCouset <- gapIn %>%    
  select(year,country, continent, lifeExp) %>%
  #filter(country == "Australia" | country == "China") %>% 
  filter(country %in% c("Australia", "China", "Argentina","Chile")) %>%
  filter(year > 1995 & year <2005) %>%
  group_by(country, continent) %>%                  #group data by country; can be grouped by different factors
  summarise(mean.lifeExp = mean(lifeExp), sd.lifeExp = sd(lifeExp)) #will be grouped by country, won't work w/o group function
gapCouset
