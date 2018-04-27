# probability favourite wins given point spread = 8
print(1 - pnorm(-8.5/14))

# probability favourite wins by at least 8 given point spread = 8
print(1 - pnorm(-0.5/14))

# probability favourite wins by at least 8 given point spread = 8 and favourite wins
print(0.5/(1 - pnorm(-8.5/14)))