function value = obj_two_period(a)
%変数をコモン化
global w beta gamma rent
if w - a > 0.0
    util_y = CRRA(w - a, gamma);
else
    util_y=-10000.0;
end
util_o = beta*CRRA((1.0+rent)*a, gamma);
value =-1.0*(util_y + util_o);
return;