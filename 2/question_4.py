"""
This is code associate with question 2.4 in Bayesian Data Analysis - Third
Edition by Gelman et al.

It samples from an summarises the following distribution described in the
question.

Let y be the number of 6's from rolling a (potentially unfair) die. Let theta
be the probability of getting a 6. We assume the following prior distribution
on theta:

p(theta = 1/12) = p(theta = 1/4) = 1/4, p(theta = 1/6) = 1/2

All the code below samples from the prior predictive distribution

p(y) = \sum_{theta} p(theta)p(y | theta)
"""
import matplotlib.pyplot as plt
import numpy as np


def gen_thetas(n=1000):
    """
    Generate thetas according to prior.
    """
    def theta(x):
        if x < 0.25:
            return 1 / 12
        elif 0.25 <= x < 0.75:
            return 1 / 6
        elif 0.75 <= x < 1:
            return 1 / 4
        return -1
    return np.array([theta(x) for x in np.random.uniform(size=n)])


def sample(n=1000):
    """
    Generate n samples from the distribution.
    """
    thetas = gen_thetas(n)
    samples = np.random.normal(
        1000 * thetas,
        np.sqrt(1000 * thetas * (1 - thetas))
    )
    return samples


def plot_distribution(n=1000):
    """
    Plot distribution based on n samples.
    """
    samples = sample(n)
    f, ax = plt.subplots()
    ax.hist(samples, bins=50)
    plt.show()


def percentiles(n=1000, percentiles=None):
    """
    Calculate the passed percentiles for the distribution based on n samples.
    """
    samples = sample(n)
    if percentiles is None:
        percentiles = [5, 25, 50, 75, 95]
    return [np.percentile(samples, p) for p in percentiles]


if __name__ == "__main__":
    percentiles()
