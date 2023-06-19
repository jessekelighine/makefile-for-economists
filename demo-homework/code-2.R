#!/usr/bin/env Rscript

data <- read.csv("data.csv")

pdf(file="diagram.pdf")
with(data, plot(x=x_value, y=y_value))
dev.off()
