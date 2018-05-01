# plot distribution from question 4 part a)
library(ggplot2)
library(tibble)

# wish to sample y given that y|theta ~ Binom(1000, theta) and
# P(theta = 1/12) = P(theta = 1/4) = 1/4 and P(theta = 1/6) = 1/2

n <- 10000

# means and standard deviations of binomial(1000, theta) for theta = 1/12, 1/6, 1/4 resp.
mu <- c(1000/12, 1000/6, 1000/4)
sd <- sqrt(c(11*1000/12**2, 5*1000/6**2, 3*1000/4**2))

# sample from p(y, theta) = p(y|theta)p(theta) by first sampling
# theta from the marginal then y from the conditional distribution
i <- rep(seq(3), rmultinom(1, n, c(0.25, 0.5, 0.25)))
samples <- rnorm(n, mean=mu[i], sd=sd[i])

g <- ggplot(data=tibble(samples)) 
g <- g + geom_histogram(mapping=aes(x=samples, y=..density..), bins=100, fill='cyan3')
print(g)