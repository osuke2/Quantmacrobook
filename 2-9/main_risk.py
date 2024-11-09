import numpy as np
import matplotlib.pyplot as plt
import funcs_risk as tool
from scipy.optimize import fsolve

beta = 0.985**20
gamma = 2.0
rent = 1.025**20 - 1.0
w1 = 1.0
w2 = 1.2
w3 = 0.4
tran = np.array([[0.7451, 0.2528, 0.0021],[0.1360, 0.7281, 0.1360],[0.0021, 0.2528, 0.7451]])
endow = np.array([0.8027, 1, 1.2457])

na = int(21)
a_min = 0.0
a_max = 2.0
grid_a = np.linspace(a_min,a_max,na, dtype=np.float64)
ny = int(3)

a2_nl = np.zeros((na,ny),dtype=np.float64)

for j in range(ny):
    for i in range (na):
        a2 = grid_a[i]
        e2 = endow[j]
        arg = (w2,e2,w3,a2,rent,beta,gamma,)
        a2_nl[i,j] = fsolve(tool.resid_three_period2, [0.01], args = arg)

a1_nl = np.zeros((na,ny))

for  j in range(ny):
    for i in range(na):
        a1 = grid_a[i]
        e1 = [j]
        arg = (a1,w1,e1,endow,w2,e2,tran,ny,grid_a,a2_nl,rent,beta,gamma,)
        a1_nl[i,j] = fsolve(tool.resid_three_period1, [0.01], args = arg)   

plt.figure()
plt.plot(grid_a, a2_nl[:,0], marker='o', color='blue', label='policy')
plt.plot(grid_a, a2_nl[:,1], marker='o', color='blue', label='policy')
plt.plot(grid_a, a2_nl[:,2], marker='o', color='blue', label='policy')
plt.xlabel('asset at middle')
plt.ylabel('asset at old')
plt.grid(True)
plt.xlim(0.0, 2.0)
plt.ylim(0.0, 2.0)
plt.show()

plt.figure()
plt.plot(grid_a, a1_nl[:,0], marker='o', color='blue', label='policy')
plt.plot(grid_a, a1_nl[:,1], marker='o', color='blue', label='policy')
plt.plot(grid_a, a1_nl[:,2], marker='o', color='blue', label='policy')
plt.xlabel('asset at young')
plt.ylabel('asset at middle')
plt.xlim(0.0, 2.0)
plt.ylim(0.0, 2.0)
plt.grid(True)
plt.show()      