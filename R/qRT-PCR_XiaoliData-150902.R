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

#qRT <- read.csv("20150902_reorganized.csv", header = TRUE)
qRT <- read.csv("20150922_reorganized.csv", header = TRUE)
qRT$Well <- as.factor(qRT$Well)

#qRT$Genotype <- factor(qRT$Genotype, levels = c("Col","triple","arr1-3", "arr10-5", "arr1 arr12"))
qRT <- qRT %>%
  filter(!tarGene %in% c("UBC", "ACT2"))
qRT$tarGene <- factor(qRT$tarGene)         

## to filter data points for plot
dt <- levels(qRT$Date)
genes <- levels(qRT$tarGene)

dfgene <- qRT  # %>%
#   filter(Date == dt, tarGene != ACT2)
#   filter(tarGene %in% c("LBD15", "VND6", "WOX4"))

## to set y limt and break of the coordinates
    EXPmax <- max(dfgene$Exp2ACT, na.rm = TRUE)
    EXPstd <- sd(dfgene$Exp2ACT, na.rm = TRUE)
    ylim <- EXPmax + EXPstd/length(dfgene$Exp2ACT)
    ylim = ylim + ylim/10
    
    if (ylim < 1) {
      breaker = ylim/10  
      }else {
      breaker = ceiling(ylim/2) * 0.2 }
## Set notes
  note = paste0(levels(qRT$Tissue), "\n", levels(qRT$RNA)," RNA\n", levels(qRT$Dilution)," Dilution")

###########################################################  
## code for plot    
    p <- ggplot(dfgene, aes(x = tarGene, y = Exp2ACT),na.rm = TRUE) 
    ti <- ggtitle(paste(dt, "qRT-PCR")) 
    
    bar <- geom_bar(aes(fill = Genotype),
                    width = 0.8, #adjust the width of each bar
                    position = position_dodge(0.9),
                    stat = "summary",
                    fun.y = "mean") 
    err <- geom_errorbar(aes(group = Genotype),
                         position = position_dodge(0.9), # make sure the number is the same as the one in geom_bar()
                         stat = "summary",
                         width = 0.5) 
    # ft <- facet_grid(. ~ tarGene,
    #                  scales = "free_y") 
    
    y <- scale_y_continuous(name = "Expression Level relative to ACT2",  
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
   
     txt <- geom_text(x =5.5, y = 3.2,
                      size = 4,
                      colour = "gray",
                      label = note)
    
    myplot <- p + ti + bar + err + x + y + cod + th + txt
    myplot
  # ggsave(paste0("Plot-",as.Date(dt, format = "%m/%d/%Y"),gn, ".pdf"), width=8, height=6, unit = "in")
    
