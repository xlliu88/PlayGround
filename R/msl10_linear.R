library("dplyr")
library("MASS")
library("reshape2")
library("ggplot2")
getwd()
setwd("C:/Users/xunliangliu/Documents/R Scripts")
# setwd("C:/Users/xinli/Dropbox/Datatransfer")
setwd("L:/MitchumLab/Individual Lab Folders/XunliangLiu/MSL10/counts")

msl10_Raw <- read.csv("msl10_infection_count.csv", header = TRUE)
head(msl10_Raw)

drops <- c("TdpiCount")
msl10 <- msl10_Raw[,!names(msl10_Raw) %in% drops]
names(msl10) <- c("Rep", "Plate", "Well", "Code", "Genotype", "14dpi", "30dpi","30dpi(big)", "30dpi(medium)","30dpi(small)","Note")
head(msl10)
msl10$Rep <- factor(msl10$Rep, c(1,2,3))
msl10$Plate <- factor(msl10$Plate, c(1:12))
msl10$Code <- factor(msl10$Code)
msl10$Genotype <- factor(msl10$Genotype,c("WT","msl10-1","msl10-1, msl9-1","msl10-1, msl9-1, msl4,msl5, msl6"))

#remove contaminated data
msl10_2 <- msl10 %>%
  filter(Note != "contaminated")
msl10_2$Note <- NULL

msl10$Note <- NULL

#melting data
msl10_melt <- melt(msl10, id.vars = c("Rep","Plate","Well","Code","Genotype"))
head(msl10_melt)
msl10_melt2 <- melt(msl10_2, id.vars = c("Rep","Plate","Well","Code","Genotype"))

REP1 <- msl10_melt %>%
  filter(Rep == 1)
REP2 <- msl10_melt %>%
  filter(Rep == 2)
REP3 <- msl10_melt %>%
  filter(Rep == 3)

#lm is used to fit linear models
# sth is not write. need to check more
summary(lm(value ~ Genotype, msl10_melt)) 
summary(lm(value ~ Rep, msl10_melt))
summary(lm(value ~ Plate, msl10_melt))
summary(lm(value ~ Well, msl10_melt))

# ANOVE test
summary(aov(value ~ Genotype, msl10_melt))
summary(aov(value ~ Rep, msl10_melt))
summary(aov(value ~ Plate, msl10_melt))
summary(aov(value ~ Well, msl10_melt))

summary(aov(value ~ Rep*Genotype, msl10_melt))
summary(aov(value ~ Plate*Genotype, msl10_melt))
summary(aov(value ~ Well*Genotype, msl10_melt))


