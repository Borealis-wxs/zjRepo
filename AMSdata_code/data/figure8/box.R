
library(ggplot2)
library(forcats)
library(ggplot2)
library(ggthemes)
library(export)
library(reshape2)
library(data.table)
library(stringr)
library(vegan)
library(car)
library(mgcv)
options(scipen=100, digits=4)


SD <- read.csv("D:/workststion/matlab/20200704-图像评价指标/box/result_month_region_SD_2data1.csv",head=TRUE)

F1 <-ggplot(SD, aes(region, value1,fill=type))+
  #geom_hline(aes(yintercept = 0),colour="black",linetype="dashed",size=1,alpha=0.5)+
  geom_boxplot(width=0.7,position=position_dodge(1))+
  stat_summary(fun.y="mean",geom="point",shape=23,size=3,colour="white",position=position_dodge(1))+
  ylim(0,120)+
  #geom_vline(aes(xintercept = 4.5),colour="grey",linetype="dashed")+
  theme_bw()+
  theme( panel.grid = element_blank(),
         panel.background = element_blank(),
         axis.line = element_line(colour = "black"),
         axis.text.x = element_text(size = 25, family = "serif", colour="black"),
         axis.text.y = element_text(size = 28, family = "serif", colour="black"),
         axis.title = element_text(size = 24, family = "serif", colour="black"),
         axis.ticks.x = element_blank(),
         legend.text = element_text(size = 26, family = "serif", colour="black"),
         legend.position = "top",
         legend.background = element_blank(),
         legend.title = element_blank())+
  scale_fill_discrete (labels=expression("GWRMP","IDW","MSWEP"))+
  #  scale_y_continuous(breaks=seq(5500,7000,500))+
# annotate("text", x= 4, y= 120, label="SD",size = 10, colour = "black",family="serif")
labs(x=NULL, y= "SD")
#F1=F1 + guides(fill=FALSE)


SF <- read.csv("D:/workststion/matlab/20200704-图像评价指标/box/result_month_region_SF_2data.csv",head=TRUE)

F2 <-ggplot(SF, aes(region, value,fill=type))+
  geom_hline(aes(yintercept = 0),colour="black",linetype="dashed",size=1,alpha=0.5)+
  geom_boxplot(width=0.7,position=position_dodge(1))+
  stat_summary(fun.y="mean",geom="point",shape=23,size=3,colour="white",position=position_dodge(1))+
  ylim(5500,7000)+
  #geom_vline(aes(xintercept = 4.5),colour="grey",linetype="dashed")+
  theme_bw()+
  theme( panel.grid = element_blank(),
         panel.background = element_blank(),
         axis.line = element_line(colour = "black"),
         axis.text.x = element_text(size = 25, family = "serif", colour="black"),
         axis.text.y = element_text(size = 28, family = "serif", colour="black"),
         axis.title = element_text(size = 24, family = "serif", colour="black"),
         axis.ticks.x = element_blank(),
         legend.text = element_text(size = 26, family = "serif", colour="black"),
         legend.position = "top",
         legend.background = element_blank(),
         legend.title = element_blank())+
  #scale_fill_discrete (labels=expression("GWRMP","IDW","MSWEP"))+
  #  scale_y_continuous(breaks=seq(5500,7000,500))+
#  annotate("text", x= 4, y= 7000, label="SF",size = 10, colour = "black",family="serif")
labs(x=NULL, y= "SF")
#F3=F3 + guides(fill=FALSE)

EN <- read.csv("D:/workststion/matlab/20200704-图像评价指标/box/result_month_region_EN_2data1.csv",head=TRUE)


F3 <- ggplot(EN, aes(region, value1,fill=type))+
  geom_hline(aes(yintercept = 0),colour="black",linetype="dashed",size=1,alpha=0.5)+
  geom_boxplot(width=0.7,position=position_dodge(1))+
  stat_summary(fun.y="mean",geom="point",shape=23,size=3,colour="white",position=position_dodge(1))+
  ylim(0,5)+

  #geom_vline(aes(xintercept = 4.5),colour="grey",linetype="dashed")+
  theme_bw()+
  theme( panel.grid = element_blank(),
         panel.background = element_blank(),
         axis.line = element_line(colour = "black"),
         axis.text.x = element_text(size = 25, family = "serif", colour="black"),
         axis.text.y = element_text(size = 28, family = "serif", colour="black"),
         axis.title = element_text(size = 24, family = "serif", colour="black"),
         axis.ticks.x = element_blank(),
         legend.text = element_text(size = 26, family = "serif", colour="black"),
         legend.position = "top",
         legend.background = element_blank(),
         legend.title = element_blank())+
  scale_fill_discrete (labels=expression("GWRMP","IDW","MSWEP"))+
  #  scale_y_continuous(breaks=seq(5500,7000,500))+
#  annotate("text", x= 4, y= 5, label="EN",size = 10, colour = "black",family="serif")
labs(x="Region", y= "EN")
F3=F3 + guides(fill=FALSE)




AG <- read.csv("D:/workststion/matlab/20200704-图像评价指标/box/result_month_region_AG_2data.csv",head=TRUE)

F4 <-ggplot(AG, aes(region, value,fill=type))+
  geom_hline(aes(yintercept = 0),colour="black",linetype="dashed",size=1,alpha=0.5)+
  geom_boxplot(width=0.7,position=position_dodge(1))+
  stat_summary(fun.y="mean",geom="point",shape=23,size=3,colour="white",position=position_dodge(1))+
  ylim(2200,3300)+
  #geom_vline(aes(xintercept = 4.5),colour="grey",linetype="dashed")+
  theme_bw()+
  theme( panel.grid = element_blank(),
         panel.background = element_blank(),
         axis.line = element_line(colour = "black"),
         axis.text.x = element_text(size = 25, family = "serif", colour="black"),
         axis.text.y = element_text(size = 28, family = "serif", colour="black"),
         axis.title = element_text(size = 24, family = "serif", colour="black"),
         axis.ticks.x = element_blank(),
         legend.text = element_text(size = 26, family = "serif", colour="black"),
         legend.position = "top",
         legend.background = element_blank(),
         legend.title = element_blank())+
 # annotate("text", x= 4, y= 3300, label="AG",size = 10, colour = "black",family="serif")
labs(x="Region", y= "AG")
  #scale_fill_discrete (labels=expression("GWRMP","IDW","MSWEP"))+
  #  scale_y_continuous(breaks=seq(5500,7000,500))+

F4=F4 + guides(fill=FALSE)

library(gridExtra)
#ggarrange(F1,F2,F3,F4,nrow=2,ncol=2)
grid.arrange(F1,F2,F3,F4,nrow=2,ncol=2)