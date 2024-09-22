import numpy as np
import matplotlib.pyplot as plt
import funcs_EGM as tool
from scipy.optimize import minimize

beta = 0.985**30
gamma = 2.0
rent = 1.025**30-1.0

na = int(11)
a_min = 0.0
a_max = 0.4
grid_a = np.linspace(a_min, a_max, na)

rhs = np.zeros(na)
cons = np.zeros(na)

for i in range (na):
    rhs[i] = tool.rhs_euler(grid_a[i], gamma, rent, beta)
    cons[i] = tool.inv_mu_CRRA(rhs[i], gamma)

w = np.zeros(na)
for i in range (na):
    w[i] = cons[i] + grid_a[i]

plt.figure()
plt.plot(w, grid_a, marker='o', color='blue', label='policy')
plt.grid(True)
plt.show()

# オイラー方程式にaを代入して、効用関数の一階微分の逆関数から最適消費を求められて、minimizationがいらない！