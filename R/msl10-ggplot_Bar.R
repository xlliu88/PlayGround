# msl10 plot
# Dec 2, 2016
# Xunliang Liu

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

#####################################################
## Plots grouped by genotype
ggplot(msl10_melt, aes(x = variable, y = value, fill = Genotype),na.rm = TRUE) +
  ggtitle("Cyst count - All replicates combined \n(Group by Genotype)") + 

# ggplot(REP1, aes(x = variable, y = value, fill = Genotype), na.rm = TRUE) +
#  ggtitle("Cyst count - Rep1\n(Group by Genotype)") +
# ggplot(REP2, aes(x = variable, y = value, fill = Genotype), na.rm = TRUE) +
#  ggtitle("Cyst count - Rep2\n(Group by Genotype)") +
# ggplot(REP3, aes(x = variable, y = value, fill = Genotype), na.rm = TRUE) +
#  ggtitle("Cyst count - Rep3\n(Group by Genotype)") +

## Plots grouped by count day
ggplot(msl10_melt, aes(x = Genotype, y = value, fill = variable),na.rm = TRUE) +
ggtitle("Cyst count - All replicates combined") + 

# ggplot(REP1, aes(x = Genotype, y = value, fill = variable),na.rm = TRUE) +
#   ggtitle("Cyst count - Rep1") + 
# ggplot(REP2, aes(x = Genotype, y = value, fill = variable),na.rm = TRUE) +
#   ggtitle("Cyst count - Rep2") + 
# ggplot(REP3, aes(x = Genotype, y = value, fill = variable),na.rm = TRUE) +
#   ggtitle("Cyst count - Rep3") + 

  geom_bar(#aes(fill = Genotype),
          width = 0.8, #adjust the width of each bar
          position = position_dodge(0.9),
          stat = "summary",
          fun.y = "mean") +
  geom_errorbar(#aes(Group = Genotype),
                position = position_dodge(0.9), #not working properly when use position = "dodge"
                stat = "summary",
                width = 0.5) +
  facet_grid(.~ Rep) +  # plot 3 replicates side by side
  
  scale_y_continuous(name = "# of Cyst per Plant",  
                     #limits = c(0,30),  #set limit in scale_y will throw away outbound data
                     expand = c(0,0),
                     breaks = seq(0, 30, 5)) +
  scale_x_discrete(name = " ", expand = c(0,0.75)) +
  coord_cartesian(ylim = c(0,16)) +      #use corrd_cartesian sets scales only on coordinates without throwaway data   
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



##############################################
##Barplot - contaminated wells removed
REP1 <- msl10_melt2 %>%
  filter(Rep == 1)
REP2 <- msl10_melt2 %>%
  filter(Rep == 2)
REP3 <- msl10_melt2 %>%
  filter(Rep == 3)

#### Plots grouped by Genotype
ggplot(msl10_melt2, aes(x = variable, y = value, fill = Genotype),na.rm = TRUE) +
  ggtitle("Cyst count - All replicates combined \n(Group by Genotype, w/o contaminated wells)") + 
  
# ggplot(REP1, aes(x = variable, y = value, fill = Genotype), na.rm = TRUE) +
#   ggtitle("Cyst count - Rep1\n(Group by Genotype, w/o contaminated wells)") +
# ggplot(REP2, aes(x = variable, y = value, fill = Genotype), na.rm = TRUE) +
#   ggtitle("Cyst count - Rep2\n(Group by Genotype, w/o contaminated wells)") +
# ggplot(REP3, aes(x = variable, y = value, fill = Genotype), na.rm = TRUE) +
#  ggtitle("Cyst count - Rep3\n(Group by Genotype, w/o contaminated wells)") +

  
#### Plots grouped by count day
ggplot(msl10_melt2, aes(x = Genotype, y = value, fill = variable),na.rm = TRUE) +
ggtitle("Cyst count - All replicates combined\n(w/o contaminated wells)") + 

# ggplot(REP1, aes(x = Genotype, y = value, fill = variable),na.rm = TRUE) +
#   ggtitle("Cyst count - Rep1\n(w/o contaminated wells)") +
# ggplot(REP2, aes(x = Genotype, y = value, fill = variable),na.rm = TRUE) +
#   ggtitle("Cyst count - Rep2\n(w/o contaminated wells)") +
# ggplot(REP3, aes(x = Genotype, y = value, fill = variable),na.rm = TRUE) +
#   ggtitle("Cyst count - Rep3\n(w/o contaminated wells)") +

  geom_bar(#aes(fill = Genotype),
    width = 0.8, #adjust the width of each bar
    position = position_dodge(0.9),
    stat = "summary",
    fun.y = "mean") +
  geom_errorbar(#aes(Group = Genotype),
    position = position_dodge(0.9), #not working properly when use position = "dodge"
    stat = "summary",
    width = 0.5) +
  facet_grid(.~ Rep) +  # plot 3 replicates side by side
  
  scale_y_continuous(name = "# of Cyst per Plant",  
                     #limits = c(0,30),  #set limit in scale_y will throw away outbound data
                     expand = c(0,0),
                     breaks = seq(0, 30, 5)) +
  scale_x_discrete(name = " ", expand = c(0,0.75)) +
  coord_cartesian(ylim = c(0,16)) +      #use corrd_cartesian sets scales only on coordinates without throwaway data   
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

