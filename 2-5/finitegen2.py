import numpy as np
import matplotlib.pyplot as plt
import funcs as tool
from scipy.optimize import fmin

beta = 0.985**30
gamma = 2.0
rent = 1.025**30-1.0

nw = int(10)
w_max = 1.0
w_min = 0.1
grid_w = np.linspace(w_min,w_max,nw)

pol_a = np.zeros(nw)

for i in range (nw):
    arg = (grid_w[i], beta, gamma, rent,)
    pol_a[i] = fmin(tool.obj_two_period, [0.00001], args=arg)

plt.figure()
plt.plot(grid_w,pol_a)
plt.ylim(0, 0.5)
plt.show()
