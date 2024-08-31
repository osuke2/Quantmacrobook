def inv_mu_CRRA(mu,gamma):
    cons = mu**(-1/gamma)
    return cons

def CRRA(cons,gamma):
    mu = cons**-gamma
    return mu

def rhs_euler(asset, gamma, rent, beta):
    cons = (1.0+rent)*asset
    mu = CRRA(cons,gamma)
    rhs = beta*(1.0+rent)*mu
    return rhs