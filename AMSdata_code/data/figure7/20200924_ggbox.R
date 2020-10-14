
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
library(forcats)
options(scipen=100, digits=4)

#wq<-read.csv("mei_max10d_gwrmp_Basin.csv",header = T,stringsAsFactors = F)
wq1<-read.csv("D:/workststion/matlab/20200722_slide_windows_v1/result_output3/month_bias/res/merge_month_bias1.csv")

wq1<-data.table(wq1)
#wq1$count_gauge <- fct_inorder(wq1$count_gauge)
wq1$count_gauge <- factor(wq1$count_gauge, 
                      levels = c("N1","N2", "N3", "N4", "N5", 
                                 "N6", "N7", "N8", "N9",
                                 "N10", "N11"), 
                      ordered = TRUE)

ggplot(wq1, aes(count_gauge, valid_val_Avg1))+
  

  geom_boxplot(width=0.5,position=position_dodge(1), fill="cyan")+
  stat_summary(fun.y="mean",geom="point",shape=23,size=7,colour="gray15",position=position_dodge(1))+
  ylim(0,160)+
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
 # scale_fill_discrete (labels=expression("GWRMP","IDW","MSWEP"))+
 scale_y_continuous(breaks=seq(0,200,20))+
  # annotate("text", x= 4, y= 120, label="SD",size = 10, colour = "black",family="serif")
  labs(x="Count of gauges in a 3¡Á3 Window (CG)", y= "Mean deviation of monthly GWRMP and IDW(MD:mm)")