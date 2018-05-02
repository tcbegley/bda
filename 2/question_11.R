# y_i ~ Cauchy(theta, 1), so p(y_i|theta) proportional to 1/(1+(y_i-theta)^2) for i = 1,...,5
# calculate unnormalised posterior on grid given prior p(theta) = Unif(theta|0, 100)
library(ggplot2)
library(tibble)

# number of grid points
m <- 10000

# make grid for theta values
theta <- seq(0, 100, length.out = m+1)

# data
y <- c(43, 44, 45, 46.5, 47.5)

# initialise uniform prior on grid
p <- rep(1, m+1)

# calculate unnormalised posterior by multiplying by likelihoods
for (x in y) {
   p <- p * dcauchy(x, location=theta)
}

# normalise
midpoints <- (p[1:m] + p[2:m+1])/2
int_p <- sum(midpoints) * 100 / m
p <- p / int_p

# plot
g <- ggplot(data=tibble(theta, p)) + geom_line(mapping=aes(x=theta, y=p))
g <- g + xlim(0, 100)
print(g)


# sample from posterior
th <- sample(theta, 1000, prob=p, replace=TRUE)
g <- ggplot(data=tibble(th)) + geom_histogram(mapping=aes(x=th, y=..density..), bins=100)
g <- g + xlim(25, 65)
print(g)


# sample from predictive distribution
# p(y_tilde, theta|y) = p(y_tilde|theta)p(theta|y) 
# since y_tilde conditionally independent of y given theta
y_tilde <- rcauchy(1000, location=th)
g <- ggplot(data=tibble(y_tilde))
g <- g + geom_histogram(mapping=aes(x=y_tilde, y=..density..), bins=100)
g <- g + xlim(25, 65)
print(g)
