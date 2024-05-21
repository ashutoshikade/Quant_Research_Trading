# ggplot2

library(ggplot2)

data(mtcars)

ggplot(mtcars) + 
    geom_point(mapping=aes(x=wt, y=mpg), color="firebrick")

ggplot(mtcars) + 
    geom_point(aes(x=wt, y=mpg, color=as.factor(cyl)))

ggplot(mtcars, aes(wt, mpg)) + 
    geom_point() + 
    theme_bw()

ggplot(mtcars, aes(wt, mpg)) + 
    geom_point() + 
    ggtitle("My first scatterplot!", subtitle = "This is a subtitle!") + 
    xlab("Weight") + 
    ylab("Miles per Gallon (MPG)") + 
    theme_bw()

ggplot(mtcars, aes(wt, mpg)) + 
    geom_point() +
    geom_smooth(method="lm", col="red", se=T)

ggplot(mtcars) + 
    geom_histogram(aes(wt), binwidth = 0.05) + 
    theme_bw()




## PRACTICE QUESTIONS

    # 1. Use the 'diamonds' dataset in the 'ggplot2' package to make the following plot:
    #      x is 'log(carat)'
    #      y is 'log(price)'
    #      color the points with a different color for each level of 'clarity'
    #      (you may find that transparency is nice addition here)
    #      use pch to change the point character to a filled-in circle
    #      use cex to make the points small
    #      be sure to label the x-axis and y-axis, and add a title
    #
    #   Run a regression of log(price) on log(carat) using the diamonds dataset and plot
    #   the fitted regression line on the plot. Use lwd to make the line thicker and more noticeable.

    data(diamonds)
    ggplot(diamonds) +
      geom_point(aes(x=log(carat), y=log(price), color=as.factor(clarity))) +
      ggtitle("Price of Diamond Vs Log of Carat") +
      xlab("Log of carat") +
      ylab("Log of Price") +
      theme_bw()
    
    
    
    
