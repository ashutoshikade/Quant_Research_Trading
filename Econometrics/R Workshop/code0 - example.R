# load a built-in dataset
data(mtcars)

# print the data to the console
print(mtcars)
mtcars

# base plot
plot(mpg ~ wt, data=mtcars)

# better base plot
plot(mpg ~ wt, data=mtcars,
     pch=20, col="dodgerblue4", 
     xlim=c(0,6), ylim=c(0,40),
     xlab="Vehicle Weight",
     ylab="Fuel Efficiency (MPG)", 
     main="My First Plot")

# regress fuel efficiency on vehicle weight
out <- lm(mpg ~ wt, data=mtcars)

# add the regression line
abline(out, col="firebrick", lwd=2)

# ggplot 
install.packages("tidyverse")
library(ggplot2)

ggplot(data=mtcars) + geom_point(aes(wt, mpg))

# better ggplot
ggplot(data=mtcars, aes(wt, mpg)) + 
    geom_point(col="dodgerblue4") + 
    geom_smooth(method="lm", se=FALSE, color="firebrick") + 
    xlab("Vehicle Weight") + 
    ylab("Fuel Efficiency (MPG)") + 
    ggtitle("My first ggplot") + 
    theme_bw()

# regress fuel efficiency on vehicle weight
out <- lm(mpg ~ wt, data=mtcars)
summary(out)

# get beta
coef(out)

# beta by hand
cov(mtcars$mpg, mtcars$wt) / var(mtcars$wt)

# beta by hand with matrices
X <- cbind(1, mtcars$wt)
y <- mtcars$mpg
solve(t(X) %*% X) %*% (t(X) %*% y) 

# beta by hand with functions from the tidyverse
library(dplyr)
mtcars |> summarize(beta = cov(mpg,wt)/var(wt)) 

# beta by hand with data.table
library(data.table)
setDT(mtcars)
mtcars[ , .(beta = cov(mpg,wt)/var(wt))]

# custom function to calculate beta
get_beta <- function(X, y){
    XXinv <- solve(t(X) %*% X) 
    Xy <- t(X) %*% y
    return(XXinv %*% Xy)
}

get_beta(X = cbind(1, mtcars$wt), y = mtcars$mpg)

