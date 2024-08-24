function next_a = policy(coef,eval)
global dim_app nw

% (nw)×(dim_app+1)行列作る、a行b列の要素をevalのa行目の要素のbー1乗にする、XX×coefする。
% 行数は所得グリッドで決まる、列数は近似する関数の項の数、今回はα＋βwで近似するので二つ
XX = zeros(nw,dim_app+1);
for i = 0:dim_app
    XX(:,i+1) = eval.^i;
end

next_a = XX*coef';
% 出来上がるnext_aは全ての要素がα＋β×evalのnw×1行列
return;