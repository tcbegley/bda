# plot distribution from question 1 part a)
library(ggplot2)
library(tibble)

n <- 10000
theta <- rbinom(n, 1, 0.5) + 1
x <- rnorm(n, theta, 2)

g <- ggplot(data=tibble(x)) 
g <- g + geom_histogram(mapping=aes(x=x, y=..density..), bins=50, fill='cyan3') 
g <- g + xlim(-10, 15) + ylim(0, 0.3)
print(g)