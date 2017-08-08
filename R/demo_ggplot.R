#ggplot demo
#Xunliang Liu
#Jan 24, 2016

#install pacakges; all success
#install.packages("ggplot2", dependencies = TRUE)
#install.packages("ggthemes")
#install.packages("tidyr")
install.packages("knitr")
install.packages("RColorBrewer")

#load packages
library("ggplot2") #gg: grammar of graphics
library("ggthemes")
library("tidyr")
library("dplyr")
library("MASS")
library("RColorBrewer")
# gapIn <- read.csv("data/gapminder-FiveYearData.csv", header = TRUE)
# head(gapIn)
# gapMelt <- gather(gapIn, key = aaa, value = bbb, -c(country,continent))
# head(gapMelt)


head(iris)
str(iris)
df <- gather(iris, key = flower_arribute, value = measurement, -Species) #gather functions the same as melt() in package reshape
head(df)
str(df)

#anything in aes() is mapping; anything outside of aes() is setting
#mapping can be put either in ggplot() or in geom_point()
ggplot(data = iris, aes(x = Sepal.Length,
                        y = Sepal.Width)) +
  geom_point(aes(col = Species), size = 3) +
  facet_grid(Species ~ .) + # facet_grid is a 2D plot, ~ seperate column and row
  #facet_wrap(Species~) #facet_wrap is 1D plot. no dot needed
  scale_fill_manual(value = c("red","blue","cyan"))
summary(myplot)

display.brewer.all()
ggplot(df,aes(Species,measurement,fill = flower_arribute)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_fill_manual(palette = "Set2")




d2 <- diamonds[sample(1:dim(diamonds)[1],1000),]
d2melt <- gather(data = d2, key = dimChar, value = Value, -c(cut, color))
ggplot(data = d2melt, aes(x = carat, y = price)) +


birthwt #dataset is in package MASS
ggplot(birthwt, aes(factor(race),bwt)) +
  geom_boxplot() +
  stat_boxplot() +
  scale_y_continuous(label = (paste0(1:4," Kg")),
                     break = seq(from = 1000, to = 4000,by = 100))
