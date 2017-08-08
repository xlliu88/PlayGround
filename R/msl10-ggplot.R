# msl10 plot
# Dec 2, 2016
# Xunliang Liu

#install.packages("reshape2")
#install.packages("dplyr")
#install.packages("reshape2")
#install.packages("ggplot2")

library("dplyr")
library("MASS")
library("reshape2")
library("ggplot2")
 getwd()
# setwd("C:/Users/xinli/Dropbox/Datatransfer")
 setwd("L:/MitchumLab/Individual Lab Folders/XunliangLiu/MSL10/counts")
 
 msl10_Raw <- read.csv("msl10_infection.csv", header = TRUE)
 head(msl10_Raw)
 
 drops <- c("TdpiCount")
 msl10 <- msl10_Raw[,!names(msl10_Raw) %in% drops]
 names(msl10) <- c("Rep", "Plate", "Well", "Code", "Genotype", "14dpi", "30dpi","30dpi(big)", "30dpi(medium)","30dpi(small)","Note")
 head(msl10)
 msl10$Rep <- factor(msl10$Rep, c(1,2,3))
 msl10$Plate <- factor(msl10$Plate, c(1:12))
 msl10$Code <- factor(msl10$Code)
 msl10$Genotype <- factor(msl10$Genotype,c("WT","msl10-1","msl10-1, msl9-1","msl10-1, msl9-1, msl4,msl5, msl6"))

 #remove contaninated data
 msl10_2 <- msl10 %>%
   filter(Note != "contaminated") %>%
   select(-Note)
 
 msl10 <- msl10 %>%
  select(-Note)
 
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
 
#Boxplot
#change to x = Genotype, color = variable if want to use Genotype as x-axis
 ggplot(msl10_melt, aes(x = variable,y = value, color = Genotype), na.rm = TRUE) +                   
  ggtitle("Cyst count - All replicates combined \n(Group by Genotype)") +   
  
# ggplot(REP1, aes(variable,value,color = Genotype), na.rm = TRUE) +
#   ggtitle("Cyst count - Rep1\n(Group by Genotype)") +
# ggplot(REP2, aes(variable,value,color = Genotype), na.rm = TRUE) +
#   ggtitle("Cyst count - Rep2\n(Group by Genotype)") +
# ggplot(REP3, aes(variable,value,color = Genotype), na.rm = TRUE) +
#  ggtitle("Cyst count - Rep3\n(Group by Genotype)") +
#   
   geom_boxplot(
               #aes(color = Genotype),
               stat = "boxplot", 
               position = "dodge",
               lwd = 0.5,
               fatten = 0.2,
               #outlier.colour = "black", 
               outlier.shape = 20, 
               outlier.size = 1, 
               notch = FALSE, 
               notchwidth = 0.5) +
  #scale_fill_manual(values = cbbPalette) +
  #stat_summary(fun.y=mean, na.rm = TRUE, geom="point", color = "black", shape="+", size=4) +
  scale_y_continuous(name = "# of Cyst per Plant",
                    limits = c(0,30),
                    #expand = c(0.08,0),
                    breaks = seq(0,30,5) )+
  scale_x_discrete(name = " ", expand = c(0,0.5)) +
  theme(axis.title.x = element_blank(), #hide x axis title.
        axis.ticks.x = element_line(size = 0.5, color = "black"), #hide x axis ticks.
        axis.title.y = element_text(face = "bold", color = "black", size = 12),
        axis.ticks.y = element_line(size = 0.5, color = "black"),
        axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1, color = "black", face="italic", size = 12),
        axis.text.y = element_text(face = "plain", color = "black", size = 10),
        axis.line = element_line(color = "black", size = 0.5, linetype = 1, lineend = "square"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_rect(fill = "white"),
        plot.background = element_rect(fill = "white"),
        plot.title = element_text(hjust = 0.5)) 

 #
 #
 #Boxplot - contaminated wells removed
 REP1 <- msl10_melt2 %>%
   filter(Rep == 1)
 REP2 <- msl10_melt2 %>%
   filter(Rep == 2)
 REP3 <- msl10_melt2 %>%
   filter(Rep == 3)
 
 ggplot(msl10_melt2, aes(variable,value,color = Genotype), na.rm = TRUE) +                    #change variable to Genotype if want to use Genotype as x-axis
   ggtitle("Cyst count - All replicates combined \n(Group by Genotype, w/o contaminated wells)") +   #and in geom_boxplot line , make the change color = variable 
   
   ggplot(REP1, aes(variable,value,color = Genotype), na.rm = TRUE) +
     ggtitle("Cyst count - Rep1\n(Group by Genotype, w/o contaminated wells)") +
   ggplot(REP2, aes(variable,value,color = Genotype), na.rm = TRUE) +
     ggtitle("Cyst count - Rep2\n(Group by Genotype, w/o contaminated wells)") +
   ggplot(REP3, aes(variable,value,color = Genotype), na.rm = TRUE) +
    ggtitle("Cyst count - Rep3\n(Group by Genotype, w/o contaminated wells)") +

   geom_boxplot(#aes(color = Genotype),
                stat = "boxplot", 
                position = "dodge",
                lwd = 0.5,
                fatten = 0.2,
                #outlier.colour = "black", 
                outlier.shape = 20, 
                outlier.size = 1, 
                notch = FALSE, 
                notchwidth = 0.5) +
   #scale_fill_manual(values = cbbPalette) +
   #stat_summary(fun.y=mean, na.rm = TRUE, geom="point", color = "black", shape="+", size=4) +
   scale_y_continuous(name = "# of Cyst per Plant",
                      limits = c(0,30),
                      #expand = c(0.08,0),
                      breaks = seq(0,30,5) )+
   scale_x_discrete(name = " ", expand = c(0,0.5)) +
   theme(axis.title.x = element_blank(), #hide x axis title.
         axis.ticks.x = element_line(size = 0.5, color = "black"), #hide x axis ticks.
         axis.title.y = element_text(face = "bold", color = "black", size = 12),
         axis.ticks.y = element_line(size = 0.5, color = "black"),
         axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1, color = "black", face="italic", size = 12),
         axis.text.y = element_text(face = "plain", color = "black", size = 10),
         axis.line = element_line(color = "black", size = 0.5, linetype = 1, lineend = "square"),
         panel.grid.major = element_blank(),
         panel.grid.minor = element_blank(),
         panel.background = element_rect(fill = "white"),
         plot.background = element_rect(fill = "white"),
         plot.title = element_text(hjust = 0.5)) 
 