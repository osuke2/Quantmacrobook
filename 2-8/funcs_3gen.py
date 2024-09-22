import numpy as np
from scipy.interpolate import interp1d

def CRRA(cons,gamma):
    mu = cons**-gamma
    return mu


def resid_three_period1(a2,y1,y2,a1,grid_a,a2_nl,rent,beta,gamma):
    coh = y1 + a1
    if coh - a2 >0.0:
        mu1 = CRRA(coh-a2,gamma)
    else:
        mu1 = -10000.0
    
    a3_approx = interp1d(grid_a, a2_nl, kind = 'linear')
    a3_value = a3_approx(a2) 
    cons = (1.0 + rent)*a2 + y2 - a3_value
    mu2 = CRRA(cons,gamma)
    resid1 = beta*(1.0 + rent)*(mu2/mu1) - 1.0
    
    return resid1

def resid_three_period2(a3,y2,y3,a2,rent,beta,gamma):
    coh = (1+rent) * a2 + y2
    if coh - a3 >0.0:
        mu2 = CRRA(coh-a3,gamma)
    else:
        mu2 = -10000.0

    mu3 = CRRA((1 + rent)*a3 + y3, gamma)    
    resid2 = beta*(1.0 + rent)*(mu3/mu2) - 1.0
    return resid2