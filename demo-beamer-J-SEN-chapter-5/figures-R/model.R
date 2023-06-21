#!/usr/bin/env Rscript

###############################################################################
# -*- encoding: UTF-8 -*-                                                     #
# Author: jessekelighine@gmail.com                                            #
#                                                                             #
#                                                                             #
# Last Modified: 2023-01-29                                                   #
###############################################################################
library(data.table)
library(tidyverse)
###############################################################################

rm(list=ls()); gc()
# options(scipen=999999)
set.seed(1234)

### Uniform Model #############################################################

F.uniform <- function ( d, m=10 ) { 1 - exp(1-d/m) }
f.uniform <- function ( d, m=10 ) { exp(1-d/m) * (1/m) }

D <- seq(0,100,0.1)
data.table(D = D,
           m1   = F.uniform(D,1  ),
           m10  = F.uniform(D,10 ),
           m100 = F.uniform(D,100)) %>%
  melt(id.vars="D",
       measure.vars=patterns("^m"),
       variable.name="m",
       value.name="p") %>%
  mutate(m=str_replace(m,"m","")) %>%
  ggplot()+
  aes(x=D, y=p, color=m, linetype=m)+
  geom_line()+
  xlab("degree")+
  ylab("probability")+
  labs(title="Degree Distribution (CDF) of Uniform Model") -> plot
ggsave("uniform_model-cdf.pdf", plot=plot, width=20, height=10, scale=0.4)

D <- seq(0,50,0.1)
data.table(D = D,
           m1   = f.uniform(D,1  ),
           m10  = f.uniform(D,10 ),
           m100 = f.uniform(D,100)) %>%
  melt(id.vars="D",
       measure.vars=patterns("^m"),
       variable.name="m",
       value.name="p") %>%
  mutate(m=str_replace(m,"m","")) %>%
  ggplot()+
  aes(x=D, y=p, color=m, linetype=m)+
  geom_line()+
  xlab("degree")+
  ylab("likelihood")+
  labs(title="Degree Distribution (PDF) of Uniform Model") -> plot
ggsave("uniform_model-pdf.pdf", plot=plot, width=20, height=10, scale=0.4)

D <- seq(0,50,0.1)
data.table(D = D,
           m1   = log(f.uniform(D,1  )),
           m10  = log(f.uniform(D,10 )),
           m100 = log(f.uniform(D,100))) %>%
  melt(id.vars="D",
       measure.vars=patterns("^m"),
       variable.name="m",
       value.name="p") %>%
  mutate(m=str_replace(m,"m","")) %>%
  ggplot()+
  aes(x=D, y=p, color=m, linetype=m)+
  geom_line()+
  xlab("degree")+
  ylab("log-likelihood")+
  labs(title="Degree Distribution (log-PDF) of Uniform Model") -> plot
ggsave("uniform_model-loglikelihood.pdf", plot=plot, width=20, height=10, scale=0.4)

### Preferential Attachment ###################################################

F.preferential <- function ( d, m=10 ) { 1 - m^2 * d^(-2) }
f.preferential <- function ( d, m=10 ) { 2 * m^2 * d^(-3) }

D <- seq(0,10,0.1)
data.table(D = D,
           m1 = log(f.preferential(D,1)),
           m2 = log(f.preferential(D,2)),
           m3 = log(f.preferential(D,3)),
           m4 = log(f.preferential(D,4)),
           m5 = log(f.preferential(D,5)),
           m6 = log(f.preferential(D,6)),
           m7 = log(f.preferential(D,7)),
           m8 = log(f.preferential(D,8)),
           m9 = log(f.preferential(D,9))) %>%
  melt(id.vars="D",
       measure.vars=patterns("^m"),
       variable.name="m",
       value.name="p") %>%
  mutate(m=str_replace(m,"m","")) %>%
  ggplot()+
  aes(x=D, y=p, color=m, linetype=m)+
  geom_line()+
  xlab("degree")+
  ylab("log-likelihood")+
  labs(title="Degree Distribution (log-PDF) of Preferential Attachment Model") -> plot
ggsave("preferential_model-loglikelihood.pdf", plot=plot, width=20, height=10, scale=0.4)

D <- seq(1,50,0.1)
data.table(D = D,
           m_preferential_1 = F.preferential(D,1),
           m_preferential_3 = F.preferential(D,3),
           m_preferential_5 = F.preferential(D,5),
           m_uniform_1      = F.uniform(D,1),
           m_uniform_3      = F.uniform(D,3),
           m_uniform_5      = F.uniform(D,5)) %>%
  melt(id.vars="D",
       measure.vars=patterns("^m"),
       variable.name="m",
       value.name="p") %>%
  mutate( model=ifelse(str_detect(m,"pref"),"preferential","exponential") ) %>%
  mutate(m=str_replace(m,"m_.*_","")) %>%
  ggplot()+
  aes(x=D, y=p, color=m, linetype=model)+
  geom_line()+
  ylim(0,1)+
  xlab("degree")+
  ylab("probability")+
  labs(title="Degree Distribution (CDF) Comparison: Preferential Attachment Model & Exponential Model") -> plot
ggsave("comparison-cdf.pdf", plot=plot, width=20, height=10, scale=0.4)

### Scale-Free Distribution ###################################################

F.scalefree <- function ( d, m=2, g=2 ) { 1 - (m/d)^(g-1) }
f.scalefree <- function ( d, m=2, g=2 ) { (g-1) * m^(g-1) * d^(-g) }

D <- seq(2,20,0.1)
data.table(D = D,
           m2 = F.scalefree(D,m=2,g=2),
           m3 = F.scalefree(D,m=2,g=3),
           m4 = F.scalefree(D,m=2,g=4),
           m5 = F.scalefree(D,m=2,g=5),
           m6 = F.scalefree(D,m=2,g=6),
           m7 = F.scalefree(D,m=2,g=7),
           m8 = F.scalefree(D,m=2,g=8),
           m9 = F.scalefree(D,m=2,g=9)) %>%
  melt(id.vars="D",
       measure.vars=patterns("^m"),
       variable.name="gamma",
       value.name="p") %>%
  mutate(gamma=str_replace(gamma,"m","")) %>%
  ggplot()+
  aes(x=D, y=p, color=gamma, linetype=gamma)+
  geom_line()+
  xlab("degree")+
  ylab("probability")+
  labs(title="Scale-Free Distribution (CDF) with different gamma. (m=2)", color="gamma", linetype="gamma") -> plot
ggsave("scalefree_distribution-cdf.pdf", plot=plot, width=20, height=10, scale=0.4)

D <- seq(2,20,0.1)
data.table(D = D,
           m2 = log(f.scalefree(D,m=2,g=2)),
           m3 = log(f.scalefree(D,m=2,g=3)),
           m4 = log(f.scalefree(D,m=2,g=4)),
           m5 = log(f.scalefree(D,m=2,g=5)),
           m6 = log(f.scalefree(D,m=2,g=6)),
           m7 = log(f.scalefree(D,m=2,g=7)),
           m8 = log(f.scalefree(D,m=2,g=8)),
           m9 = log(f.scalefree(D,m=2,g=9))) %>%
  melt(id.vars="D",
       measure.vars=patterns("^m"),
       variable.name="gamma",
       value.name="p") %>%
  mutate(gamma=str_replace(gamma,"m","")) %>%
  ggplot()+
  aes(x=D, y=p, color=gamma, linetype=gamma)+
  geom_line()+
  xlab("degree")+
  ylab("log-likelihood")+
  labs(title="Scale-Free Distribution (log-PDF) with different gamma. (m=2)", color="gamma", linetype="gamma") -> plot
ggsave("scalefree_distribution-loglikelihood.pdf", plot=plot, width=20, height=10, scale=0.4)
