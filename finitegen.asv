function util =CRRA(cons,gamma);
if gamma == 1
    util = log (cons);
else
    util = cons.^(1-gamma)./(1-gamma);
end
end
return;

beta = 0.985.^30;
gamma = 2.0;
rent = 1.025.^30-1.0;

nw = 10;
w_max = 10;
w_min =0.1;
na = 40;
a_max = 1.0;
a_min = 0.025;

grid_w = linspace(w_min,w_max,nw);
grid_a = linspace(a_min,a_max,na);

util2 = CRRA((1.0+rent).*grid_a, gamma);
util1 = CRRA(grid_w-grid_a, gamma);