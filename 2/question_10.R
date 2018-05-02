# we can show analytically that p(N|y) = c*0.99^(N-1)/N  for N = y, y+1,...
# where 1/c = \sum_{N=y}^\infty 0.99^(N-1)/N
# approximate 1/c for y = 203 with a partial sum

N <- 1000

summand <- function(n) 0.99**(n-1)/n
partial_sum <- sum(summand(seq(203, N)))
print(paste("c is approximately: ", 1/partial_sum))


# conditional expectation is c\sum_{N=y}^\infty 0.99^(N-1)
summand2 <- function(n) 0.99**(n-1)
cond_exp <- sum(summand2(seq(203, N))) / partial_sum
print(paste("E(N|y=203) is approximately: ", cond_exp))

# conditional variance is E(N^2|y) - E(N|y)^2
# E(N^2|y) = c\sum_{N=y}^\infty N * 0.99^(N-1)
summand3 <- function(n) n * 0.99**(n-1)
cond_exp_nsq <- sum(summand3(seq(203, N))) / partial_sum
print(paste("sd(N|y=203) is approximately: ", sqrt(cond_exp_nsq - cond_exp**2)))
