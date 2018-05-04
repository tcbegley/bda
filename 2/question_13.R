library(ggplot2)
library(tibble)

# accident data
accident.data <- tibble(
  year = seq(1976, 1985),
  fatal.accidents = c(24, 25, 31, 31, 22, 21, 26, 20, 16, 22),
  passenger.deaths = c(734, 516, 754, 877, 814, 362, 764, 809, 223, 1066),
  death.rate = c(0.19, 0.12, 0.15, 0.16, 0.14, 0.06, 0.13, 0.13, 0.03, 0.15)
)

# alpha and beta for prior distribution
alpha <- 0.5
beta <- 0

# sample size
n <- 10000

# assume number of fatal accidents each year independent Poisson(theta)
# if y|theta ~ Poisson(theta) and theta ~ Gamma(alpha, beta) then
# posterior theta|y ~ Gamma(alpha + sum(y), beta + length(y))
theta <- rgamma(
  n,
  shape = alpha + sum(accident.data$fatal.accidents),
  rate = beta + length(accident.data$fatal.accidents)
)

y_1986 <- rpois(length(theta), theta)

g <- ggplot(data = tibble(y_1986))
g <- g + geom_histogram(
  mapping = aes(x = y_1986, y = ..density..),
  center = 0,
  binwidth = 1,
  colour = "black",
  fill = "cyan3"
)
print(g)

print("95% posterior interval for 1986:")
print(quantile(y_1986, probs = c(0.025, 0.975)))

# assume fatal accidents y are independent Poisson with constant rate and exposure
# proportional to the number of passenger miles flown, y_i ~ Poisson(theta * x_i) 
# then with prior on theta as above
# p(y|theta) proportional to theta^(sum_i y_i)exp(-sum_i x_i*theta)
# so theta|y ~ Gamma(alpha+sum_i y_i, beta+sum_i x_i)
theta <- rgamma(
  n,
  shape = alpha + sum(accident.data$fatal.accidents),
  rate = beta + sum(accident.data$passenger.deaths /
                      (accident.data$death.rate * 1000))
)

y_1986 <- rpois(length(theta), theta * 8)

g <- ggplot(data = tibble(y_1986))
g <- g + geom_histogram(
  mapping = aes(x = y_1986, y = ..density..),
  center = 0,
  binwidth = 1,
  colour = "black",
  fill = "cyan3"
)
print(g)


print("95% posterior interval for 1986:")
print(quantile(y_1986, probs = c(0.025, 0.975)))

# repeat the above replacing fatal accidents with passenger deaths

# assume number of passenger deaths each year independent Poisson(theta)
# if y|theta ~ Poisson(theta) and theta ~ Gamma(alpha, beta) then
# posterior theta|y ~ Gamma(alpha + sum(y), beta + length(y))
theta <- rgamma(
  n,
  shape = alpha + sum(accident.data$passenger.deaths),
  rate = beta + length(accident.data$passenger.deaths)
)

y_1986 <- rpois(length(theta), theta)

g <- ggplot(data = tibble(y_1986))
g <- g + geom_histogram(
  mapping = aes(x = y_1986, y = ..density..),
  center = 0,
  binwidth = 5,
  colour = "black",
  fill = "cyan3"
)
print(g)

print("95% posterior interval for 1986:")
print(quantile(y_1986, probs = c(0.025, 0.975)))


# assume passenger deaths y are independent Poisson with constant rate and exposure
# proportional to the number of passenger miles flown, y_i ~ Poisson(theta * x_i) 
# then with prior on theta as above
# p(y|theta) proportional to theta^(sum_i y_i)exp(-sum_i x_i*theta)
# so theta|y ~ Gamma(alpha+sum_i y_i, beta+sum_i x_i)
theta <- rgamma(
  n,
  shape = alpha + sum(accident.data$passenger.deaths),
  rate = beta + sum(accident.data$passenger.deaths /
                      (accident.data$death.rate * 1000))
)

y_1986 <- rpois(length(theta), theta * 8)

g <- ggplot(data = tibble(y_1986))
g <- g + geom_histogram(
  mapping = aes(x = y_1986, y = ..density..),
  center = 0,
  binwidth = 5,
  colour = "black",
  fill = "cyan3"
)
print(g)


print("95% posterior interval for 1986:")
print(quantile(y_1986, probs = c(0.025, 0.975)))
