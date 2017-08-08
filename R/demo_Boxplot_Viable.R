#June 5, 2015
#last modified on June 7,2015
#Boxplot of T1 data
#save with encoding ASCII to show special characters
#in names(Seedset), d = Δ, w = ω

library("ggplot2")
library("reshape2")
library("ggthemes")
library("plyr")
library("MASS")
library(scales)
library("grid")

#setwd("//150.135.42.6/Ravi-Lab/Xunliang/Paper/Data")

Seedset <- read.csv("./data/Seed_Viable_T1.csv")
head(Seedset)
#assign column names
names(Seedset) <- c("WT (5)", 
                 "lre-7/lre-7 (10)",
                 "lre-7/+ (10)",
                 "ProLRE:cYFP-LRE (14)",
                 "ProLRE:LRE-cYFP (49)",
                 "ProLRE:LRE(CLC)-cYFP (11)",
                 "ProLRE:LRE(ND88AA)-cYFP (21)",
                 "ProLRE:LRE(LND)-cYFP (11)",
                 "ProLRE:LREdSS-cYFP (12)",
                 "ProLRE:LRE-cYFPdw (5)",
                 "ProLRE:LRE-cYFPd2w (6)", 
                 "ProLRE:LRE-cYFPdGAS (16)",
                 "ProLRE:LRE-cYFP-TM (32)")
head(Seedset)
Seedset_melt <- melt(Seedset)
head(Seedset_melt)
Seedset_melt

#subset1
Seedset1 <- Seedset[,1:5]
Seedset1 <- cbind(Seedset1, Seedset[,9])
names(Seedset1) <- c("WT", 
                    "lre-7/lre-7",
                    "lre-7/+",
                    "ProLRE:cYFP-LRE",
                    "ProLRE:LRE-cYFP",
                    "ProLRE:LREdSS-cYFP")
head(Seedset1)
Seedset1_melt <- melt(Seedset1)
head(Seedset1_melt)

#subset2
Seedset2 <- cbind(Seedset[,1:3],Seedset[,5],Seedset[,10:13],Seedset[,6:8])
names(Seedset2) <- c("WT (n=5)", 
                    "lre-7/lre-7 (n=10)",
                    "lre-7/+ (n=10)",
                    "ProLRE:LRE-cYFP (n=49)",
                    "ProLRE:LRE-cYFPdw (n=5)",
                    "ProLRE:LRE-cYFPd2w (n=6)", 
                    "ProLRE:LRE-cYFPdGAS (n=16)",
                    "ProLRE:LRE-cYFP-TM (n=32)",
                    "ProLRE:LRE(CLC)-cYFP (n=11)",
                    "ProLRE:LRE(ND88AA)-cYFP (n=21)",
                    "ProLRE:LRE(LND)-cYFP (n=11)")
head(Seedset2)
Seedset2_melt <- melt(Seedset2)
head(Seedset2_melt)

#plot
#cbbPalette <- c("#000000", "#000000","#000000","#000000","#000000","#000000","#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
ggplot(Seedset2_melt, aes(x=variable, y=value), na.rm = TRUE) +
  stat_boxplot(geom ='errorbar') +     #put errorbar at the end of whiskers
  geom_boxplot(stat = "boxplot", 
               position = "dodge",
               lwd = 0.5,
               fatten = 0.2,
               outlier.colour = "black", 
               outlier.shape = 20, 
               outlier.size = 2, 
               notch = FALSE, 
               notchwidth = 0.5) +
  #scale_fill_manual(values = cbbPalette) +
  stat_summary(fun.y=mean, na.rm = TRUE, geom="point", color = "black", shape="+", size=4,weight = 1) +
  scale_y_continuous(name = "Viable seeds(%)",
                     limits = c(0,1),
                     expand = c(0.08,0),
                     breaks = seq(0,1,0.1), 
                     labels = percent) +
  scale_x_discrete(name = " ", expand = c(0,0.8)) +
  theme(axis.title.x = element_blank(), #hide x axis title.
        axis.ticks.x = element_line(size = 0.5, color = "black"), #hide x axis ticks.
        axis.title.y = element_text(face = "bold", color = "black", size = 14),
        axis.ticks.y = element_line(size = 0.5, color = "black"),
        axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1, color = "black", face="italic", size = 10),
        axis.text.y = element_text(face = "plain", color = "black", size = 12),
        axis.line = element_line(color = "black", size = 0.5, linetype = 1, lineend = "square"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_rect(fill = "white"),
        plot.background = element_rect(fill = "white"))  

#export plot as PDF file. 
ggsave("Figure_S4.pdf",width = 6, height = 6, units = "in")
