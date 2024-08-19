function residual = resid_projection(coef)

global grid_w beta gamma rent;

p = policy(coef,grid_w);

c1 = grid_w - p;

%c1っていう行列のサイズ e.g.)c1が2×3ならsize(c1)=[2,3]
[r,c] = size(c1);

% rとcの大きい方
ng = max (r,c);

mu1 = zeros(ng,1);
for i = 1:ng
    if c1(i)>0.0
        mu1(i) = mu_CRRA(c1(i),gamma);
    else
        mu1(i) = 10000.0;
    end
end

c2 = (1.0+rent).*p;

mu2 = zeros(ng,1);
for i = 1:ng
    if c1(i)>0.0
        mu2(i) = mu_CRRA(c2(i),gamma);
    else
        mu2(i) = 10000.0;
    end
end

residual = beta*(1.0+rent)*(mu2./mu1)-1.0;

return;
