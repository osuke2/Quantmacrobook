import numpy as np
def calibration():
    beta = 0.985**30
    gamma = 2.0
    rent = 1.025**30-1.0
    na = 11
    a_max = 0.4
    a_min = 0.0
    grid_a = np.linspace(a_min, a_max, na)