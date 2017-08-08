#demo of basic graphic functions
#Xunliang
#Jan 24, 2016

#Read in gapreminder dtaset
gapIn <- read.csv("data/gapminder-FiveYearData.csv", header = TRUE)
head(gapIn)

#get data for country Australia and plot lifeExpe over year 
subset_Au <- gapIn[gapIn$country == "Australia",]
plot(x = subset_Au$year,
     y = subset_Au$lifeExp,
     xlab = "year",
     ylab = "Life Expectancy",
     main = "Life Expectancy in Australia over years")

#Fit  a linear model to the Australia data
australia_lm <- lm(lifeExp ~ year, data = subset_Au)
str(australia_lm)
anova(australia_lm)
abline(australia_lm,
       col = "red")

#boxplot of gdpPercap by continent
boxplot(gdpPercap/1000 ~ continent, 
        data = gapIn,
        ylab = "GDP (x1000)")
