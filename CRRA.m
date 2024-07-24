function util =CRRA(cons,gamma);

if gamma == 1.0
    util = log (cons);
else
    util = cons.^(1-gamma)./(1-gamma);
end
return;


cons = 10;  % 例の消費量
gamma = 2;  % 例のリスク回避度
util = CRRA(cons, gamma);  % 関数呼び出し
disp(util);
end