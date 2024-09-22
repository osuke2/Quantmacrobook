import numpy as np
import matplotlib.pyplot as plt
import funcs_3gen as tool
from scipy.optimize import fsolve

beta = 0.985**20
gamma = 2.0
rent = 1.025**20 - 1.0
y1 = 1.0
y2 = 1.2
y3 = 0.4

na = int(21)
a_min = 0.0
a_max = 2.0
grid_a = np.linspace(a_min,a_max,na,dtype=np.float64)

a2_nl = np.zeros(na,dtype=np.float64)

for i in range (na):
    a2 = grid_a[i]
    arg = (y2,y3,a2, rent, beta, gamma, )
    a2_nl[i] = fsolve(tool.resid_three_period2, [0.01], args=arg)
    
a1_nl = np.zeros(na)

for i in range (na):
    a1 = grid_a[i]
    arg = (y1,y2,a1,grid_a,a2_nl, rent,beta,gamma, )
    a1_nl[i] = fsolve(tool.resid_three_period1, [0.01], args =arg)

plt.figure()
plt.plot(grid_a, a2_nl, marker='o', color='blue', label='policy')
plt.xlabel('asset at middle')
plt.ylabel('asset at old')
plt.grid(True)
plt.ylim(0.0, 2.0)
plt.show()

plt.figure()
plt.plot(grid_a, a1_nl, marker='o', color='blue', label='policy')
plt.xlabel('asset at young')
plt.ylabel('asset at middle')
plt.ylim(0.0, 2.0)
plt.grid(True)
plt.show()