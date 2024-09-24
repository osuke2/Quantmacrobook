import numpy as np
from scipy.interpolate import interp1d

def CRRA(cons,gamma):
    mu = cons**-gamma
    return mu

def resid_three_period1(a2,a1,w1,e1,endow,w2,e2,tran,ny,grid_a,a2_nl,rent,beta,gamma):
    coh = (1.0+rent)*a1 + w1*endow[e1] 
    if coh - a2 > 0.0:
        mu1 = CRRA(coh-a2,gamma)
    else:
        mu1 = 10000.0

    mu2 = np.zeros((ny,1))
    for i in range (ny):  
        a3_approx = interp1d(grid_a, a2_nl[:,i], kind = 'linear')
        a3_value = a3_approx(a2) 
        cons = (1.0+rent)*a2 + w2*e2 -a3_value #ここでconsが
        mu2 = CRRA(cons,gamma)

    exp_val = np.dot(tran[e1,:],mu2)
    resid1 = beta*(1.0 + rent)*(exp_val/mu1) - 1.0
    return resid1

def resid_three_period2(a3,w2,e2,w3,a2,rent,beta,gamma):
    coh = (1+rent)*a2 + w2*e2  
    if coh - a3 > 0.0:
        mu2 = CRRA(coh-a3,gamma)
    else:
        mu2 = 10000.0
    mu3 = CRRA((1 + rent)*a3 + w3, gamma)    
    resid2 = beta*(1.0 + rent)*(mu3/mu2) - 1.0
    return resid2