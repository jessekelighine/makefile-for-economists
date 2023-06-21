#!/usr/bin/env Rscript

###############################################################################
# -*- encoding: UTF-8 -*-                                                     #
# Author: jessekelighine@gmail.com                                            #
#                                                                             #
#                                                                             #
# Last Modified: 2023-02-08                                                   #
###############################################################################
library(data.table)
library(tidyverse)
###############################################################################

rm(list=ls()); gc()
options(scipen=999999)
set.seed(1234)

###############################################################################

CL.1 <- function ( r, m ) { 1 / ( (1+r) * m ) }
CL.2 <- function ( r, m ) { ( r*(m-1) ) / ( m*(m-1)*(1+r)*r - m*(1-r) ) }
CL.3 <- function ( r, m ) { ( 6*(r-1) ) / ( (1+r)*(3*(m-1)*(r-1)+4*m*r) ) }

r <- seq(0.5,10,0.01)
data <- data.table(r=r)
data$m5 <- 5
data$m6 <- 6
data$m7 <- 7
data$m8 <- 8
data$m9 <- 9
data <- melt(data,
     id.vars="r",
     measure.vars=patterns("^m"),
     variable.name="tmp",
     value.name="m")
data$tmp <- NULL

data[, CL := CL.3(r,m)][, m := as.factor(m)]
# data[, CL := fifelse(r>=1,CL.1(r,m),CL.2(r,m))][, m := as.factor(m)] %>% 
data %>% 
  ggplot()+
  aes(x=r,y=CL,color=m)+
  geom_line()+
  geom_vline(xintercept=1, linetype="dashed", alpha=0.6, color='red')+
  ylim(0,0.05)+
  ylab("overall clustering")+
  labs(title="Fraction of Overall Clusters") -> plot
plot

ggsave("clustering-estimation.pdf",         plot=plot, width=20, height=10, scale=0.4)
ggsave("overall-clustering-estimation.pdf", plot=plot, width=20, height=10, scale=0.4)
