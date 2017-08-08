# This is a template for qRT-PCR plot; 
# The qRT-PCR file should have relative expression levele caculated
# file header includes: Experiment Date, Genotype, Treatment, Target Gene, 
#                       dpi, Well#, Ct, and relative expression value
# Dec 20, 2016
# Xunliang Liu

library("dplyr")
library("MASS")
library("reshape2")
library("ggplot2")

getwd()
setwd("L:/MitchumLab/Individual Lab Folders/XunliangLiu/Xiaoli_Data")

#qRT <- read.csv("20130626-150515_reorganized.csv", header = TRUE)
qRT <- read.csv("20130626-150515_reorganized.csv", header = TRUE)
qRT$Well <- as.factor(qRT$Well)
qRT$Treat <- factor(qRT$Treat,levels = c("Mock", "BCN"))
#qRT$Treat <- factor(qRT$Genotype,levels = c("WT", "triple"))

qRT <- qRT %>%
  filter(qRT$tarGene != "UBC" & qRT$tarGene != "GAPDH")

qRT1 <- qRT[,!names(qRT) %in% c("CT","RelExp2")]
qRT2 <- qRT[,!names(qRT) %in% c("CT","RelExp")]
head(qRT1)
head(qRT2)
summary(qRT1)
#####################################################
## to filter data points for plot
dt <- "11/13/2014"
genes <- c("CLE41", "BES1","TDR")
# genes <- c("ARR7", "SHY2","BPM1", "WOX4")
# genes <- c("ARR15", "CKX7","IPT2", "LBD29")

dfgene <- qRT1 %>%
 filter(Date == dt, tarGene %in% genes)

## to set y limt and break of the coordinates
    EXPmax <- max(dfgene$RelExp, na.rm = TRUE)
    EXPstd <- sd(dfgene$RelExp, na.rm = TRUE)
    ylim <- EXPmax + EXPstd/length(dfgene$RelExp)
    ylim = ylim + ylim/10
    
    if (ylim < 1) {
      breaker = ylim/10  
      }else {
      breaker = ceiling(ylim/2) * 0.2 }

## code for plot    
    p <- ggplot(dfgene, aes(x = Genotype, y = RelExp),na.rm = TRUE) 
    ti <- ggtitle(paste(dt, "qRT-PCR")) 
    
    bar <- geom_bar(aes(fill = interaction(Treat,DPI)),
                    width = 0.8, #adjust the width of each bar
                    position = position_dodge(0.9),
                    stat = "summary",
                    fun.y = "mean") 
    err <- geom_errorbar(aes(group = interaction(Treat,DPI)),
                         position = position_dodge(0.9), # make sure the number is the same as the one in geom_bar()
                         stat = "summary",
                         width = 0.5) 
    ft <- facet_grid(. ~ tarGene,
                     scales = "free_y") 
    
    y <- scale_y_continuous(name = "Relative Expression Level",  
                          # limits = c(0,30),  #set limit in scale_y will throw away outbound data
                            expand = c(0,0),
                            breaks = seq(0, ylim, breaker)) 
    x <- scale_x_discrete(name = " ", expand = c(0,0.25)) 
    cod <- coord_cartesian(ylim = c(0,ylim))      # use corrd_cartesian sets scales only on coordinates without throwaway data   
    th <- theme(axis.title.x = element_blank(),   # hide x axis title.
                axis.ticks.x = element_line(size = 0.5, color = "black"), #hide x axis ticks.
                axis.title.y = element_text(face = "bold", color = "black", size = 12),
                axis.ticks.y = element_line(size = 0.5, color = "black"),
                axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1, color = "black", size = 12),
                axis.text.y = element_text(face = "plain", color = "black", size = 10),
                axis.line = element_line(color = "black", size = 0.5, linetype = 1, lineend = "square"),
                panel.grid.major = element_blank(),
                panel.grid.minor = element_blank(),
                panel.background = element_rect(fill = "white"),
                panel.border = element_rect(color = "black", fill = NA, size = 0.5),
                plot.background = element_rect(fill = "white"),
                plot.title = element_text(hjust = 0.5)) 
    
    myplot <- p + ti + bar + err + ft + x + y + cod + th
    myplot
  # ggsave(paste0("Plot-",as.Date(dt, format = "%m/%d/%Y"),gn, ".pdf"), width=8, height=6, unit = "in")
    

#################################################
## loops to plot each date/gene individully
## first loop throuth date of individule date
dts <- levels(qRT1$Date)
for (dt in dts)
{
  dfdt <- qRT1[qRT1$Date == dt,]
  dfdt$tarGene <- factor(dfdt$tarGene) #apply factor again to remove empty data point in the subset frame
  
  ## a second loop to go through each gene
  genes <-levels(dfdt$tarGene)
  for (gn in genes)
  {
    dfgene <- dfdt[dfdt$tarGene == gn,]
    
    # to set y limt and break of the coordinates
    EXPmax <- max(dfgene$RelExp, na.rm = TRUE)
    EXPstd <- sd(dfgene$RelExp, na.rm = TRUE)
    ylim <- EXPmax + EXPstd/length(dfgene$RelExp)
    ylim = ylim + ylim/10

    if (ylim < 1) {
      breaker = ylim/10  } 
    else {
      breaker = ceiling(ylim/2) * 0.2 }
  
      p <- ggplot(dfgene, aes(x = Genotype, y = RelExp),na.rm = TRUE) 
      ti <- ggtitle(paste(dt, "qRT-PCR")) 
    
      bar <- geom_bar(aes(fill = interaction(Treat,DPI)),
                width = 0.8, #adjust the width of each bar
                position = position_dodge(0.9),
                stat = "summary",
                fun.y = "mean") 
      err <- geom_errorbar(aes(group = interaction(Treat,DPI)),
                position = position_dodge(0.9), #not working properly when use position = "dodge"
                stat = "summary",
                width = 0.5) 
      ft <- facet_grid(. ~ tarGene,
                scales = "free_y") 
      
      y <- scale_y_continuous(name = "Relative Expression Level",  
                         #limits = c(0,30),  # set limit in scale_y will throw away outbound data
                         expand = c(0,0),
                         breaks = seq(0, ylim, breaker)) 
      x <- scale_x_discrete(name = " ", expand = c(0,0.25)) 
      cod <- coord_cartesian(ylim = c(0,ylim))      # use corrd_cartesian sets scales only on coordinates without throwaway data   
      th <- theme(axis.title.x = element_blank(),   # hide x axis title.
            axis.ticks.x = element_line(size = 0.5, color = "black"), #hide x axis ticks.
            axis.title.y = element_text(face = "bold", color = "black", size = 12),
            axis.ticks.y = element_line(size = 0.5, color = "black"),
            axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1, color = "black", size = 12),
            axis.text.y = element_text(face = "plain", color = "black", size = 10),
            axis.line = element_line(color = "black", size = 0.5, linetype = 1, lineend = "square"),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            panel.background = element_rect(fill = "white"),
            panel.border = element_rect(color = "black", fill = NA, size = 0.5),
            plot.background = element_rect(fill = "white"),
            plot.title = element_text(hjust = 0.5)) 

      myplot <- p + ti + bar + err + ft + x + y + cod + th
      print(myplot)
      ggsave(paste0("Plot-",as.Date(dt, format = "%m/%d/%Y"),gn, ".pdf"), width=6, height=6, unit = "in")

  }
}
