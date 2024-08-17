function next_a = policy(coef,eval)
global dim_app nw
%(nw)×(dim_app+1)行列作る、a行b列の要素をevalのa行目の要素のbー1乗にする、XX×coefする。

XX = zeros(nw,dim_app+1);
for i = 0:dim_app
    XX(:,i+1) = eval.^i;
end

next_a = XX*coef';

return;