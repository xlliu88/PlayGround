# q-q plot of msl10-BCN infection assay
# Dec 2, 2016
# Xunliang Liu

library("MASS")
library("dplyr")
setwd("L:/MitchumLab/Individual Lab Folders/XunliangLiu/MSL10/counts")
msl10 <- read.csv("msl10_infection.csv", header = TRUE)
head(msl10)

names(msl10) <- c("Replication", "Plate#","Well#", "GtCode", "Genotype", "C14dpi", "C30dpi_Raw","C30dpi","C30dpi-big","C30dpi-medium","C30dpi-small","Note")
drops <- c("C30dpi_Raw")
msl10 <- msl10[ , !(names(msl10) %in% drops)]

head(msl10)


Fdpi <- msl10[,6]
Tdpi <- msl10[,7]
Tdpib <- msl10[,8]
Tdpim <- msl10[,9]
Tdpis <- msl10[,10]
qqnorm(Fdpi,  main = "Normal Q-Q Plot",
       xlab = "Theoretical Quantiles", ylab = "14dpi Quantiles",
       plot.it = TRUE)
qqline(Fdpi, col = 2)

qqnorm(Tdpi,  main = "Normal Q-Q Plot",
       xlab = "Theoretical Quantiles", ylab = "30dpi Quantiles",
       plot.it = TRUE)
qqline(Tdpi, col = 2)

qqnorm(Tdpib,  main = "Normal Q-Q Plot",
       xlab = "Theoretical Quantiles", ylab = "30dpi big Quantiles",
       plot.it = TRUE)
qqline(Tdpib, col = 2)

qqnorm(Tdpim,  main = "Normal Q-Q Plot",
       xlab = "Theoretical Quantiles", ylab = "30dpi medium Quantiles",
       plot.it = TRUE)
qqline(Tdpim, col = 2)

qqnorm(Tdpis,  main = "Normal Q-Q Plot",
       xlab = "Theoretical Quantiles", ylab = "30dpi small Quantiles",
       plot.it = TRUE)
qqline(Tdpis, col = 2)
