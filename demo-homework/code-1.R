#!/usr/bin/env Rscript

data         <- read.csv("data.csv")
linear.model <- lm(y_value ~ x_value, data=data)
summary(linear.model) |> capture.output(file="regression-table.txt")
