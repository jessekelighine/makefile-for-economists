#!/usr/bin/env Rscript

###############################################################################
# -*- encoding: UTF-8 -*-                                                     #
# Author: jessekelighine@gmail.com                                            #
#                                                                             #
#                                                                             #
# Last Modified: 2023-01-30                                                   #
###############################################################################
library(data.table)
library(tidyverse)
###############################################################################

rm(list=ls()); gc()
options(scipen=999999)
set.seed(1234)

###############################################################################

TIME  <- 1e4
alpha <- 2/5
m <- 5

###############################################################################

F <- function ( d, m=m, alpha=alpha ) { 1 - ( (m+(2*alpha*m)/(1-alpha))/(d+(2*alpha*m)/(1-alpha)) )^(2/(1-alpha)) }

nodes <- rep(m-1,m)
data.table(x=seq(m,150),y=F(seq(m,150),m,alpha)) %>% 
  ggplot()+
  aes(x=x,y=y)+
  ylim(0,1)+
  geom_line(color='red') -> plot.cdf

for ( time in 1:TIME ) {
  random <- sample(1:length(nodes), size=alpha*m)
  prefer <- sample(1:length(nodes), size=(1-alpha)*m, prob=nodes/sum(nodes))
  nodes[random] <- nodes[random] + 1
  nodes[prefer] <- nodes[prefer] + 1
  nodes <- c(nodes, m)
  # if ( time %% 1e3 == 500 ) {
  #   plot.cdf <- plot.cdf + geom_point(data=unique(data.table(x=nodes,y=ecdf(nodes)(nodes)),by="x"), aes(x=x,y=y), alpha=0.2)
  # }
}

plot.cdf <- plot.cdf + geom_point(data=unique(data.table(x=nodes,y=ecdf(nodes)(nodes)),by="x"), aes(x=x,y=y), alpha=0.5)
plot.cdf <- plot.cdf +
  xlab("degree")+
  ylab("probability")+
  labs(title="Degree distribution of hybrid model (m=5, alpha=2/5, t=10,000)")

ggsave("hybrid-cdf.pdf", plot=plot.cdf, width=20, height=10, scale=0.4)

###############################################################################

d_i <- ( function ( i, t, m, alpha ) { ( m + (2*alpha*m)/(1-alpha) ) * ( t/i )^((1-alpha)/2) - (2*alpha*m)/(1-alpha) } ) %>% Vectorize(vectorize.args="i")

data.table(i=1:(TIME+m), n=nodes) %>% 
  ggplot()+
  aes(x=i,y=n)+
  geom_point(alpha=0.1) -> plot.degree

plot.degree <- plot.degree + geom_line(data=data.table(d=d_i(1:(TIME+m),TIME,m=m,alpha=alpha),i=1:(TIME+m)), aes(x=i,y=d), color="red")
plot.degree <- plot.degree +
  xlab("node")+
  ylab("degree")+
  labs(title="Degree of each node at time=10000 of hybrid model (m=5, alpha=2/5)")

ggsave("hybrid-degree.pdf", plot=plot.degree, width=20, height=10, scale=0.4)
