def CRRA(cons,gamma):
    import math
    if not gamma == 1:
        util = cons**(1-gamma)/(1-gamma)
    else:
        util = math.log(cons)
    return util

def mu_CRRA(cons,gamma):
    mu = cons**-gamma
    return mu

def obj_two_period(rent,gamma,a,w,beta):
    if w-a >0.0:
        util1 = CRRA(w-a,gamma)
    else:
        util1 = -100000.0

    util2 = beta*CRRA((1.0+rent)*a,gamma)

    obj = -1.0*(util1 + util2)#because of minimization
    return obj
