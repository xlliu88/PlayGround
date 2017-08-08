#It is a demo for install & import R packages

install.packages("reshape2")
install.packages("dplyr")
install.packages("ggplot2", dependencies = TRUE)
install.packages("ggthemes")
install.packages("plyr")
install.packages("MASS")
install.packages("downloader")
install.packages("rafalib")
install.packages("installr")
install.packages("agricolae") # statistical tests
install.packages("UsingR")
install.packages("devtools")
install.packages("contrast")
install.packages("swirl")
install.packages("pracma") #Practical Numerical Math Routines

#import
library("dplyr")
library(Downloder)
download(url, filename) # file will be saved using file name in current folder